#import "LearningEntityExtractionPlugin.h"
#if __has_include(<learning_entity_extraction/learning_entity_extraction-Swift.h>)
#import <learning_entity_extraction/learning_entity_extraction-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning_entity_extraction-Swift.h"
#endif

@implementation LearningEntityExtractionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningEntityExtractionPlugin registerWithRegistrar:registrar];
}
@end
