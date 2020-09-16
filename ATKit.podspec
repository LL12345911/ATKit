#
#  Be sure to run `pod spec lint ATKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

   s.name         = 'ATKit'
    s.version      = '1.0'
    s.summary      = 'iOS开发基本库'
    s.description  = <<-DESC 
    ***
    iOS开发基本库
    ***
                   DESC
    s.homepage     = 'https://github.com/LL12345911/ATKit'
    s.license      = { :type => "MIT", :file => 'LICENSE' }
    s.authors      = { "Mars" => "sky12345911@163.com" }
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/LL12345911/ATKit.git', :tag => s.version}
    s.social_media_url = 'https://github.com/LL12345911/ATKit'
    #s.source_files = 'ATKitLib/**/*.{h,m}'
    #s.resource_bundles    = { 'AAChartKitLib' => 'AAChartKitLib/AAJSFiles.bundle' }
    #s.prefix_header_contents = '#import "Atkit.h"'
    s.source_files = 'ATKitLib/Atkit.h'

  s.subspec 'Share' do |ss|
   # ss.source_files = 'ATKitLib/AFURL{Request,Response}Serialization.{h,m}'
    ss.source_files = 'ATKitLib/OpenShareManager.{h,m}'
  end

  s.subspec 'MessageCenter' do |ss|
    ss.source_files = 'ATKitLib/MessageCenter/*.{h,m}'
  end

  s.subspec 'Thread' do |ss|
    ss.source_files = 'ATKitLib/Thread/*.{h,m}'
  end

  s.subspec 'EventBus' do |ss|
    ss.source_files = 'ATKitLib/EventBus/*.{h,m}'
  end

  s.subspec 'DarkMode' do |ss|
    ss.source_files = 'ATKitLib/DarkMode/*.{h,m}'
  end


  s.subspec 'UIKit' do |ss|
    ss.source_files = 'ATKitLib/UIKit/**/*.{h,m}', 'ATKitLib/UIKit/UIKitMacro.h'
  end

  s.subspec 'Foundation' do |ss|
    ss.source_files = 'ATKitLib/Foundation/**/*.{h,m}', 'ATKitLib/Foundation/FoundationMacro.h', 'ATKitLib/Foundation/JsonTransform.h'
  end
    s.requires_arc = true
    s.ios.frameworks = 'UIKit'
    s.ios.deployment_target = '9.0'


end
