#import "LearningFaceDetectionPlugin.h"
#if __has_include(<learning_face_detection/learning_face_detection-Swift.h>)
#import <learning_face_detection/learning_face_detection-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning_face_detection-Swift.h"
#endif

@implementation LearningFaceDetectionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningFaceDetectionPlugin registerWithRegistrar:registrar];
}
@end
