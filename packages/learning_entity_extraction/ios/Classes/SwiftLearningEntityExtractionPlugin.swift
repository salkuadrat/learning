import Flutter
import UIKit

import MLKit

public class SwiftLearningEntityExtractionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "LearningEntityExtraction", binaryMessenger: registrar.messenger())
    let instance = SwiftLearningEntityExtractionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    setModelManager(registrar)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "extract" {
      extract(call, result)
    } else if call.method == "dispose" {
      dispose(result)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  func extract(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments else {
      result(FlutterError(
        code: "NOARGUMENTS", 
        message: "No arguments",
        details: nil))
      return
    }

    let modelIdentifier: String? = args["model"]
    let text: String? = args["text"]

    if modelIdentifier == nil || text == nil {
      result(FlutterError(
        code: "NOTEXT", 
        message: "No argument text",
        details: nil))
      return
    }

    let options = EntityExtractorOptions(modelIdentifier: modelIdentifier)
    let extractor = EntityExtractor.entityExtractor(options: options)
    
    extractor.downloadModelIfNeeded(completion: {
      extractor.annotateText(
        text.string,
        params: EntityExtractionParams(),
        completion: { annotations, error in
          if error != nil {
            result(FlutterError(
              code: "FAILED", 
              message: "Entity extraction failed with error: \(error!)",
              details: error))
            return
          }

          let result = []

          for annotation in annotations {
            let item = [
              "annotation": annotation.annotatedText,
              "start": annotation.start,
              "end": annotation.end
            ]

            let entities = annotation.entities

            for entity in entities {
              
            }
          }
        }
      )
    })
  }

  func dispose(result: @escaping FlutterResult) {
    result(true)
  }

  func setModelManager(registrar: FlutterPluginRegistrar) {
    let modelManagerChannel = FlutterMethodChannel(
      name: "LearningEntityModelManager", binaryMessenger: registrar.messenger())
    
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
    let models = modelManager.downloadedEntityExtractionModels.map { $0.modelIdentifier }
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

    let modelIdentifier: String? = args["model"]

    if modelIdentifier == nil {
      result(FlutterError(
        code: "INCARGUMENTS", 
        message: "Incomplete arguments",
        details: nil))
      return
    }

    let modelManager = ModelManager.modelManager()
    let downloadedModels = Set(modelManager.downloadedEntityExtractionModels.map { $0.modelIdentifier })
    let isDownloaded = downloadedModels.contains(modelIdentifier)

    result(isDownloaded)
  }

  func downloadModel(call: FlutterMethodCall, result: FlutterResult) {
    guard let args = call.arguments else {
      result(FlutterError(
        code: "NOARGUMENTS", 
        message: "No arguments",
        details: nil))
      return
    }

    let modelIdentifier: String? = args["model"]
    let isRequireWifi: Bool = args["isRequireWifi"] ?? true

    if modelIdentifier == nil {
      result(FlutterError(
        code: "INCARGUMENTS", 
        message: "Incomplete arguments",
        details: nil))
      return
    }

    let model = EntityExtractorRemoteModel.entityExtractorRemoteModel(identifier: modelIdentifier)
    let modelManager = ModelManager.modelManager()
    let conditions = ModelDownloadConditions(
      allowsCellularAccess: !isRequireWifi,
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

    let modelIdentifier: String? = args["model"]

    if modelIdentifier == nil {
      result(FlutterError(
        code: "INCARGUMENTS", 
        message: "Incomplete arguments",
        details: nil))
      return
    }

    let model = EntityExtractorRemoteModel.entityExtractorRemoteModel(identifier: modelIdentifier)
    let modelManager = ModelManager.modelManager()
    
    modelManager.deleteDownloadedModel(model) { error in 
      result(true)
    }
  }
}
