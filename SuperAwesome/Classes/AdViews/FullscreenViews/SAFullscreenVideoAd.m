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
#import "SAVideoDetails.h"
#import "SKMRAIDInterstitial.h"
#import "SKMRAIDServiceDelegate.h"

@interface SAFullscreenVideoAd () <SKMRAIDInterstitialDelegate, SKMRAIDServiceDelegate>
@end

@implementation SAFullscreenVideoAd

- (void) display {
    // call to super
    [super display];
    
    // form the HTML
    NSString *advid = [(SAVideoDetails*)super.ad.creative.details video];
    NSString *htmlRaw = [NSString stringWithFormat:@"<html><head></head><body><div><video autoplay='true' webkit-playsinline width='320' height='240'><source src='%@' type='video/mp4'/></video></div></body></html>", advid];
    
    raidview = [[SKMRAIDInterstitial alloc] initWithSupportedFeatures:@[MRAIDSupportsInlineVideo]
                                                         withHtmlData:htmlRaw
                                                          withBaseURL:[NSURL URLWithString:super.ad.creative.clickURL]
                                                             delegate:self
                                                      serviceDelegate:nil
                                                   rootViewController:vc];
    
}


@end
