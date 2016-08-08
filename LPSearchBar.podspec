Pod::Spec.new do |s|
  s.name             = "LPSearchBar"
  s.version          = "0.0.3"
  s.summary          = "fully customizatable searchBar"
  s.description      = <<-DESC
                       searchBar which is fully customizable and has same appearance and similar usage with UISearchBar
                       DESC
  s.homepage         = "https://github.com/litt1e-p/LPSearchBar"
  s.license          = { :type => 'MIT' }
  s.author           = { "litt1e-p" => "litt1e.p4ul@gmail.com" }
  s.source           = { :git => "https://github.com/litt1e-p/LPSearchBar.git", :tag => "#{s.version}" }
  s.platform = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'LPSearchBar/*'
  s.frameworks = 'Foundation', 'UIKit'
end
