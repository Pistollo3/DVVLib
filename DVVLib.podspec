#
#  Be sure to run `pod spec lint DVVLib.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
Pod::Spec.new do |spec|

  spec.name         = "DVVLib"
  spec.version      = "0.5.3"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = <<-DESC
This CocoaPods library helps you perform calculation.
                   DESC

  spec.homepage     = "https://github.com/Pistollo3/DVVLib"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Pistollo3" => "dany_v@live.it" }

  spec.ios.deployment_target = '11.0'
  spec.swift_version = "5.0"

  spec.source        = { :git => "https://github.com/Pistollo3/DVVLib.git", :branch => "main", :tag => "#{spec.version}" }
  spec.source_files  = "DVVLib/**/*.{h,m,c,swift,xib,storyboard}"
  spec.dependency "MyPod"
  spec.dependency "VFGMVA10Foundation", "~> 1.26.0"
  spec.dependency "VFGMVA10Login"
  spec.dependency "GigaHubC"
  spec.dependency "RxSwift"
  spec.dependency "RxCocoa"
  
  spec.resources = 'DVVLib/Resources/**/*.{xcassets}'

end
