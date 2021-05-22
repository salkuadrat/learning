#import "LearningDigitalInkRecognitionPlugin.h"
#if __has_include(<learning_digital_ink_recognition/learning_digital_ink_recognition-Swift.h>)
#import <learning_digital_ink_recognition/learning_digital_ink_recognition-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning_digital_ink_recognition-Swift.h"
#endif

@implementation LearningDigitalInkRecognitionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningDigitalInkRecognitionPlugin registerWithRegistrar:registrar];
}
@end
