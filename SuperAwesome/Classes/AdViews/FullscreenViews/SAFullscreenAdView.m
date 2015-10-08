//
//  SAFullscreenView.m
//  Pods
//
//  Created by Gabriel Coman on 06/10/2015.
//
//

#import "SAFullscreenAdView.h"

// import mraid
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
    
    NSString *htmlRaw = @"";
    
    // depending on the type of creative
    switch (super.ad.creative.format) {
        case image_with_link:{
            
            // form the HTML
            NSString *adimg = super.ad.creative.details.image;
            NSString *click = super.ad.creative.clickURL;
            NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayImage" ofType:@"html"];
            htmlRaw = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"hrefURL" withString:click];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"imgURL" withString:adimg];
            
            break;
        }
        case video: {
            
            // video
            NSString *advid = super.ad.creative.details.video;
            NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayVideo" ofType:@"html"];
            htmlRaw = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"videoURL" withString:advid];
            
            break;
        }
        case tag: {
            break;
        }
        case rich_media: {
            break;
        }
        case rich_media_resizing: {
            break;
        }
        case swf:{
            break;
        }
            
        default:
            break;
    }
    
    // create the mraid webview
    raidview = [[SKMRAIDInterstitial alloc] initWithSupportedFeatures:@[MRAIDSupportsInlineVideo]
                                                         withHtmlData:htmlRaw
                                                          withBaseURL:[NSURL URLWithString:super.ad.creative.clickURL]
                                                             delegate:self
                                                      serviceDelegate:nil
                                                   rootViewController:vc];
}

#pragma mark MRAID Interstitial delegate

- (void)mraidInterstitialAdReady:(SKMRAIDInterstitial *)mraidInterstitial {
    [raidview show];
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
}

- (void) mraidInterstitialNavigate:(SKMRAIDInterstitial *)mraidInterstitial withURL:(NSURL *)url {
    [self onAdClick];
}

@end
