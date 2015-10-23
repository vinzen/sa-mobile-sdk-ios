Interstitial ads are usually presented modally over your current View Controller. The Super Awesome SDK implements them using the SAInterstitialAd class, which is a subclass of UIViewController.

The usual code you will use will look like the following:

```
// alloc + init the interstitial
SAInterstitialAd *iad = [[SAInterstitialAd alloc] initWithPlacementId:5692];

// use your View Controllers standard presentViewController:animated:completion
// function to load the interstitial
// on completion, make sure to call the playInstant function to actually show
// the ad
[self presentViewController:iad animated:YES completion:^{
	[iad playInstant];
}];

```

Do not forget to replace the `5692` string with your placement ID.