If you prefer using code in order to add banners to your app, you can use the following code snippet to do so:

```
SABannerView *bannerView = [[SABannerView alloc] initWithFrame:CGRectMake(0, 100, 320, 50)];
bannerView.placementID = @"__YOUR_PLACEMENT_ID__";
[self.view addSubview:bannerView];
```

Do not forget to replace the `__YOUR_PLACEMENT_ID__` string with one of your own placement ID, from the Dashboard.