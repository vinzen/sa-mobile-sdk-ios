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

#pragma mark Display function

- (void) display {
    [super display];
    
    // create the mraid webview
    raidview = [[SKMRAIDInterstitial alloc] initWithSupportedFeatures:@[MRAIDSupportsInlineVideo]
                                                         withHtmlData:[super.ad createAdHTMLWithSizeDetails:vc.view.frame.size]
                                                          withBaseURL:[NSURL URLWithString:super.ad.creative.clickURL]
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
    if (super.delegate && [super.delegate respondsToSelector:@selector(adWasShown:)]) {
        [super.delegate adWasShown:super.placementId];
    }
}

- (void) mraidInterstitialAdFailed:(SKMRAIDInterstitial *)mraidInterstitial {
    if (super.delegate && [super.delegate respondsToSelector:@selector(adFailedToShow:)]) {
        [super.delegate adFailedToShow:super.placementId];
    }
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
