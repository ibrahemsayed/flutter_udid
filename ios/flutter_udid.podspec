Pod::Spec.new do |s|
  s.name             = 'flutter_udid'
  s.version          = '0.0.1'
  s.summary          = 'Plugin for getting a persistent UDID on iOS and Android'
  s.description      = <<-DESC
Plugin for getting a persistent UDID that remains constant across app reinstalls
on both iOS and Android platforms.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  
  # Source files configuration
  s.source_files = 'Classes/**/*'
  
  # Dependencies
  s.dependency 'Flutter'
  s.dependency 'SAMKeychain', '~> 1.5'
  
  # Platform requirements
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  
  # Build settings
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64' # Exclude both i386 and arm64 for simulator
  }
end
