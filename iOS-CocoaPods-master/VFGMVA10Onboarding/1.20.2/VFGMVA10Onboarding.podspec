# Generated:Thu Aug 12 00:47:00 PDT 2021
# XCODE_VERSION:Xcode12.5.1
Pod::Spec.new do |s|
  s.name = 'VFGMVA10Onboarding'
  s.module_name = 'VFGMVA10Onboarding'
  s.version = "1.20.2"
  s.summary = "Vodafone Group MVA10 Onboarding Component"
  s.homepage = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Onboarding'
  s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
  s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
  s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Onboarding.git", :tag => "1.20.0" }
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.source_files = 'VFGMVA10Onboarding/VFGMVA10Onboarding/Classes/**/*.{h,m,swift}'
  s.resources = 'VFGMVA10Onboarding/VFGMVA10Onboarding/Resources/**/*.{xib,storyboard,xcassets,lproj}'
  s.dependency 'VFGMVA10Foundation', '1.23.1'
end
