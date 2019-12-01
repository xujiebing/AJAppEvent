
Pod::Spec.new do |s|
  s.name             = 'AJAppEvent'
  s.version          = '1.0.4'
  s.summary          = 'A short description of AJAppEvent.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/xujiebing/AJAppEvent'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xujiebing' => 'xujiebing1992@gmail.com' }
  s.source           = { :git => 'https://github.com/xujiebing/AJAppEvent.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AJAppEvent/Classes/*'
  s.prefix_header_file = 'AJAppEvent/Classes/AJAppEvent.pch'
  
  # s.resource_bundles = {
  #   'AJAppEvent' => ['AJAppEvent/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
