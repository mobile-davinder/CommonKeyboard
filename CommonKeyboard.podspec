Pod::Spec.new do |s|
  s.name = 'CommonKeyboard'
  s.version = '1.0.4'
  s.license = { :type => "MIT", :file => "LICENSE.md" }

  s.summary = 'An elegant Keyboard library for iOS.'
  s.homepage = 'https://github.com/mobile-davinder/CommonKeyboard'
  s.author = { "Kaweerut Kanthawong" => "mobile.davinder.11@gmail.com" }
  s.source = { :git => 'https://github.com/mobile-davinder/CommonKeyboard.git', :tag => s.version }
  s.source_files = 'Sources/*.swift'

  s.pod_target_xcconfig = {
     "SWIFT_VERSION" => "4.2",
  }

  s.swift_version = '4.2'

  s.ios.deployment_target = '9.0'

  s.requires_arc = true

end
