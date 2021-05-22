import Flutter
import UIKit

public class SwiftLearningDigitalInkRecognitionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "learning_digital_ink_recognition", binaryMessenger: registrar.messenger())
    let instance = SwiftLearningDigitalInkRecognitionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
