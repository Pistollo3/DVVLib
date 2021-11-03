# Generated:Tue Jun  8 10:02:19 PDT 2021
# XCODE_VERSION:Xcode12.3
Pod::Spec.new do |s|
  s.name = 'VFGMVA10Billing'
  s.module_name = 'VFGMVA10Billing'
  s.version = "1.13.0"
  s.summary = "Vodafone Group Billing Component"
  s.homepage = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Billing'
  s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
  s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
  s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Billing.git", :tag => "1.13.0" }
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.source_files = 'VFGMVA10Billing/VFGMVA10Billing/Classes/**/*.{h,m,swift}'
  s.resources = 'VFGMVA10Billing/VFGMVA10Billing/Resources/**/*.{xib,storyboard,xcassets,lproj}'
  s.dependency 'VFGMVA10Foundation', '1.20.0'
end
