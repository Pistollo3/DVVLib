# Generated:Mon Jun  7 10:33:31 PDT 2021
# XCODE_VERSION:Xcode12.3
Pod::Spec.new do |s|
  s.name = 'VFGMVA10Login'
  s.module_name = 'VFGMVA10Login'
  s.version = "1.18.0"
  s.summary = "Vodafone Group MVA10 Login Component"
  s.homepage = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10'
  s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
  s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
  s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Login.git", :tag => "1.18.0" }
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.source_files = 'VFGMVA10Login/VFGMVA10Login/Classes/**/*.{h,m,swift}'
  s.resources = 'VFGMVA10Login/VFGMVA10Login/Resources/**/*.{xib,storyboard,xcassets,lproj}'
  s.dependency 'VFGMVA10Foundation', '1.20.0'
end
