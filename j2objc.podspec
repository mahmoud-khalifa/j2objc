Pod::Spec.new do |s|
  s.name = "J2ObjC"
  s.version = "1.0.1"
  s.license = { 
    :type => "MIT", 
    :file => "LICENSE" 
    }
  s.summary = "J2ObjC's 1.0.1 JRE emulation library, emulates a subset of the Java runtime library."
  s.homepage = "https://github.com/AJ9UNiDAYS/j2objc-1"
  s.author = { "Adam Gask" => "adam.gask@myunidays.com" }
  s.source = { 
  :git => "https://github.com/AJ9UNiDAYS/j2objc-1.git", 
  :tag => "#{s.version}"
  }
  s.platform = :ios

  s.requires_arc = true
  s.default_subspecs = "lib/jre"
  s.header_mappings_dir = "dist/include"

  s.prepare_command = <<-CMD
    scripts/download_distribution.sh
  CMD

  s.subspec 'lib' do |lib|
    lib.frameworks = "Security"    
    lib.osx.frameworks = 'ExceptionHandling'
    lib.xcconfig = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/J2ObjC/dist/lib"', \
      'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/J2ObjC/dist/include"' }

    lib.subspec 'jre' do |jre|
      jre.preserve_paths = "dist"
      jre.libraries = "jre_emul", "icucore", "z"
    end

    lib.subspec 'jsr305' do |jsr305|
      jsr305.dependency "J2ObjC/lib/jre"
      jsr305.libraries = "jsr305"
    end

    lib.subspec 'junit' do |junit|
      junit.dependency "J2ObjC/lib/jre"
      junit.libraries = "j2objc_main", "junit", "mockito"
    end

    lib.subspec 'guava' do |guava|
      guava.dependency "J2ObjC/lib/jre"
      guava.libraries = "guava"
    end
  end
end