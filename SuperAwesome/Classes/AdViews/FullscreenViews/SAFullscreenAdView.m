//
//  SAFullscreenView.m
//  Pods
//
//  Created by Gabriel Coman on 06/10/2015.
//
//

#import "SAFullscreenAdView.h"
#import "SKMRAIDInterstitial.h"

@interface SAFullscreenAdView () <SKMRAIDInterstitialDelegate>
@end

@implementation SAFullscreenAdView

//- (id) init {
//    @throw [NSException exceptionWithName:NSInternalInconsistencyException
//                                   reason:@"-init is not a valid initializer for the class SAFullscreenView"
//                                 userInfo:nil];
//    return nil;
//}
//
//- (id) initWithFrame:(CGRect)frame {
//    @throw [NSException exceptionWithName:NSInternalInconsistencyException
//                                   reason:@"-initWithFrame is not a valid initializer for the class SAFullscreenView"
//                                 userInfo:nil];
//    return nil;
//}
//
//- (id) initWithCoder:(NSCoder *)aDecoder {
//    @throw [NSException exceptionWithName:NSInternalInconsistencyException
//                                   reason:@"-initWithCoder is not a valid initializer for the class SAFullscreenView"
//                                 userInfo:nil];
//    return nil;
//}

- (id) initWithParentVC:(UIViewController *)parent andPlcementId:(NSInteger)placementId{
    if (self = [super init]) {
        vc = parent;
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

- (void)mraidServicePlayVideoWithUrlString:(NSString *)urlString {
    NSLog(@"Video %@", urlString);
}

@end
