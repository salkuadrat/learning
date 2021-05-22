#import "LearningTranslatePlugin.h"
#if __has_include(<learning_translate/learning_translate-Swift.h>)
#import <learning_translate/learning_translate-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning_translate-Swift.h"
#endif

@implementation LearningTranslatePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningTranslatePlugin registerWithRegistrar:registrar];
}
@end
