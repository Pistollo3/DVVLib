Pod::Spec.new do |s|
  s.name = "NetPerformSDK"
  s.version = "6.0.1"
  s.summary = "iOS NetPerform SDK"
  s.license = {"type"=>"Copyright © 2018 Vodafone Group Services GmbH. All Rights Reserved."}
  s.authors = {"NetPerform SDK Support"=>"netperformSDK@vodafone.com"}
  s.homepage = "http://www.vodafone.com"
  s.description = "iOS NetPerform SDK is a service to measure the network quality metrics and the usage of the device.\n\nPlease ensure that your developers align your host app UX to the latest Group Commerical guidelines \nand contact our support in case of any questions!"
  s.frameworks = ["CoreLocation", "CoreTelephony", "Security", "SystemConfiguration", "CoreGraphics", "UIKit", "WebKit", "WatchConnectivity"]
  s.libraries = ["sqlite3", "z"]
  s.requires_arc = true
  s.source = { :git => "https://github.vodafone.com/VFCPS-NetPerform/NetPerform-iOS-SDK.git", :tag => '6.0.1' }

  s.ios.deployment_target    = '10.0'
  s.ios.vendored_framework   = 'Framework/NetPerformSDK.framework'
end
