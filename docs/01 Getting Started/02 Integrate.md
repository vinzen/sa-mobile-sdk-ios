We use [CocoaPods](http://cocoapods.org) in order to make installing and updating our SDK super easy. CocoaPods manages library dependencies for your Xcode projects.

### Installing CocoaPods
If you have not got CocoaPods installed on your machine you can install it by using the following commands:
```
sudo gem install cocoapods
pod init # run in your project's directory
```
### Getting the SDK
The dependencies for your projects are specified in a single text file called a Podfile. CocoaPods will resolve dependencies between libraries, fetch the resulting source code, then link it together in an Xcode workspace to build your project.
To download our SDK add the following line to your Podfile:
```
pod 'SuperAwesome', '~> 2.0-beta'
```
After the pod source has been added, update your project's dependencies by running the following command in the terminal:
```
pod update
```
Don't forget to use the .xcworkspace file to open your project in Xcode, instead of the .xcproj file, from here on out.

We recommend using the stable releases of our SDK, but if you want to try out the developer preview versions modify your Podfile as follows:
```
pod 'SuperAwesome', :git => 'https://github.com/SuperAwesomeLTD/sa-mobile-sdk-ios.git', :branch => 'develop'
```