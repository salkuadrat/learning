#import "LearningSelfieSegmentationPlugin.h"
#if __has_include(<learning_selfie_segmentation/learning_selfie_segmentation-Swift.h>)
#import <learning_selfie_segmentation/learning_selfie_segmentation-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "learning_selfie_segmentation-Swift.h"
#endif

@implementation LearningSelfieSegmentationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLearningSelfieSegmentationPlugin registerWithRegistrar:registrar];
}
@end
