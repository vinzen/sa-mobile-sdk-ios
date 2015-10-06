//
//  SAVideoView.m
//  Pods
//
//  Created by Gabriel Coman on 29/09/2015.
//
//

#import "SAVideoAd.h"

// import other headers
#import "SAAd.h"
#import "SACreative.h"
#import "SAVideoDetails.h"
#import "SKMRAIDView.h"
#import "SKMRAIDServiceDelegate.h"

@interface SAVideoAd ()  <SKMRAIDViewDelegate>
@end

@implementation SAVideoAd

- (void) display {
    [super display];
 
    // in case webview already exists
    if (raidview != nil) {
        for (UIView *v in self.subviews) {
            [v removeFromSuperview];
        }
        raidview = nil;
    }
    
    // form the HTML
    NSString *advid = [(SAVideoDetails*)super.ad.creative.details video];
    NSString *htmlRaw = [NSString stringWithFormat:@"<html><head></head><body><div><video autoplay='true' webkit-playsinline width='320' height='240'><source src='%@' type='video/mp4'/></video></div></body></html>", advid];
    
    raidview = [[SKMRAIDView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                                     withHtmlData:htmlRaw
                                      withBaseURL:[NSURL URLWithString:super.ad.creative.clickURL]
                                supportedFeatures:@[MRAIDSupportsInlineVideo]
                                         delegate:self
                                  serviceDelegate:nil
                               rootViewController:nil];
    [self addSubview:raidview];
}

@end
