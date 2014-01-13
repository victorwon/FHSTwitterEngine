Pod::Spec.new do |s|
  s.name         = "FHSTwitterEngine"
  s.version      = "0.0.1"
  s.summary      = "A short description of FHSTwitterEngine."
  s.homepage     = "https://github.com/mglagola/FHSTwitterEngine"
  s.license      = 'MIT'
  s.author         = "fhsjaagshs", "mglagola"
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/mglagola/FHSTwitterEngine.git", :tag => s.version.to_s }
  s.source_files  = 'FHSTwitterEngine', 'FHSTwitterEngine/*.{h,m}'
  s.framework  = 'SystemConfiguration'
end
