# Generated:Tue Jul 27 07:30:52 PDT 2021
# XCODE_VERSION:Xcode12.5.1
Pod::Spec.new do |s|
s.name = 'VFGMVA10Framework'
s.module_name = 'VFGMVA10Framework'
s.version = "1.15.0"
s.summary = "Vodafone Group MVA10 Framework Component"
s.homepage = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Framework'
s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Framework.git", :tag => "1.15.0" }
s.platform = :ios, '11.0'
s.swift_version = '5.0'
s.requires_arc = true
s.source_files = 'VFGMVA10Framework/VFGMVA10Framework/**/*.{h,m,xib,storyboard,swift}'
s.resources = 'VFGMVA10Framework/VFGMVA10Framework/**/*.{xcassets,json,lproj}'
s.dependency 'VFGMVA10Foundation', '1.22.0'
s.dependency 'VFGMVA10Login', '1.19.0'
s.dependency 'VFGMVA10Onboarding', '1.20.0'
s.dependency 'VFGMVA10Purchase', '1.2.0'
s.dependency 'lottie-ios'
s.dependency 'NetPerformSDK'
end
