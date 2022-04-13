
Pod::Spec.new do |spec|

  spec.name         = "KKBVideoPlayer"
  spec.version      = "1.0.0"
  spec.summary      = "A short description of KKBVideoPlayer."
  spec.description  = "This framework is used to play video from url"
  spec.homepage     = "https://bitbucket.org/kaushalkishorbharti/kkbvideoplayer"
  spec.license      = ""
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author             = { "kaushal kishor bharti" => "mailme.k2b@gmail.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://kaushalkishorbharti@bitbucket.org/kaushalkishorbharti/kkbvideoplayer.git", :tag => spec.version.to_s }
  spec.source_files  = "KKBVideoPlayer/**/*.{swift}"
  spec.swift_versions = "5.0"
  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
   spec.dependency "Bond", "~> 7.8.1"

end
