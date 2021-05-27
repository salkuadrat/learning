import Flutter
import UIKit

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

  func translate(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

  }
}
