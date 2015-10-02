#### Implementing SABannerViewDelegate
If you want to be notified of various events in the banner's lifecycle, then your custom class (for example MyCustomViewController) must implement the SABannerViewDelegate protocol:

```
@interface MyCustomViewController: UIViewController <SABannerViewDelegate>
@property (nonatomic, strong) SABannerView *ad;
@end
```

and the SABannerView object's delegate property must be set to an object instance that implements the SABannerViewDelegate protocol, such as the MyCustomViewController.

```
@implementation MyCustomViewController

- (id) init {
	if (self = [super init]){
		self.ad.delegate = self;
	}
	return self;
}

@end
```

The SABannerViewDelegate defines three main methods, discussed below:

```
- (void)shouldSuspendForAd:(SABannerView *)view;
```
Notifies the app when it should suspend its run mode, because an ad is currently playing. Useful for games or other real-time applications.

```
- (void)shouldResumeForAd:(SABannerView *)view;
```
Notifies the app when it should resume its run mode, because an ad has currently stoped playing.

```
- (void)willLeaveApplicationForAd:(SABannerView *)view;
```
Called when the application will leave for another app (like the browser) after a user has taped on an ad.

#### Setting the visibility flag of the banner
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

