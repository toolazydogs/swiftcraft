Pod::Spec.new do |s|
  s.name             = "Swiftcraft"
  s.version          = "0.1.0"
  s.summary          = "A Swift Minecraft client API."

  s.homepage         = "https://github.com/toolazydogs/swiftcraft"
  s.license          = { :type => "Apache License 2.0", :file => "LICENSE" }
  s.author           = { "Alan Cabrera" => "adc@toolazydogs.com" }
  s.source           = { :git => "https://github.com/toolazydogs/swiftcraft.git", :tag => s.version.to_s }
  s.social_media_url = 'https://toolazydogs.slack.com/messages/swiftcraft'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Swiftcraft/Classes/*.swift'

  s.dependency 'AFNetworking', '~> 3.1'
end
