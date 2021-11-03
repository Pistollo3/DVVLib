# Generated:Thu Aug  5 10:50:00 PDT 2021
# XCODE_VERSION:Xcode12.5.1
Pod::Spec.new do |s|
  s.name = 'VFGMVA10Purchase'
  s.module_name = 'VFGMVA10Purchase'
  s.version = "1.2.1"
  s.summary = "Vodafone Group Purchase Component"
  s.homepage = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Purchase'
  s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
  s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
  s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Purchase.git", :tag => "1.2.0" }
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.source_files = 'VFGMVA10Purchase/VFGMVA10Purchase/Classes/**/*.{h,m,swift}'
  s.resources = 'VFGMVA10Purchase/VFGMVA10Purchase/Resources/**/*.{xib,storyboard,xcassets,lproj}'
  s.dependency 'VFGMVA10Foundation', '1.23.0'
end
