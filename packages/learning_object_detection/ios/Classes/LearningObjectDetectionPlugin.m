#import "LearningObjectDetectionPlugin.h"
#if __has_include(<learning_object_detection/learning_object_detection-Swift.h>)
#import <learning_object_detection/learning_object_detection-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning_object_detection-Swift.h"
#endif

@implementation LearningObjectDetectionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningObjectDetectionPlugin registerWithRegistrar:registrar];
}
@end
