#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint learning_pose_detection.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'learning_pose_detection'
  s.version          = '0.0.1'
  s.summary          = 'Learning Pose Detection.'
  s.description      = <<-DESC
  The easy way to use ML Kit for pose detection in Flutter.
                       DESC
  s.homepage         = 'https://github.com/salkuadrat/learning/tree/master/packages/learning_pose_detection'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Salman S' => 'salkuadrat@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'GoogleMLKit/PoseDetection'
  s.dependency 'GoogleMLKit/PoseDetectionAccurate'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
