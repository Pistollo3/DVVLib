# Generated:Wed Oct 13 06:06:00 PDT 2021
# XCODE_VERSION:Xcode12.5.1
Pod::Spec.new do |s|
  s.name = 'VFGMVA10EShop'
  s.module_name = 'VFGMVA10EShop'
  s.version = "0.1.0"
  s.summary = "Vodafone Group EShop Component"
  s.homepage = 'https://github.vodafone.com/TSS-MyVodafone-CoreApp/iOS-MVA10-eShop'
  s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
  s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
  s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-eShop.git", :tag => "0.1.0-Beta" }
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.source_files = 'VFGMVA10EShop/VFGMVA10EShop/**/*.{h,m,xib,storyboard,swift}'
  s.resources = 'VFGMVA10EShop/VFGMVA10EShop/**/*.{xcassets,json,lproj}'
  s.dependency 'VFGMVA10Foundation'
end
