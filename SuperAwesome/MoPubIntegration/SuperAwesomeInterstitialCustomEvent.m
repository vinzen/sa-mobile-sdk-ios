//
//  SuperAwesome.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

// import useful headers
#import "SuperAwesomeInterstitialCustomEvent.h"
#import "SuperAwesome.h"

// private anonymous category of SuperAwesomeBannerCustomEvent, that
// implements two important ad protocols
// - SALoaderProtocol (of SALoader class)
// - SAAdProtocol (common to all SAViews)
@interface SuperAwesomeInterstitialCustomEvent () <SALoaderProtocol, SAAdProtocol>

@property (nonatomic, strong) SAInterstitialAd *interstitial;

@end

@implementation SuperAwesomeInterstitialCustomEvent

- (void) requestInterstitialWithCustomEventInfo:(NSDictionary *)info {
    
    // enable or disable test mode
    BOOL testMode = [[info objectForKey:@"testMode"] boolValue];
    if (testMode) {
        [[SuperAwesome sharedManager] enableTestMode];
    }
    else {
        [[SuperAwesome sharedManager] disableTestMode];
    }
    
    // code from SA to load ad
    NSInteger placementId = [[info objectForKey:@"placementId"] integerValue];
    
    [[SALoader sharedManager] setDelegate:self];
    [[SALoader sharedManager] preloadAdForPlacementId:placementId];
}

- (void) showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    
    [rootViewController presentViewController:_interstitial animated:YES completion:^{
        
        // play preloaded ad
        [_interstitial playPreloaded];
        
        // call events
        [self.delegate interstitialCustomEventWillAppear:self];
        [self.delegate interstitialCustomEventDidAppear:self];
    }];
}

#pragma mark <SALoaderProtocol>

- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId {
    // init interstitial
    _interstitial = [[SAInterstitialAd alloc] init];
    [_interstitial setAd:ad];
    
    // call events
    [self.delegate interstitialCustomEvent:self didLoadAd:_interstitial];
}

- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId {
    // in case of loading failure, first form the error
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(@"Failed to preload SuperAwesome Ad.", nil),
                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The operation timed out.", nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check your placement Id.", nil)
                               };
    
    NSError *error = [NSError errorWithDomain:@"SuperAwesomeErrorDomain" code:0 userInfo:userInfo];
    
    // then send this to bannerCustomEvent:didFailToLoadAdWithError:
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

#pragma mark <SAAdProtocol>

- (void) adFailedToShow:(NSInteger)placementId {
    // in case of loading failure, first form the error
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(@"Failed to display SuperAwesome Ad.", nil),
                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"JSON invalid.", nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Contact SuperAwesome support.", nil)
                               };
    
    NSError *error = [NSError errorWithDomain:@"SuperAwesomeErrorDomain" code:0 userInfo:userInfo];
    
    // then send this to bannerCustomEvent:didFailToLoadAdWithError:
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void) adFollowedURL:(NSInteger)placementId {
    
    // call required event
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

- (void) adWasClosed:(NSInteger)placementId {
    
    // call required events
    [self.delegate interstitialCustomEventWillDisappear:self];
    [self.delegate interstitialCustomEventDidDisappear:self];
}

@end
