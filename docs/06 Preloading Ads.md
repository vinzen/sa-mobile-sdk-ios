The Super Awesome SDK supports preloading of ads. This means that you can load most of the Ad data beforehand and display the ad when it's convenient.

To be able to preload ads though, you will need to do some setup.

### Implementing the SA Loader Protocol

The first step is to declare our `ViewController` or `View`  class as implementing the `SALoaderProtocol`, which is a custom SuperAwesome protocol:

```
@interface MyViewController () <SALoaderProtocol>
.......
@end

```

The `SALoaderProtocol` defines two optional methods that any class can implement. Therefore, add the following code to your view controller's source file:

```
- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId {
    // empty implementation so far
}

- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId {
    // empty implementation so far
}

```

### Preloading ads

Once that is done, you need to do some setup:

```

@interface MyViewController () <SALoaderProtocol>

// declare the Banner Ad as a private property, to be available to all
// functions
@property (nonatomic, strong) SABannerAd *ad;

@end


@implementation MyViewController

- (void)viewDidLoad {
	// call to super
    [super viewDidLoad];
    
    // call the SALoader Singleton to do two things:
    // 1. set your MyViewController class as the delegate that implements the SALoaderProtocol 
    [[SALoader sharedManager] setDelegate:self];

    // 2. preload the ad data for a certain placement
    [[SALoader sharedManager] preloadAdForPlacementId:5687];
    

    // Lastly, don't forget to alloc+init the banner ad, but use
    // the initWithFrame: init function;
    //
    // if you use initWithPlacementId:andFrame: the placementId you specify will
    // be ignored
    _ad = [[SABannerAd alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
}


```

Finally, we will use the two functions we just implemented, part of SALoaderProtocol, to see when an ad
has been loaded and act on it.

```
- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId {

	// check to see if the right placement was loaded
	if (placementId == 5687) {	
		// use the special setAd: function of each SuperAwesome Ad object to assign the
		// loaded Ad
		[_ad setAd:ad];

		// use the playPreloaded function to display the ad; This function assumes
		// that bannerad has a valid add assigned
		[_ad playPreloaded];

		// and add the banner ad as a child to the current scene
		[self.view addSubview:_ad];
	}
}
```

These steps apply equally to all types of ads.