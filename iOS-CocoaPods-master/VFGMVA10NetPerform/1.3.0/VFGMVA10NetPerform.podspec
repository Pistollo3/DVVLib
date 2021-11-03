# Generated:Thu Aug  6 17:46:24 PDT 2020
# XCODE_VERSION:Xcode11.5
Pod::Spec.new do |s|
    s.name = 'VFGMVA10NetPerform'
    s.module_name = 'VFGMVA10NetPerform'
    s.version = "1.3.0"
    s.summary = "Vodafone Group NetPerform Component"
    s.homepage = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Netperform'
    s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
    s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
    s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Netperform.git", :tag => "1.3.0" }
    s.platform = :ios, '11.0'
    s.swift_version = '5.0'
    s.requires_arc = true
    s.source_files = 'VFGMVA10NetPerform/VFGMVA10NetPerform/**/*.{h,m,swift}'
    s.resources = 'VFGMVA10NetPerform/VFGMVA10NetPerform/**/*.{xib,storyboard,xcassets,jsbundle,png}'
    s.resource_bundle = { "VFGMVA10NetPerformLocalization" => ["VFGMVA10NetPerform/VFGMVA10NetPerformLocalization/*.lproj/*.strings"]}
    s.dependency 'VFGMVA10Foundation'
    s.dependency 'Folly'
    s.dependency 'glog'
    s.dependency 'RNI18n'
    s.dependency 'react-native-netperform'
    s.dependency 'DoubleConversion'
    s.dependency 'Yoga'
    s.dependency 'React'
end
