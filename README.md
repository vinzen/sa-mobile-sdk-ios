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

![](images/sign_in.png?raw=true "Signing In With SuperAwesome")

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
###Displaying a Banner Ad Using Interface Builder

Add the banner to the xib (or storyboard) file: Go to your xib file and add a UIView element to the view. In the Identity Inspector pane set the class of the view to SABannerView.

![](images/custom_class.png?raw=true "Setting custom class to UIView")

In the Size Inspector pane set the size of the banner. The following sizes are supported:
  * 320x50
  * 300x50
  * 728x90 (tablet)

###Displaying an Interstitial Ad
```
@interface ViewController ()
@property (nonatomic,strong) SAInterstitialView *interstitial;
@end

...

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.interstitial = [[SAInterstitialView alloc] initWithViewController:self];
}

- (IBAction)presentInterstitionalAd:(id)sender
{
    [self.interstitial present];
}
```
