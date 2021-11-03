# Generated:Tue Mar  2 03:40:26 PST 2021
# XCODE_VERSION:Xcode12.3
Pod::Spec.new do |s|
  s.name = 'VFGMVA10Onboarding'
  s.module_name = 'VFGMVA10Onboarding'
  s.version = "1.16.0"
  s.summary = "Vodafone Group MVA10 Onboarding Component"
  s.homepage = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10'
  s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
  s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
  s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Onboarding.git", :tag => "1.16.0" }
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.source_files = 'VFGMVA10Onboarding/VFGMVA10Onboarding/Classes/**/*.{h,m,swift}'
  s.resources = 'VFGMVA10Onboarding/VFGMVA10Onboarding/Resources/**/*.{xib,storyboard,xcassets,lproj}'
  s.dependency 'VFGMVA10Foundation'
end
