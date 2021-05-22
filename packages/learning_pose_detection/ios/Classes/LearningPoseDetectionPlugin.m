#import "LearningPoseDetectionPlugin.h"
#if __has_include(<learning_pose_detection/learning_pose_detection-Swift.h>)
#import <learning_pose_detection/learning_pose_detection-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning_pose_detection-Swift.h"
#endif

@implementation LearningPoseDetectionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningPoseDetectionPlugin registerWithRegistrar:registrar];
}
@end
