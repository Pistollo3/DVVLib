# Generated:Wed Oct 13 04:14:19 PDT 2021
# XCODE_VERSION:Xcode12.5.1
Pod::Spec.new do |s|
  s.name          = 'VFGSOHOFramework'
  s.module_name   = 'VFGSOHOFramework'
  s.version       = "1.2.0"
  s.summary       = "Vodafone Group SOHO Framework Component"
  s.homepage      = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-SOHO-FRAMEWORK'
  s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
  s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
  s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-SOHO-Framework.git", :tag => "1.2.0" }
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  s.source_files  = 'VFGSOHOFramework/VFGSOHOFramework/**/*.{swift}'
  s.resources     = 'VFGSOHOFramework/VFGSOHOFramework/**/*.{ttf,xib,storyboard,xcassets,json,lproj}'
  s.dependency 'VFGMVA10Foundation', '1.26.0'
  s.dependency 'VFGMVA10Billing', '1.17.0'
  s.dependency 'VFGMVA10Framework', '1.17.0'
  s.requires_arc  = true
end
