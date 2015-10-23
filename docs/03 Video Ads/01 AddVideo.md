In order to use video ads in your app, first you have to add a preroll placement on the [Dashboard](http://dashboard.superawesome.tv). Then, go to your xib file and add a UIView object to the view. In the Identity Inspector pane set the class of the view to SAVideoAd.

![](img/IMG_04_SAVideoAd_1.png "Adding Video Ad in Interface Builder")

Unlike Banner Ads, you can set the Video Ads size to whatever size you like in the Size Inspector, and it will scale properly, respecting video aspect ratio.

Finally, in the Attributes Inspector, you will find the same ad specific attributes that you need to configure.

![](img/IMG_05_SAVideoAd_2.png "Setting attributes to video")

  * You must set the Placement Id to the one you created in the Dashboard.
  * Select to turn Parntal Gate On or Off (more on that in the Parental Gate chapter).
  * Refresh Period has no effect on video ads
  * And select Play Instantly to be On (it's usually by default).