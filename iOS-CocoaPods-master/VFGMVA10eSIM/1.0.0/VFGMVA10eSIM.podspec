# Generated:Sun Jul 11 13:20:40 PDT 2021
# XCODE_VERSION:Xcode12.5.1
Pod::Spec.new do |s|
  s.name             = 'VFGMVA10eSIM'
  s.module_name = 'VFGMVA10eSIM'
  s.version = "1.0.0"
  s.summary = "Vodafone Group eSIM Component"
  s.homepage = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-eSIM'
  s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-eSIM.git", :tag => "1.0.0" }
  s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
  s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'
  s.requires_arc = true
  s.source_files = 'VFGMVA10eSIM/VFGMVA10eSIM/Classes/**/*.{h,m,swift}'
  s.resources = 'VFGMVA10eSIM/VFGMVA10eSIM/Resources/**/*.{xib,storyboard,xcassets,lproj}'
  s.dependency 'VFGMVA10Foundation', '1.22.0'
end


