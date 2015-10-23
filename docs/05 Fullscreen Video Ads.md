Fullscreen video ads are similar to Interstitials. To set it up in your project, simply use:

```
SAFullscreenVideoAd *fvad = [[SAFullscreenVideoAd alloc] initWithPlacementId:5740];
[self presentViewController:fvad animated:YES completion:^{
	[fvad playInstant];
}];
```