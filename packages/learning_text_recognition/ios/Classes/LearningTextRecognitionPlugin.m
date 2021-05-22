#import "LearningTextRecognitionPlugin.h"
#if __has_include(<learning_text_recognition/learning_text_recognition-Swift.h>)
#import <learning_text_recognition/learning_text_recognition-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning_text_recognition-Swift.h"
#endif

@implementation LearningTextRecognitionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningTextRecognitionPlugin registerWithRegistrar:registrar];
}
@end
