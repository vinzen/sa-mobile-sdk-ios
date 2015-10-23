To add a banner ad to your project using InterfaceBuilder, there are a couple of easy steps that you should follow.
First, add a new UIView to your View Controller or view. Then, in the Identity Inspector, change it's class from UIView to SABannerAd.

![](img/IMG_02_SABannerAd_1.png "Setting custom class to UIView")

In the Size Inspector make sure to set the Ad's size to the one you specified in the Dashboard. If not, the SABannerAd will try to scale the ad but also maintain aspect ratio, so that it does not get distorted.

Finally, in the Attributes Inspector, there are several ad specific attributes that you need to configure.

![](img/IMG_03_SABannerAd_2.png "Setting attributes")

  * You must set the Placement Id to the one you created in the Dashboard.
  * Select to turn Parntal Gate On or Off (more on that in the Parental Gate chapter).
  * Select a Refresh Period for the Ad
  * And select Play Instantly to be On (it's usually by default).