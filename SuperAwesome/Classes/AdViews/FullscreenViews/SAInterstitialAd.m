//
//  SAInterstitialView2.m
//  Pods
//
//  Created by Gabriel Coman on 29/09/2015.
//
//

#import "SAInterstitialAd.h"

// import other headers
#import "SAAd.h"
#import "SACreative.h"
#import "SAImageDetials.h"
#import "SKMRAIDInterstitial.h"
#import "SKMRAIDServiceDelegate.h"

@interface SAInterstitialAd () <SKMRAIDInterstitialDelegate, SKMRAIDServiceDelegate>
@end

@implementation SAInterstitialAd

- (void) display {
    // call to super
    [super display];
    
    // form the HTML
    NSString *adimg = [(SAImageDetials*)super.ad.creative.details image];
    NSString *html = [NSString stringWithFormat:@"<html><head></head><body><div><a><img src=\"%@\"></a></div></body></html>", adimg];
    
    raidview = [[SKMRAIDInterstitial alloc] initWithSupportedFeatures:@[MRAIDSupportsInlineVideo]
                                                         withHtmlData:html
                                                          withBaseURL:[NSURL URLWithString:super.ad.creative.clickURL]
                                                             delegate:self
                                                      serviceDelegate:nil
                                                   rootViewController:vc];
}

@end
