# Generated:Tue Aug 31 10:03:26 PDT 2021
# XCODE_VERSION:Xcode12.5.1
Pod::Spec.new do |s|
    s.name = 'VFGMVA10MessageCenter'
    s.module_name = 'VFGMVA10MessageCenter'
    s.version = "1.12.0"
    s.summary = "Vodafone Group MVA10 Message Center Component"
    s.homepage = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Message-Center'
    s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
    s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
    s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-Message-Center.git", :tag => "1.12.0" }
    s.platform = :ios, '11.0'
    s.swift_version = '5.0'
    s.requires_arc = true
    s.source_files = 'VFGMVA10MessageCenter/VFGMVA10MessageCenter/**/*.{h,m,swift}'
    s.resources = 'VFGMVA10MessageCenter/VFGMVA10MessageCenter/**/*.{xib,storyboard,xcassets,jsbundle,png}'
    s.resource_bundle = { "VFGMVA10MessageCenterLocalization" => ["VFGMVA10MessageCenter/VFGMVA10MessageCenterLocalization/*.lproj/*.strings"]}
    s.dependency 'VFGMVA10Foundation', '1.24.0'
    s.dependency 'Folly'
    s.dependency 'glog'
    s.dependency 'urbanairship-react-native'
    s.dependency 'DoubleConversion'
    s.dependency 'React-Core'
    s.dependency 'Yoga'
end
