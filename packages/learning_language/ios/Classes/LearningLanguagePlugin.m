#import "LearningLanguagePlugin.h"
#if __has_include(<learning_language/learning_language-Swift.h>)
#import <learning_language/learning_language-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning_language-Swift.h"
#endif

@implementation LearningLanguagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningLanguagePlugin registerWithRegistrar:registrar];
}
@end
