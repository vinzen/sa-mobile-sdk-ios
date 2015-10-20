//
//  SAFullscreenView.m
//  Pods
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import "SAInterstitialAd.h"
#import "UIViewController+Utils.h"
#import "SAAd.h"
#import "SKMRAIDInterstitial.h"
#import "SKMRAIDServiceDelegate.h"
#import "SASender.h"
#import "Utils.h"
#import "SACreative.h"
#import "SADetails.h"

@interface SAView ()
- (void) display;
- (void) clickOnAd;
- (void) createPadlockButtonWithParent:(UIView *)parent;
- (void) removePadlockButtonFromParent;
@end

@interface SAInterstitialAd () <SKMRAIDInterstitialDelegate>
@end

@implementation SAInterstitialAd

- (id) init {
    if (self = [super init]) {
        vc = [UIViewController currentViewController];
        super.isParentalGateEnabled = YES;
    }
    
    return self;
}

- (id) initWithPlacementId:(NSInteger)placementId {
    if (self = [super init]) {
        super.placementId = placementId;
        super.isParentalGateEnabled = YES;
        vc = [UIViewController currentViewController];
    }
    
    return self;
}

- (void) display {
    [super display];
    
    
    CGRect frame = [Utils arrangeAdInNewFrame:[UIScreen mainScreen].bounds
                                    fromFrame:CGRectMake(0, 0, ad.creative.details.width, ad.creative.details.height)];
    
    // create the mraid webview
    raidinterstitial = [[SKMRAIDInterstitial alloc] initWithSupportedFeatures:@[MRAIDSupportsInlineVideo]
                                                                 withHtmlData:ad.adHTML
                                                                  withBaseURL:[NSURL URLWithString:@""]
                                                                     delegate:self
                                                              serviceDelegate:nil
                                                           rootViewController:vc
                                                             andPlacementView:frame];
}

#pragma mark MRAID Interstitial delegate

- (void)mraidInterstitialAdReady:(SKMRAIDInterstitial *)mraidInterstitial {
    [raidinterstitial show];
}

- (void) mraidInterstitialWillShow:(SKMRAIDInterstitial *)mraidInterstitial {
    [SASender postEventViewableImpression:ad];
    
    if ([super.delegate respondsToSelector:@selector(adWasShown:)]) {
        [super.delegate adWasShown:ad.placementId];
    }
    
    [self createPadlockButtonWithParent:[[[UIApplication sharedApplication] delegate] window]];
}

- (void) mraidInterstitialAdFailed:(SKMRAIDInterstitial *)mraidInterstitial {
    [SASender postEventAdFailedToView:ad];
    
    if ([super.delegate respondsToSelector:@selector(adFailedToShow:)]) {
        [super.delegate adFailedToShow:ad.placementId];
    }
}

- (void)mraidInterstitialDidHide:(SKMRAIDInterstitial *)mraidInterstitial {
    if ([super.delegate respondsToSelector:@selector(adWasClosed:)]) {
        [super.delegate adWasClosed:ad.placementId];
    }
    
    [super removePadlockButtonFromParent];
}

- (void) mraidInterstitialNavigate:(SKMRAIDInterstitial *)mraidInterstitial withURL:(NSURL *)url {
    [self clickOnAd];
}

@end
