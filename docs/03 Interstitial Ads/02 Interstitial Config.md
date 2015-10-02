#### Implementing SAInterstitialViewDelegate

If you want to be notified of various events in the interstitial's lifecycle, then your custom class (for example MyCustomViewController) must implement the SAInterstitialViewDelegate protocol:

```
@interface MyCustomViewController: UIViewController <SAInterstitialViewDelegate>
@property (nonatomic, strong) SAInterstitialView *interstitial;
@end
```

and the SAInterstitialView object's delegate property must be set to an object instance that implements the SAInterstitialViewDelegate protocol, such as the MyCustomViewController.

```
@implementation MyCustomViewController

- (void) viewDidLoad {
	...
	self.interstitial.delegate = self;
}

@end
```

The SAInterstitialViewDelegate defines four main methods, discussed below:

```
- (void) didSuccessfullyFetchInterstitialAd:(SAInterstitialView *)interstitialView;
```
Called when the interstial ad is fetched from a campaign and available to be displayed.
You should put up the ad on the screen at this time, by calling `present`.

```
- (void) didSuccessfullyFetchInterstitialAd:(SAInterstitialView *)interstitialView {
	[self.interstitial present];
}
```

```
- (void) didHideInterstitialView:(SAInterstitialView *)interstitialView;
```
The ad was hidden from view. It gets called either when the ad is dismissed by the user or the refresh timer fires for the ad. You should take down the interstitial ad from the screen at this time.

```
- (void) willLeaveApplicationForInterstitialAd:(SAInterstitialView *)interstitialView;
```
Called when the user interaction with the ad triggers leaving the application.
This can be, for example, opening a URL in Safari or Maps or another application registered to handle the URL specified by the ad. You should save the state of the application when you get this call.

```
- (void) didFailFetchingInterstitialAd:(SAInterstitialView *)interstitialView;
```
Called when an ad fails to be fetched. Usually this happens because of networking conditions and in rare cases if an exceptions occurs on the server. You can call load to try again, if you think the conditions leading to the error have changed.