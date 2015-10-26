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
#import "SuperAwesomeBannerCustomEvent.h"
#import "SuperAwesome.h"

// private anonymous category of SuperAwesomeBannerCustomEvent, that
// implements two important ad protocols
// - SALoaderProtocol (of SALoader class)
// - SAAdProtocol (common to all SAViews)
@interface SuperAwesomeBannerCustomEvent () <SALoaderProtocol, SAAdProtocol>

@property (nonatomic, assign) CGRect bannerFrame;
@property (nonatomic, strong) SABannerAd *banner;

@end

// actual implementation
@implementation SuperAwesomeBannerCustomEvent

// main CustomEvent call function
- (void) requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
    
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
    _bannerFrame = CGRectMake(0, 0, size.width, size.height);
    
    [[SALoader sharedManager] setDelegate:self];
    [[SALoader sharedManager] preloadAdForPlacementId:placementId];
}

#pragma mark SALoaderProtocol functions

- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId {

    // first step is to actually create the Ad View, as defined by SuperAwesome
    _banner = [[SABannerAd alloc] initWithFrame:_bannerFrame];
    [_banner setAd:ad];
    [_banner setDelegate:self];
    [_banner playPreloaded];
    
    // and then send it to bannerCustomEvent:didLoadAd:
    [self.delegate bannerCustomEvent:self didLoadAd:_banner];
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
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    
}

- (void) adFailedToShow:(NSInteger)placementId {
    // in case of loading failure, first form the error
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(@"Failed to display SuperAwesome Ad.", nil),
                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"JSON invalid.", nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Contact SuperAwesome support.", nil)
                               };
    
    NSError *error = [NSError errorWithDomain:@"SuperAwesomeErrorDomain" code:0 userInfo:userInfo];
    
    // then send this to bannerCustomEvent:didFailToLoadAdWithError:
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void) adFollowedURL:(NSInteger)placementId {
    
    // this must be called to log clicks to MoPub
    [self.delegate bannerCustomEventWillLeaveApplication:self];
    
}

@end
