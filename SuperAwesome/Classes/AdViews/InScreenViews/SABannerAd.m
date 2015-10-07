//
//  SABannerView.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SABannerAd.h"

// import other headers
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"
#import "SKMRAIDView.h"

@interface SABannerAd () <SKMRAIDViewDelegate>
@end

@implementation SABannerAd

- (void) display {
    // call to super
    [super display];
    
    // in case webview already exists
    if (raidview != nil) {
        for (UIView *v in self.subviews) {
            [v removeFromSuperview];
        }
        raidview = nil;
    }
    
    // form HTML
    NSString *adimg = super.ad.creative.details.image;
    NSString *click = super.ad.creative.clickURL;
    NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayImage" ofType:@"html"];
    NSString *htmlRaw = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
    htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"hrefURL" withString:click];
    htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"imgURL" withString:adimg];
    
    // load MRAID HTML
    raidview = [[SKMRAIDView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                                     withHtmlData:htmlRaw
                                      withBaseURL:[NSURL URLWithString:super.ad.creative.clickURL]
                                supportedFeatures:@[]
                                         delegate:self
                                  serviceDelegate:nil
                               rootViewController:nil];
    
    // add to view to actually display it
    [self addSubview:raidview];
    
//    [self createPadlockButtonWithParent:raidview];
}

@end
