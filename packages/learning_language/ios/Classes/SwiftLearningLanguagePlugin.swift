import Flutter
import UIKit

import MLKit

public class SwiftLearningLanguagePlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "LearningLanguage", binaryMessenger: registrar.messenger())
    let instance = SwiftLearningLanguagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "identify" {
      identify(call, result)
    } else if call.method == "dispose" {
      dispose(result)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  func identify(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    guard let args = call.arguments else {
      result(FlutterError(
        code: "NOARGUMENTS", 
        message: "No arguments",
        details: nil))
      return
    }

    let text: String? = args["text"]
    let threshold: Float = args["confidenceThreshold"] ?? 0.5
    let isMultipleLanguages: Bool = args["isMultipleLanguages"] ?? false

    if text == nil {
      result(FlutterError(
        code: "NOTEXT", 
        message: "No argument text",
        details: nil))
      return
    }
    
    let options = LanguageIdentificationOptions(confidenceThreshold: threshold)
    let languageId = NaturalLanguage.languageIdentification(options: options)

    if isMultipleLanguages {
      languageId.identifyPossibleLanguages(for: text!) { (identifiedLanguages, error) in
        if let error = error {
          result(FlutterError(
            code: "FAILED", 
            message: "Language identification failed with error: \(error!)",
            details: error))
          return
        }
        
        guard let identifiedLanguages = identifiedLanguages,
          !identifiedLanguages.isEmpty,
          identifiedLanguages[0].languageCode != "und"
        else {
          result(FlutterError(
            code: "UNIDENTIFIED", 
            message: "No language was identified",
            details: nil))
          return
        }

        result(identifiedLanguages.map {[
          "language": $0.languageCode,
          "confidence": $0.confidence
        ]})
      }
    } else {
      languageId.identifyLanguage(for: text!) { (languageCode, error) in
        if let error = error {
          result(FlutterError(
            code: "FAILED", 
            message: "Language identification failed with error: \(error!)",
            details: error))
          return
        }
        
        if let languageCode = languageCode, languageCode != "und" {
          result(languageCode)
        } else {
          result(FlutterError(
            code: "UNIDENTIFIED", 
            message: "No language was identified",
            details: nil))
        }
      }
    }
  }

  func dispose(result: @escaping FlutterResult) {
    result(true)
  }
}
