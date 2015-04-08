Pod::Spec.new do |s|
  s.name         = "SuperAwesome"
  s.version      = "1.2.0"
  s.summary      = "SuperAwesome Mobile SDK for iOS"

  s.description  = <<-DESC
                   The SuperAwesome Mobile SDK lets you to easily add COPPA compliant advertisements and other platform features, like user authentication and registration, to your apps. We try to make integration as easy as possible, so we provide all the necessary tools such as this guide, API documentation, screencasts and demo apps.
                   DESC

  s.homepage     = "http://developers.superawesome.tv/docs/iossdk"
  s.documentation_url = 'http://developers.superawesome.tv/docs/iossdk'
  s.license      = { :type => "CREATIVE COMMONS PUBLIC LICENSE", :file => "LICENSE.txt" }
  s.author             = { "Balazs Kiss" => "balazs@superawesome.tv" }

  s.platform     = :ios, "6.0"
  s.ios.deployment_target = "6.0"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/SuperAwesomeLTD/sa-mobile-sdk-ios.git", :tag => "1.2.0" }
  
  s.default_subspec = 'Default'

  s.subspec 'Core' do |core|
    core.dependency "JSONModel", "~> 1.0.2"
    core.vendored_frameworks = 'Frameworks/ADTECHMobileSDK.framework'
    core.frameworks = 'AVFoundation', 'AudioToolbox', 'CFNetwork', 'CoreGraphics', 'CoreData', 'CoreLocation', 'CoreMedia', 'CoreMotion', 'CoreTelephony', 'EventKit', 'MediaPlayer', 'MessageUI', 'MobileCoreServices', 'QuartzCore', 'Security', 'SystemConfiguration', 'StoreKit', 'AdSupport', 'EventKitUI'
    core.libraries = "xml2", "z"
    core.source_files  = "SuperAwesome"
    core.resources = "SuperAwesome/Resources/*"
  end

  s.subspec 'Default' do |default|
    default.dependency 'SuperAwesome/Core'
    default.dependency "GoogleAds-IMA-iOS-SDK", "~> 3.0.beta.12"
  end

  s.subspec 'AdMob' do |admob|
    admob.dependency 'SuperAwesome/Core'
    admob.dependency "GoogleAds-IMA-iOS-SDK-For-AdMob", "~> 3.0.beta.12"
  end
end