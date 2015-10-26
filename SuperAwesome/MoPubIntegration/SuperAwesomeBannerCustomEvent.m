//
//  SuperAwesomeBannerCustomEvent.m
//  SAMoPubIntegrationDemo
//
//  Created by Gabriel Coman on 26/10/2015.
//  Copyright © 2015 Gabriel Coman. All rights reserved.
//

#import "SuperAwesomeBannerCustomEvent.h"
#import "SuperAwesome.h"

@interface SuperAwesomeBannerCustomEvent () <SALoaderProtocol, SAAdProtocol>

@property (nonatomic, assign) CGRect bannerFrame;
@property (nonatomic, strong) SABannerAd *banner;

@end

@implementation SuperAwesomeBannerCustomEvent

- (void) requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
    
    [[SuperAwesome sharedManager] enableTestMode];
    
    // code from SA to load ad
    NSInteger placementId = [[info objectForKey:@"placementId"] integerValue];
    _bannerFrame = CGRectMake(0, 0, size.width, size.height);
    
    [[SALoader sharedManager] setDelegate:self];
    [[SALoader sharedManager] preloadAdForPlacementId:placementId];
}

#pragma mark SALoaderProtocol functions

- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId {
    
    NSLog(@"THIS WORKS");
    
    _banner = [[SABannerAd alloc] initWithFrame:_bannerFrame];
    [_banner setAd:ad];
    [_banner setDelegate:self];
    [_banner playPreloaded];
    
    [self.delegate bannerCustomEvent:self didLoadAd:_banner];
}

- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId {
    
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(@"Failed to preload SA Ad.", nil),
                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The operation timed out.", nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check your placement Id.", nil)
                               };
    
    NSError *error = [NSError errorWithDomain:@"SuperAwesomeErrorDomain" code:0 userInfo:userInfo];
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    
}

- (void) adFollowedURL:(NSInteger)placementId {
    
    [self.delegate bannerCustomEventWillLeaveApplication:self];
    
}

@end
