Additionally, if your `ViewController` class implements functions from the `SAVideoAdProtocol`, you can catch events like video start or end.

As usual, you need to change your `ViewController` class:

```
@interface MyViewController () <SAVideoAdProtocol> 

	// fired when a video ad has started
	- (void) videoStarted:(NSInteger)placementId {
		// implement here
	}

	// fired when a video ad has reached 1/4 of total duration
	- (void) videoReachedFirstQuartile:(NSInteger)placementId {
		// implement here
	}

	// fired when a video ad has reached 1/2 of total duration
	- (void) videoReachedMidpoint:(NSInteger)placementId {
		// implement here
	}

	// fired when a video ad has reached 3/4 of total duration
	- (void) videoReachedThirdQuartile:(NSInteger)placementId {
		// implement here
	}

	// fired when a video ad has ended
	- (void) videoEnded:(NSInteger)placementId {
		// implement here
	}

	// fired when a video is skipped
	- (void) videoSkipped:(NSInteger)placementId {
		// implement here
	}

```

And just as before, any Video Ads in your app must set their `videoDelegate` object to `MyViewController`, as class that implements the SAVideoAdProtocol interface.

```

_vad = [[SAVideoAd alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
_vad.videoDelegate = self; // where "self" is the view controller

```