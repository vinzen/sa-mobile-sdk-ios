If you prefer using code in order to add video ads to your app, you can use the following code snippet to do so:

```
@interface ViewController ()
@property (nonatomic,strong) SAVideoAdView *videoAdView;
@end

...

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.videoAdView = [[SAVideoAdView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    self.videoAdView.appID = @"__YOUR_APP_ID__";
    self.videoAdView.placementID = @"__YOUR_PLACEMENT_ID__";
    self.videoAdView.autoplay = YES;
    [self.view addSubview:self.videoAdView];
}
```

Do not forget to replace the `__YOUR_APP_ID__` and the `__YOUR_PLACEMENT_ID__` strings with your app ID and placement ID.