import Flutter
import UIKit

import MLKitCommon
import MLKitLanguageID

public class SwiftLearningLanguagePlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "LearningLanguage", binaryMessenger: registrar.messenger())
    let instance = SwiftLearningLanguagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "identify" {
        identify(call, result:result)
    } else if call.method == "dispose" {
        dispose(result:result)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  func identify(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    guard let args = call.arguments as? Dictionary<String, Any> else {
      result(FlutterError(
        code: "NOARGUMENTS", 
        message: "No arguments",
        details: nil))
      return
    }

    let text: String? = args["text"] as? String
    let threshold: Float = args["confidenceThreshold"] as? Float ?? 0.5
    let isMultipleLanguages: Bool = args["isMultipleLanguages"] as? Bool ?? false

    if text == nil {
      result(FlutterError(
        code: "NOTEXT", 
        message: "No argument text",
        details: nil))
      return
    }
    
    let options = LanguageIdentificationOptions(confidenceThreshold: threshold)
    let languageId = LanguageIdentification.languageIdentification(options: options)

    if isMultipleLanguages {
      languageId.identifyPossibleLanguages(for: text!) { (identifiedLanguages, error) in
        guard error == nil else {
          result(FlutterError(
            code: "FAILED", 
            message: "Language identification failed with error: \(error!)",
            details: error))
          return
        }
        
        guard let identifiedLanguages = identifiedLanguages,
          !identifiedLanguages.isEmpty,
          identifiedLanguages[0].languageTag != "und"
        else {
          result(FlutterError(
            code: "UNIDENTIFIED", 
            message: "No language was identified",
            details: nil))
          return
        }

        result(identifiedLanguages.map {[
          "language": $0.languageTag,
          "confidence": $0.confidence
        ]})
      }
    } else {
      languageId.identifyLanguage(for: text!) { (languageCode, error) in
        guard error == nil else  {
          result(FlutterError(
            code: "FAILED", 
            message: "Language identification failed with error: \(error!)",
            details: error))
          return
        }
        
        guard let languageCode = languageCode, 
          languageCode != "und" 
        else {
          result(FlutterError(
            code: "UNIDENTIFIED", 
            message: "No language was identified",
            details: nil))
          return
        }

        result(languageCode)
      }
    }
  }

  func dispose(result: @escaping FlutterResult) {
    result(true)
  }
}
