In order to use video ads in your app, first you have to add a preroll placement on the [Dashboard](http://dashboard.superawesome.tv). Then, go to your xib file and add a UIView object to the view. In the Identity Inspector pane set the class of the view to SAVideoAdView.

![](/doc_files/iOSSDK/video_ad.png "Adding Video Ad in Interface Builder")

Set your App ID and Placement ID in the Attributes Inspector pane and if you wish to enable autoplay set the Autoplay setting to On.

To start the video ad playback programatically call the `play` method on the SAVideoAdView. By implementing the SAVideoAdViewDelegate protocol your app can react to events that are emitted by the SAVideoAdView instance.