#import "LearningPlugin.h"
#if __has_include(<learning/learning-Swift.h>)
#import <learning/learning-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning-Swift.h"
#endif

@implementation LearningPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningPlugin registerWithRegistrar:registrar];
}
@end
