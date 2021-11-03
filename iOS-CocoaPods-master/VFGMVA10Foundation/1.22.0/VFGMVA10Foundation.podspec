# Generated:Tue Jul 27 06:02:29 PDT 2021
# XCODE_VERSION:Xcode12.5.1
Pod::Spec.new do |s|
    s.name = 'VFGMVA10Foundation'
    s.module_name = 'VFGMVA10Foundation'
    s.version = "1.22.0"
    s.summary = "Vodafone Group MVA10 Foundation Component"
    s.homepage = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Foundation'
    s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
    s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
    s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Foundation.git", :tag => "1.22.0" }
    s.platform = :ios, '11.0'
    s.swift_version = '5.0'
    s.requires_arc = true
    s.source_files = 'VFGMVA10Foundation/VFGMVA10Foundation/**/*.{h,m,swift}'
    s.resources = 'VFGMVA10Foundation/VFGMVA10Foundation/Resources/**/*.{ttf,xcassets,xib,storyboard,json,xcdatamodeld}'
    s.ios.deployment_target  = '11.0'
    s.subspec 'VFGTOBI' do |tobi|
        tobi.name          = "VFGTOBI"
        tobi.source_files  = 'VFGTOBI/VFGTOBI/**/*.{h,m,swift}'
        tobi.resources     = 'VFGTOBI/VFGTOBI/**/*.{ttf,storyboard,xcassets,xib,json,png}'
        tobi.dependency 'lottie-ios'
    end
    s.subspec 'VFGMVA10Splash' do |splash|
        splash.name          = "VFGMVA10Splash"
        splash.source_files  = 'VFGMVA10Splash/VFGMVA10Splash/**/*.{h,m,swift}'
        splash.resources     = 'VFGMVA10Splash/VFGMVA10Splash/**/*.{ttf,storyboard,xcassets,xib,json,png}'
        splash.dependency 'lottie-ios'
    end
    s.subspec 'VFGMVA10Media' do |media|
        media.name          = "VFGMVA10Media"
        media.source_files  = 'VFGMVA10Media/VFGMVA10Media/**/*.{h,m,swift}'
        media.resources     = 'VFGMVA10Media/VFGMVA10Media/**/*.{ttf,storyboard,xcassets,xib,json,png}'
    end
end
