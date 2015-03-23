####Implementing SAVideoAdViewDelegate
If you want to be notified of various events in the vide ad's lifecycle, you can set its delegate to an object instance that implements the SAVideoAdViewDelegate protocol.

The following methods are available in the protocol:

```
- (void)didLoadVideoAd:(SAVideoAdView *)videoAd;
- (void)didFailToLoadVideoAd:(SAVideoAdView *)videoAd;

- (void)didStartPlayingVideoAd:(SAVideoAdView *)videoAd;
- (void)didFinishPlayingVideoAd:(SAVideoAdView *)videoAd;
- (void)didFailToPlayVideoAd:(SAVideoAdView *)videoAd;
- (void)didClickVideoAd:(SAVideoAdView *)videoAd;
```