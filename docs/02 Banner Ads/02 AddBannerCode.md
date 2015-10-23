If you prefer using code in order to add banners to your app, you can use the following code snippet to do so:

At the top of your View Controller's header or source file, add the following import statement:

```
#import "SuperAwesome.h"
```

Then in your `viewDidLoad` function or similar, add the following code:

```
SABannerAd *ad = [[SABannerAd alloc] initWithPlacementId:5687  andFrame:CGRectMake(0, 0, 320, 50)];
[self.view addSubview:ad];
[ad playInstant];

```

Do not forget to replace the `5687` test placement Id with one of your own placement ID, from the Dashboard.