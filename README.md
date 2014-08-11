SuperAwesome Mobile SDK for iOS
===============================

Setting Up SAMobileSDK
-----------------------

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
pod 'SAMobileSDK', :git => 'https://github.com/SuperAwesomeLTD/sa-mobile-sdk-ios.git'
```
After the pod source has been added, update your project's dependecies by running the following command in the terminal:
```
pod update
```
Don't forget to use the .xcworkspace file to open your project in Xcode, instead of the .xcproj file, from here on out.

We recommend using the stable releases of our SDK, but if you want to try out the developer preview versions modify your Podfile as follows:
```
pod 'SAMobileSDK', :git => 'https://github.com/SuperAwesomeLTD/sa-mobile-sdk-ios.git', :branch => 'dev'
```

Integrating the SuperAwesome Platform
-------------------------------------

### User Authentication

The SuperAwesome SDK for iOS provides various login experiences that your app can use to authenticate someone. This document includes all the information you need to know in order to implement SuperAwesome login in your iOS app.

![alt text](/doc_files/MobileSDK/signin.png "Signing In With SuperAwesome")

Sessions and permissions are stored in access tokens, which are cached automatically by the SDK so they are available when a logged in user returns to your app. The SDK provides prebuilt UI components that you can use to log people in and out of your app.

In order to use the SDK you need to import the header file.
```	
#import <SuperAwesomeSDK/SuperAwesomeSDK.h>
```
To show the SuperAwesome login page instantiate SALoginViewController.
```
SALoginViewController *vc = [[SALoginViewController alloc] init];
vc.delegate = self;
[self presentViewController:vc animated:YES completion:nil];
```
By implementing the SALoginViewControllerDelegate protocol you can get notified about the result of the authentication procedure.
```
@protocol SALoginViewControllerDelegate <UINavigationControllerDelegate>
@optional
- (void)loginViewController:(SALoginViewController *)loginVC didSucceedWithToken:(NSString *)token;
- (void)loginViewController:(SALoginViewController *)loginVC didFailWithError:(NSString *)error;
@end
```

### Awarding SuperAwesome Points

Integrating SuperAwesome Advertising
------------------------------------
