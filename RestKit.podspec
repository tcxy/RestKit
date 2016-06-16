Pod::Spec.new do |s|
  s.name             =  'RestKit'
  s.version          =  '0.26.0'
  s.summary          =  'RestKit is a framework for consuming and modeling RESTful web resources on iOS and OS X.'
  s.homepage         =  'https://github.com/RestKit/RestKit'
  s.social_media_url =  'https://twitter.com/RestKit'
  s.author           =  { 'Blake Watters' => 'blakewatters@gmail.com' }
  s.source           =  { :git => 'https://github.com/RestKit/RestKit.git', :tag => "v#{s.version}" }
  s.license          =  'Apache License, Version 2.0'

  # Platform setup
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  # Exclude optional Search and Testing modules
  s.default_subspec = 'Core'

  # Add Core Data to the PCH if the Core Data subspec is imported. This enables conditional compilation to kick in.
  s.prefix_header_contents = <<-EOS
#if __has_include("RKCoreData.h")
    #import <CoreData/CoreData.h>
#endif
EOS

  # Preserve the layout of headers in the Code directory
  s.header_mappings_dir = 'Code'

  ### Subspecs

  s.subspec 'Core' do |cs|
    cs.dependency 'RestKit/ObjectMapping'
    cs.dependency 'RestKit/Network'
    cs.dependency 'RestKit/CoreData'
  end

  s.subspec 'ObjectMapping' do |os|
    os.source_files   = 'Code/ObjectMapping.h', 'Code/ObjectMapping/**/*'
    os.dependency       'RestKit/Support'
    os.dependency       'RKValueTransformers', '~> 1.1.0'
    os.dependency       'ISO8601DateFormatterValueTransformer', '~> 0.6.1'
  end

  s.subspec 'Network' do |ns|
    ns.source_files   = 'Code/Network.h', 'Code/Network/**/*'
    ns.dependency       'AFNetworking', '3.1.0'
    ns.dependency       'RestKit/ObjectMapping'
  end

  s.subspec 'CoreData' do |cdos|
    cdos.source_files = 'Code/CoreData.h', 'Code/CoreData/**/*'
    cdos.frameworks   = 'CoreData'
    cdos.dependency 'RestKit/ObjectMapping'
  end

  s.subspec 'Testing' do |ts|
    ts.source_files = 'Code/Testing.h', 'Code/Testing'
  end

  s.subspec 'Search' do |ss|
    ss.source_files   = 'Code/Search.h', 'Code/Search'
    ss.dependency 'RestKit/CoreData'
  end

  s.subspec 'Support' do |ss|
    ss.source_files   = 'Code/RestKit.h', 'Code/Support.h', 'Code/Support'
    ss.dependency 'TransitionKit', '~> 2.2'
  end

  s.subspec 'CocoaLumberjack' do |cl|
    cl.source_files = 'Code/CocoaLumberjack/RKLumberjackLogger.*'
    cl.dependency 'CocoaLumberjack'
    cl.dependency 'RestKit/Support'
  end
end
