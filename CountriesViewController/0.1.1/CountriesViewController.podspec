Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "CountriesViewController"
s.summary = "A view controller that allow user to select a countries, it supports in single or multiple mode"
s.requires_arc = true

# 2
s.version = "0.1.1"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Becchetti Luca" => "luca.becchetti@brokenice.it" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/lucabecchetti/CountriesViewController"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/lucabecchetti/CountriesViewController.git", :tag => "#{s.version}"}

# 7
s.framework = "UIKit","Foundation","CoreData"

# 8
s.source_files = "CountriesViewController/*.{swift}"

end
