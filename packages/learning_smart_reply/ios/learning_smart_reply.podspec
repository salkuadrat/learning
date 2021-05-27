#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint learning_smart_reply.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'learning_smart_reply'
  s.version          = '0.0.1'
  s.summary          = 'Learning Smart Reply.'
  s.description      = <<-DESC
  The easy way to use ML Kit for generating smart replies in Flutter.
                       DESC
  s.homepage         = 'https://github.com/salkuadrat/learning/tree/master/packages/learning_smart_reply'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Salman S' => 'salkuadrat@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'GoogleMLKit/SmartReply'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
