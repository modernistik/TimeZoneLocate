#
# Be sure to run `pod lib lint TimeZoneLocate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TimeZoneLocate"
  s.version          = "0.4.3"
  s.summary          = "Get a time zone for a location offline."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
  This is a Swift port of the APTimeZones library with the support for Frameworks.
  Given a CLLocation determine the timezone for that point without an internet connection (offline).
                       DESC

  s.homepage         = "https://github.com/modernistik/TimeZoneLocate"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Anthony Persaud" => "persaud@modernistik.com" }
  s.source           = { :git => "https://github.com/modernistik/TimeZoneLocate.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/modernistik'

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '5.0'
  s.swift_version = "4.2"

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'TimeZoneLocate' => ['Pod/Assets/timezones.json']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = ['UIKit', 'CoreLocation']
  # s.dependency 'AFNetworking', '~> 2.3'
end
# To publish `pod trunk push TimeZoneLocate.podspec`
# https://guides.cocoapods.org/making/getting-setup-with-trunk.html
# Register a new authentication token: pod trunk register persaud@modernistik.com 'Anthony Persaud' --description='Macbook'
