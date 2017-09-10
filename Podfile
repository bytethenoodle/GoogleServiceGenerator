platform :osx, '10.12'
use_frameworks!

target 'GoogleServiceGenerator' do
    pod 'GoogleAPISwiftClient/Discovery', :path => 'GoogleAPISwiftClient'
    pod 'PathKit'
    pod 'Stencil', :path => 'Stencil'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |configuration|
            configuration.build_settings['SWIFT_VERSION'] = "3.0"
        end
    end
end
