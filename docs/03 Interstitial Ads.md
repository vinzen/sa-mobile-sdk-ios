The indicated place to load an interstitial is when you create a new screen. Depending on your needs, you might want to show the interstitial each time when you enter the screen or only once. You should start loading the interstitial inside your `viewDidLoad` method. After the interstitial is loaded (you get notified of this through the delegate) you need to call present on it to be presented.

The interstitial is presented modally over the viewController you configured it with. This means that when it is presented, your `viewWillDisapper:` method gets called and `viewWillAppear:` is called when the interstitial is dismissed. It a good idea not to automatically present the interstitial on `viewWillAppear:` or to destroy it on `viewWillDisappear:`, because this will lead to infinite loop and early dismisses of the interstitial.
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
    self.interstitial.placementID = @"__YOUR_PLACEMENT_ID__";
    [self.interstitial load];
}

- (IBAction)presentInterstitionalAd:(id)sender
{
    [self.interstitial present];
}
```

Do not forget to replace the `__YOUR_PLACEMENT_ID__` string with your placement ID.