# Generated:Tue Jul 27 08:27:12 PDT 2021
# XCODE_VERSION:Xcode12.5.1
Pod::Spec.new do |s|
  s.name          = 'VFGSOHOBilling'
  s.module_name   = 'VFGSOHOBilling'
  s.version       = "1.0.0"
  s.summary       = "Vodafone Group SOHO Billing Component"
  s.homepage      = 'https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-SOHO-Billing'
  s.license = { :type => "Private", :text => "Copyright 2016-2021 by Vodafone. All right reserved." }
  s.author = { "Amir Shaikh" => "amir.shaikh1@vodafone.com" }
  s.source = { :git => "https://github.vodafone.com/VFGroup-MyVodafone-OnePlatform/iOS-MVA10-SOHO-Billing.git", :tag => "1.0.0" }
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  s.source_files  = 'VFGSOHOBilling/VFGSOHOBilling/**/*.{swift}'
  s.resources     = 'VFGSOHOBilling/VFGSOHOBilling/**/*.{ttf,storyboard,xcassets,xib}'
  s.dependency 'VFGMVA10Foundation', '1.22.0'
  s.dependency 'VFGMVA10Billing', '1.14.0'
  s.dependency 'VFGMVA10Framework', '1.15.0'
  s.requires_arc  = true
end
