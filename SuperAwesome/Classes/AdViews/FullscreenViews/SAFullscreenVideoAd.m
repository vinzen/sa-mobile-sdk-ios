//
//  SAFullscreenViewoAd.m
//  Pods
//
//  Created by Gabriel Coman on 06/10/2015.
//
//

#import "SAFullscreenVideoAd.h"

// import other headers
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"
#import "SKMRAIDInterstitial.h"
#import "SKMRAIDServiceDelegate.h"
#import "UIViewController+Utils.h"

@interface SAFullscreenVideoAd () <SKMRAIDInterstitialDelegate>
@end

@implementation SAFullscreenVideoAd

- (void) display {
    // call to super
    [super display];
    
    // form the HTML
    NSString *advid = super.ad.creative.details.video;
    NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayVideo" ofType:@"html"];
    NSString *htmlRaw = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
    htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"videoURL" withString:advid];

    // create the mraid webview
    raidview = [[SKMRAIDInterstitial alloc] initWithSupportedFeatures:@[MRAIDSupportsInlineVideo]
                                                         withHtmlData:htmlRaw
                                                          withBaseURL:[NSURL URLWithString:super.ad.creative.clickURL]
                                                             delegate:self
                                                      serviceDelegate:nil
                                                   rootViewController:vc];
    
}


@end
