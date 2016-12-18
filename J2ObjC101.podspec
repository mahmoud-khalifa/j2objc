Pod::Spec.new do |s|
  s.name = "J2ObjC101"
  s.version = "1.0.2"
  s.license = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.summary = "J2ObjC's 1.0.1 JRE emulation library, emulates a subset of the Java runtime library."
  s.homepage = "https://github.com/AJ9/j2objc"
  s.author  = "Google Inc."
  s.source = { 
  :git => "https://github.com/AJ9/j2objc.git", 
  :tag => "#{s.version}"
  }
  s.platform = :ios
  s.default_subspec = 'lib/jre'

  s.requires_arc = true
  s.header_mappings_dir = "dist/include"
  s.public_header_files = "dist/**/*.{h,m}"

  s.prepare_command = <<-CMD
    scripts/download_distribution.sh
  CMD

  s.subspec 'lib' do |lib|
    lib.frameworks = "Security"    
    lib.osx.frameworks = 'ExceptionHandling'
    lib.xcconfig = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/J2ObjC101/dist/lib"', \
      'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/J2ObjC101/dist/include"' }

    lib.subspec 'jre' do |jre|
      jre.preserve_paths = "dist"
      jre.libraries = "jre_emul", "icucore", "z"
    end

    lib.subspec 'jsr305' do |jsr305|
      jsr305.dependency "J2ObjC101/lib/jre"
      jsr305.libraries = "jsr305"
    end

    lib.subspec 'junit' do |junit|
      junit.dependency "J2ObjC101/lib/jre"
      junit.libraries = "j2objc_main", "junit", "mockito"
    end

    lib.subspec 'guava' do |guava|
      guava.dependency "J2ObjC101/lib/jre"
      guava.libraries = "guava"
    end
  end
end
