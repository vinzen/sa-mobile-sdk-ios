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
#import "SAImageDetials.h"
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
    
    // form the HTML
    NSString *adimg = [(SAImageDetials*)super.ad.creative.details image];
    NSString *htmlRaw = [NSString stringWithFormat:@"<html><head></head><body><div><a><img src=\"%@\"></a></div></body></html>", adimg];

    raidview = [[SKMRAIDView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                                     withHtmlData:htmlRaw
                                      withBaseURL:[NSURL URLWithString:super.ad.creative.clickURL]
                                supportedFeatures:@[]
                                         delegate:self
                                  serviceDelegate:nil
                               rootViewController:nil];
    [self addSubview:raidview];
    
    [self createTapButtonWithParent:raidview];
    [self createPadlockButtonWithParent:raidview];
}

@end
