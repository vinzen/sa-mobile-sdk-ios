//
//  SAFullscreenView.m
//  Pods
//
//  Created by Gabriel Coman on 06/10/2015.
//
//

#import "SAFullscreenAdView.h"
#import "SKMRAIDInterstitial.h"
#import "UIViewController+Utils.h"

@interface SAFullscreenAdView () <SKMRAIDInterstitialDelegate>
@end

@implementation SAFullscreenAdView

- (id) initWithPlcementId:(NSInteger)placementId{
    if (self = [super init]) {
        vc = [UIViewController currentViewController];
        super.placementId = placementId;
        super.playInstantly = false;
    }
    
    return self;
}

#pragma mark MRAID Interstitial delegate

- (void)mraidInterstitialAdReady:(SKMRAIDInterstitial *)mraidInterstitial {
    [raidview show];
}

- (void) mraidInterstitialWillShow:(SKMRAIDInterstitial *)mraidInterstitial {
    NSLog(@"Ad ready");
    if (super.delegate && [super.delegate respondsToSelector:@selector(adWasShown:)]) {
        [super.delegate adWasShown:super.placementId];
    }
}

- (void) mraidInterstitialAdFailed:(SKMRAIDInterstitial *)mraidInterstitial {
    NSLog(@"Ad failed");
    if (super.delegate && [super.delegate respondsToSelector:@selector(adFailedToShow:)]) {
        [super.delegate adFailedToShow:super.placementId];
    }
}

- (void)mraidInterstitialDidHide:(SKMRAIDInterstitial *)mraidInterstitial {
    NSLog(@"Did close");
    if (super.delegate && [super.delegate respondsToSelector:@selector(adWasClosed:)]) {
        [super.delegate adWasClosed:super.placementId];
    }
}

- (void) mraidInterstitialNavigate:(SKMRAIDInterstitial *)mraidInterstitial withURL:(NSURL *)url {
    [self onAdClick];
}

@end
