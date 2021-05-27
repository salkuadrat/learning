#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint learning_object_detection.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'learning_object_detection'
  s.version          = '0.0.1'
  s.summary          = 'Learning Object Detection.'
  s.description      = <<-DESC
  The easy way to use ML Kit for object detection & tracking in Flutter.
                       DESC
  s.homepage         = 'https://github.com/salkuadrat/learning/tree/master/packages/learning_object_detection'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Salman S' => 'salkuadrat@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'GoogleMLKit/ObjectDetection'
  s.dependency 'GoogleMLKit/ObjectDetectionCustom'
  s.dependency 'GoogleMLKit/LinkFirebase'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
