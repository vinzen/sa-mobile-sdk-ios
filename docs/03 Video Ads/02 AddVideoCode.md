If you prefer using code in order to add video ads to your app, you can use the following code snippet to do so:

```
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SAVideoAd *vad = [[SAVideoAd alloc] initWithPlacementId:5740 andFrame:CGRectMake(0, 0, 320, 300)];
    [self.view  addSubview:vad];
    [vad playInstant];
}
```

Do not forget to replace the `5740` with your placement ID.