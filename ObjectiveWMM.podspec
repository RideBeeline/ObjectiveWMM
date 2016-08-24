#
# Be sure to run `pod lib lint ObjectiveWMM.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ObjectiveWMM'
  s.version          = '0.1.0'
s.summary          = 'An Objective-C iOS wrapper for the World Magnetic Model 2015.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'An Objective-C iOS wrapper for the World Magnetic Model 2015.

ObjectiveWMM is a simple repackaging for iOS of the C-language World Magnetic Model published by the United States National Geospatial-Intelligence Agency (NGA) and the United Kingdoms Defence Geographic Centre (DGC).

WMM is primarily useful to be able to determine the magnetic declination for a given location on a given date. As the earths magnetic field changes over time, the model provides a way to obtain a predicted value for magnetic declination.

Magnetic declination is required in order to convert between headings relative to true north and magnetic north. The difference can be significant in certain parts of the world.'
                       DESC

  s.homepage         = 'https://github.com/RideBeeline/ObjectiveWMM'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Morgan' => 'danmorgz@gmail.com' }
  s.source           = { :git => 'https://github.com/RideBeeline/ObjectiveWMM.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ObjectiveWMM/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ObjectiveWMM' => ['ObjectiveWMM/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
