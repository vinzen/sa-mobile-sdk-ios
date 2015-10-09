//
//  SAFullscreenView.m
//  Pods
//
//  Created by Gabriel Coman on 06/10/2015.
//
//

#import "SAFullscreenAdView.h"

// import mraid
#import "SKMRAIDView.h"
#import "SKMRAIDInterstitial.h"
#import "SKMRAIDServiceDelegate.h"

// import some utils
#import "UIViewController+Utils.h"

// import some models
#import "SACreative.h"
#import "SAAd.h"
#import "SADetails.h"
#import "SAEventManager.h"

@interface SAFullscreenAdView () <SKMRAIDInterstitialDelegate>
@end

@implementation SAFullscreenAdView

- (id) initWithPlcementId:(NSInteger)placementId{
    if (self = [super init]) {
        vc = [UIViewController currentViewController];
        super.placementId = placementId;
    }
    
    return self;
}

#pragma mark Main Display Function

- (void) timerFunc {
    // do nothing
}

- (void) play {
    [super play];
    
    // create the mraid webview
    raidview = [[SKMRAIDInterstitial alloc] initWithSupportedFeatures:@[MRAIDSupportsInlineVideo]
                                                         withHtmlData:[ad createAdHTMLWithSizeDetails:vc.view.frame.size]
                                                          withBaseURL:[NSURL URLWithString:ad.creative.clickURL]
                                                             delegate:self
                                                      serviceDelegate:nil
                                                   rootViewController:vc];
}

#pragma mark MRAID Interstitial delegate

- (void)mraidInterstitialAdReady:(SKMRAIDInterstitial *)mraidInterstitial {
    [raidview show];
    [self createPadlockButtonWithParent:[[[UIApplication sharedApplication] delegate] window]];
}

- (void) mraidInterstitialWillShow:(SKMRAIDInterstitial *)mraidInterstitial {
    // delegate
    if (super.delegate && [super.delegate respondsToSelector:@selector(adWasShown:)]) {
        [super.delegate adWasShown:super.placementId];
    }
    
    // log
    [[SAEventManager sharedInstance] LogAdView:ad];
}

- (void) mraidInterstitialAdFailed:(SKMRAIDInterstitial *)mraidInterstitial {
    // delegate
    if (super.delegate && [super.delegate respondsToSelector:@selector(adFailedToShow:)]) {
        [super.delegate adFailedToShow:super.placementId];
    }
    
    // log
    [[SAEventManager sharedInstance] LogAdFailedToView:ad];
}

- (void)mraidInterstitialDidHide:(SKMRAIDInterstitial *)mraidInterstitial {
    if (super.delegate && [super.delegate respondsToSelector:@selector(adWasClosed:)]) {
        [super.delegate adWasClosed:super.placementId];
    }
    
    [super removePadlockButtonFromParent];
}

- (void) mraidInterstitialNavigate:(SKMRAIDInterstitial *)mraidInterstitial withURL:(NSURL *)url {
    [self onAdClick];
}

@end
