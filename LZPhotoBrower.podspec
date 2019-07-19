Pod::Spec.new do |s|

    s.name          = 'LZPhotoBrower'
    s.version       = '0.0.1'
    s.summary       = 'A short description of LZPhotoBrower..'
    s.description   = <<-DESC
                        TODO: Add long description of the pod here.
                        DESC
    s.homepage      = 'https://github.com/liLeiBest'
    s.license       = 'MIT'
    s.author        = { 'lilei' => 'lilei0502@139.com' }
    s.social_media_url = 'https://github.com/liLeiBest'
    s.source        = { :git => 'https://github.com/liLeiBest/LZPhotoBrower.git', :tag => '#{s.version}' }
    s.requires_arc  = true
    
    s.platform      = :ios, '9.0'
    s.frameworks  = 'Photos'

    # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.source_files          = 'LZPhotoBrower/Classes/**/*'
    s.public_header_files   = 'LZPhotoBrower/Classes/**/*.h'
    #s.exclude_files = "Classes/Exclude"

    # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    # s.resource    = "icon.png"
    # s.resources   = "Resources/*.png"
    # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
    # s.resource_bundles = {
    #   'LZPhotoBrower' => ['LZPhotoBrower/Assets/*.png']
    # }

    # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    # s.library     = "iconv"
    # s.libraries   = "iconv", "xml2"

    # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    
    # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
    # s.dependency "JSONKit", "~> 1.4"
	
	pch_AF = <<-EOS
	#import "LZPhotoUtility.h"
	EOS
	s.prefix_header_contents = pch_AF

end
