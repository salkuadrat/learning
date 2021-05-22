#import "LearningSmartReplyPlugin.h"
#if __has_include(<learning_smart_reply/learning_smart_reply-Swift.h>)
#import <learning_smart_reply/learning_smart_reply-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning_smart_reply-Swift.h"
#endif

@implementation LearningSmartReplyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningSmartReplyPlugin registerWithRegistrar:registrar];
}
@end
