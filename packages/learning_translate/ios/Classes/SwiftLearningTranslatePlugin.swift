import Flutter
import UIKit

import MLKit

public class SwiftLearningTranslatePlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "LearningTranslate", binaryMessenger: registrar.messenger())
    let instance = SwiftLearningTranslatePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
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
    let isDownloadRequireWifi: Bool = args["isDownloadRequireWifi"] ?? false
    
    if source == nil || target == nil || text == nil {
      result(FlutterError(
        code: "NCARGUMENTS", 
        message: "Not complete arguments",
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
}
