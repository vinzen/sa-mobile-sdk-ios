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
#import "SADetails.h"
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
    NSString *advid = super.ad.creative.details.video;
    NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayVideo" ofType:@"html"];
    NSString *htmlRaw = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
    htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"videoURL" withString:advid];

    // setup the MRAID view
    raidview = [[SKMRAIDView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                                     withHtmlData:htmlRaw
                                      withBaseURL:[NSURL URLWithString:super.ad.creative.clickURL]
                                supportedFeatures:@[MRAIDSupportsInlineVideo]
                                         delegate:self
                                  serviceDelegate:nil
                               rootViewController:nil];
    
    // add to superview (self)
    [self addSubview:raidview];
}

@end
