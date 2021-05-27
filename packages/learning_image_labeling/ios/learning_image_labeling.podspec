#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint learning_image_labeling.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'learning_image_labeling'
  s.version          = '0.0.1'
  s.summary          = 'Learning Image Labeling.'
  s.description      = <<-DESC
  The easy way to use ML Kit for image labeling in Flutter.
                       DESC
  s.homepage         = 'https://github.com/salkuadrat/learning/tree/master/packages/learning_image_labeling'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Salman S' => 'salkuadrat@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'GoogleMLKit/ImageLabeling'
  s.dependency 'GoogleMLKit/ImageLabelingCustom'
  s.dependency 'GoogleMLKit/LinkFirebase'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
