In order to use the SDK you need to import the header file.
```	
#import <SAMobileSDK/SuperAwesome.h>
```

To configure the SuperAwesome library you have to set your application ID on the SuperAwesome class. The best place to do this is in your AppDelegate's `application: didFinishLaunchingWithOptions:` method:
```
// Override point for customization after application launch.
[[SuperAwesome sharedManager] setAppID:@"your-app-id"];
```
If you haven't got an appId go to http://dashboard.superawesome.tv and register you app.

