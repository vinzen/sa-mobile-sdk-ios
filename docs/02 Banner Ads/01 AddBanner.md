Add the banner to the xib (or storyboard) file: Go to your xib file and add a UIView object to the view. In the Identity Inspector pane set the class of the view to SABannerView.

![](img/custom_class.png "Setting custom class to UIView")

In the Size Inspector pane set the size of the banner. The following sizes are supported:
  * 320x50
  * 300x50
  * 728x90 (tablet)
  * 300x250
 
Finally, fill in Placement ID field in the Attributes Inspector pane. After you have set these values the ads should show up in your app.