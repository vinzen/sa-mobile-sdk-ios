####Implementing SABannerViewDelegate
If you want to be notified of various events in the banner lifecycle, you can set its delegate to an object instance that implements the SABannerViewDelegate protocol. For example, you could add this protocol to your view controllers interface definition and optionally implement some of the methods defined in the protocol. At least shouldSuspendForAd and shoudResumeForAd method should be implemented so that you know when the host app should be suspended and resumed. (e.g. the user is playing a game then sees an attractive ad, it clicks on it and the ad expands covering the whole UI; the game going on in the host application should be suspended while the banner is expanded).

SABannerViewDelegate provides the following methods:
```
- (void)shouldSuspendForAd:(SABannerView *)view;
- (void)shouldResumeForAd:(SABannerView *)view;
- (void)willLeaveApplicationForAd:(SABannerView *)view;
```

####Setting the visibility flag of the banner
One last thing you need to do is keep the banners visibility flag up to date. This is important so that the banner knows when to work for you and refresh the ads and when to pause. Failing to set the visibility flag when needed, you might have your users miss important ads for their interests.

You should keep the visibility flag on YES when the banner is displayed and viewable by the user, but when the banner gets off-screen (maybe through the user scrolling content and by navigating to another screen), you should set the visibility flag to NO. A good practice is to set the visibility flag is on viewDidDisappear and viewDidAppear methods.

```
- (void)viewDidDisappear:(BOOL)animated
{
 [super viewDidDisappear:animated];
 banner.visible = NO;
 }
 
- (void)viewDidAppear:(BOOL)animated
{
 banner.visible = YES;
 [super viewDidAppear:animated];
}
```

