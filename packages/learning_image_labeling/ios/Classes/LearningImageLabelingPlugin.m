#import "LearningImageLabelingPlugin.h"
#if __has_include(<learning_image_labeling/learning_image_labeling-Swift.h>)
#import <learning_image_labeling/learning_image_labeling-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning_image_labeling-Swift.h"
#endif

@implementation LearningImageLabelingPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningImageLabelingPlugin registerWithRegistrar:registrar];
}
@end
