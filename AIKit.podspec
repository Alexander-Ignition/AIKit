
Pod::Spec.new do |s|

  s.name         = "AIKit"
  s.version      = "0.0.1"
  s.summary      = "Assistance Kit"
  s.homepage     = "https://github.com/Alexander-Ignition/AIKit"
  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "GRADUATION" => "izh.sever@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Alexander-Ignition/AIKit.git", :tag => "0.0.1" }
  s.source_files = "Classes", "AIKit/СCategories/*.{h,m}"
  s.requires_arc = true

end
