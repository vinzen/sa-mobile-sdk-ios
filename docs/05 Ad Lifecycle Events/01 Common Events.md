Using the same delegate pattern all ads can serve additional events than can be caught and acted upon.

To do this, your `ViewController` or `View` class must also implement the `SAAdProtocol`:

```
@interface MyViewController () <SAAdProtocol> {
	....
}

``` 

This protocol defines a series of optional functions you can implement and catch events:

```

// this function is called when the ad is shown on the screen
- (void) adWasShown:(NSInteger)placementId {
	// implement here
}

// this function is called when the ad failed to show
- (void) adFailedToShow:(NSInteger)placementId {
	// implement here
}

// this function is called when an ad is closed;
// only applies to fullscreen ads like interstitials and fullscreen videos
- (void) adWasClosed:(NSInteger)placementId {
	// implement here
}

// this function is called when an ad is clicked
- (void) adFollowedURL:(NSInteger)placementId {
	// implement here
}

// this function is called when a parental gate pop-up "cancel" button is pressed
- (void)parentalGateWasCanceled:(NSInteger)placementId {
	// implement here
}

// this function is called when a parental gate pop-up "continue" button is
// pressed and the parental gate failed (because the numbers weren't OK)
- (void)parentalGateWasFailed:(NSInteger)placementId {
	// implement here
}

// this function is called when a parental gate pop-up "continue" button is
// pressed and the parental gate succedded
- (void)parentalGateWasSucceded:(NSInteger)placementId {
	// implement here
}

```

Finally, to complete the code, all ads must assign their `delegate` object to `MyViewController`. This means that when an ad launches an adWasShown or adWasClosed event, the controller will respond with the functions implemented above.

```

_ad = [[SABannerAd alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
_ad.delegate = self; // where "self" is the view controller

```