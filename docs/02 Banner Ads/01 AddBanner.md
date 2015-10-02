To add a banner ad to your project using InterfaceBuilder, there are a couple of easy steps that you should follow.
First, add a new UIView to your View Controller or view. Then, in the Identity Inspector, change it's class from UIView to SABannerView.

![](img/adbanner_subview.png "Setting custom class to UIView")

Second, in the Size Inspector, make sure the view's size corresponds to one of the following supported sizes:
  * 320x50
  * 300x50
  * 728x90 (tablet)
  * 300x250

![](img/adbanner_size.png "Setting a custom size")

Thrid, in the Attributes Inspector, you need to assign one of the Placement IDs you created in the dashboard to this ad.

![](img/adbanner_attributes.png "Setting attributes")

After you have done this preliminary setup, you should run your project and an ad should appear.