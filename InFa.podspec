Pod::Spec.new do |s|
    
    s.name = 'InFa'
    s.version = '1.0.0'

    s.summary = 'InFa 是一个自定义评分控件。'
    s.description = <<-DESC
                    InFa 是一个由 Swift 编写的适用于 iOS 的评分控件，可以用于星级展示或接受用户输入评分。
                    DESC

    s.authors = { 'spirit-jsb' => 'sibo_jian_29903549@163.com' }
    s.license = 'MIT'
    
    s.homepage = 'https://github.com/spirit-jsb/InFa.git'

    s.ios.deployment_target = '10.0'

    s.swift_versions = ['5.0']

    s.frameworks = 'Foundation', 'UIKit'

    s.source = { :git => 'https://github.com/spirit-jsb/InFa.git', :tag => s.version }

    s.default_subspecs = 'Core'
    
    s.subspec 'Core' do |sp|
        sp.source_files = ['Sources/**/*.swift', 'Sources/InFa.h']
    end

end