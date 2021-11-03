# Generated:Thu Aug 12 00:47:00 PDT 2021
# XCODE_VERSION:Xcode12.5.1
Pod::Spec.new do |s|
s.name = 'VFGMVA10Framework'
s.module_name = 'VFGMVA10Framework'
s.version = "1.15.2"
s.summary = "Vodafone Group MVA10 Framework Component"
s.homepage = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Framework'
s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Framework.git", :tag => "1.15.1" }
s.platform = :ios, '11.0'
s.swift_version = '5.0'
s.requires_arc = true
s.source_files = 'VFGMVA10Framework/VFGMVA10Framework/**/*.{h,m,xib,storyboard,swift}'
s.resources = 'VFGMVA10Framework/VFGMVA10Framework/**/*.{xcassets,json,lproj}'
s.dependency 'VFGMVA10Foundation', '1.23.1'
s.dependency 'VFGMVA10Login', '1.19.2'
s.dependency 'VFGMVA10Onboarding', '1.20.2'
s.dependency 'VFGMVA10Purchase', '1.2.2'
s.dependency 'lottie-ios'
s.dependency 'NetPerformSDK', '7.1.0'
end
