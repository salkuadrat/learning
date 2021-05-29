import Flutter
import UIKit

import MLKit

public class SwiftLearningTranslatePlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "LearningTranslate", binaryMessenger: registrar.messenger())
    let instance = SwiftLearningTranslatePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    setModelManager(registrar)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "translate" {
      translate(call, result)
    } else if call.method == "dispose" {
      dispose(result)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  func dispose(result: @escaping FlutterResult) {
    result(true)
  }

  func translate(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    guard let args = call.arguments else {
      result(FlutterError(
        code: "NOARGUMENTS", 
        message: "No arguments",
        details: nil))
      return
    }
    
    let source: String? = args["from"]
    let target: String? = args["to"]
    let text: String? = args["text"]
    let isDownloadRequireWifi: Bool = args["isDownloadRequireWifi"] ?? true
    
    if source == nil || target == nil || text == nil {
      result(FlutterError(
        code: "INCARGUMENTS", 
        message: "Incomplete arguments",
        details: nil))
      return
    }

    let options = TranslatorOptions(sourceLanguage: source!, targetLanguage: target!)
    let translator = Translator.translator(options: options)

    let conditions = ModelDownloadConditions(
      allowsCellularAccess: !isDownloadRequireWifi,
      allowsBackgroundDownloading: true
    )

    translator.downloadModelIfNeeded(with: conditions) { error in
      guard error == nil else {
        result(FlutterError(
          code: "FAILED", 
          message: "Download translation model failed with error: \(error!)",
          details: error))
        return
      }

      translator.translate(text!) { translatedText, error in
        guard error == nil, let translatedText = translatedText else {
          result(FlutterError(
            code: "FAILED", 
            message: "Translate text failed with error: \(error!)",
            details: error))
          return
        }
        
        result(translatedText)
      }
    }
  }

  func setModelManager(registrar: FlutterPluginRegistrar) {
    let modelManagerChannel = FlutterMethodChannel(
      name: "LearningTranslationModelManager", binaryMessenger: registrar.messenger())

    modelManagerChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if call.method == "list" {
          listModel(result)
        } else if call.method == "download" {
          downloadModel(call, result)
        } else if call.method == "check" {
          checkModel(call, result)
        } else if call.method == "delete" {
          deleteModel(call, result)
        } else {
          result(FlutterMethodNotImplemented)
        }
    })
  }

  func listModel(result: FlutterResult) {
    let modelManager = ModelManager.modelManager()
    let models = modelManager.downloadedTranslateModels.map { $0.language.rawValue }
    result(models)
  }

  func checkModel(call: FlutterMethodCall, result: FlutterResult) {
    guard let args = call.arguments else {
      result(FlutterError(
        code: "NOARGUMENTS", 
        message: "No arguments",
        details: nil))
      return
    }

    let language: String? = args["model"]

    if language == nil {
      result(FlutterError(
        code: "INCARGUMENTS", 
        message: "Incomplete arguments",
        details: nil))
      return
    }

    let modelManager = ModelManager.modelManager()
    let model = TranslateRemoteModel.translateRemoteModel(language: language!)
    result(modelManager.isModelDownloaded(model))
  }

  func downloadModel(call: FlutterMethodCall, result: FlutterResult) {
    guard let args = call.arguments else {
      result(FlutterError(
        code: "NOARGUMENTS", 
        message: "No arguments",
        details: nil))
      return
    }

    let language: String? = args["model"]
    let isDownloadRequireWifi: Bool = args["isDownloadRequireWifi"] ?? true

    if language == nil {
      result(FlutterError(
        code: "INCARGUMENTS", 
        message: "Incomplete arguments",
        details: nil))
      return
    }

    let modelManager = ModelManager.modelManager()
    let model = TranslateRemoteModel.translateRemoteModel(language: language!)
    let conditions = ModelDownloadConditions(
      allowsCellularAccess: !isDownloadRequireWifi,
      allowsBackgroundDownloading: true
    )

    modelManager.download(model, conditions: conditions)
    result(true)
  }

  func deleteModel(call: FlutterMethodCall, result: FlutterResult) {
    guard let args = call.arguments else {
      result(FlutterError(
        code: "NOARGUMENTS", 
        message: "No arguments",
        details: nil))
      return
    }

    let language: String? = args["model"]
    
    if language == nil {
      result(FlutterError(
        code: "INCARGUMENTS", 
        message: "Incomplete arguments",
        details: nil))
      return
    }

    let modelManager = ModelManager.modelManager()
    let model = TranslateRemoteModel.translateRemoteModel(language: language!)
    modelManager.deleteDownloadedModel(model) { error in
      result(true)
    }
  }
}
