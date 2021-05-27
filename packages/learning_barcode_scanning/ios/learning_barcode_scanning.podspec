#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint learning_barcode_scanning.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'learning_barcode_scanning'
  s.version          = '0.0.2'
  s.summary          = 'Learning Barcode Scanning.'
  s.description      = <<-DESC
  The easy way to use ML Kit for barcode scanning in Flutter.
                       DESC
  s.homepage         = 'https://github.com/salkuadrat/learning/tree/master/packages/learning_barcode_scanning'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Salman S' => 'salkuadrat@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'GoogleMLKit/BarcodeScanning'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
