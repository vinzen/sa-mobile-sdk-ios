If you prefer using code in order to add banners to your app, you can use the following code snippet to do so:

```
SABannerView *bannerView = [[SABannerView alloc] initWithFrame:CGRectMake(0, 100, 320, 50)];
bannerView.appID = @"__YOUR_APP_ID__";
bannerView.placementID = @"__YOUR_PLACEMENT_ID__";
[self.view addSubview:bannerView];
```

Do not forget to replace the `__YOUR_APP_ID__` and the `__YOUR_PLACEMENT_ID__` strings with your app ID and placement ID.