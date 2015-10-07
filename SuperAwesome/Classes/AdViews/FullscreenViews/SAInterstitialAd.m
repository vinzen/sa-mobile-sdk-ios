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
#import "SADetails.h"
#import "SKMRAIDInterstitial.h"
#import "SKMRAIDServiceDelegate.h"
#import "UIViewController+Utils.h"

@interface SAInterstitialAd () <SKMRAIDInterstitialDelegate>
@end

@implementation SAInterstitialAd

- (void) display {
    // call to super
    [super display];
    
    // form the HTML
    NSString *adimg = super.ad.creative.details.image;
    NSString *click = super.ad.creative.clickURL;
    NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayImage" ofType:@"html"];
    NSString *htmlRaw = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
    htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"hrefURL" withString:click];
    htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"imgURL" withString:adimg];
    
    raidview = [[SKMRAIDInterstitial alloc] initWithSupportedFeatures:@[MRAIDSupportsInlineVideo]
                                                         withHtmlData:htmlRaw
                                                          withBaseURL:[NSURL URLWithString:super.ad.creative.clickURL]
                                                             delegate:self
                                                      serviceDelegate:nil
                                                   rootViewController:vc];
}

@end
