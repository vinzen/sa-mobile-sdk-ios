//
//  SAScreenView.m
//  Pods
//
//  Created by Gabriel Coman on 06/10/2015.
//
//

#import "SAInScreenAdView.h"
#import "SAAdView.h"
#import "SKMRAIDView.h"
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"
#import "SAEventManager.h"
#import "SAAdView+Protected.h"
#import "SAAdHTMLParser.h"

@interface SAInScreenAdView () <SKMRAIDViewDelegate>
@end

@implementation SAInScreenAdView

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // do nothing
        
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame andPlacementId:(NSInteger)placementId{
    if (self = [super initWithFrame:frame]) {
        // do nothing
        super.placementId = placementId;
    }
    
    return self;
}

- (void) didMoveToWindow {
    [super didMoveToWindow];
    NSLog(@"Play instantly %d -> Placement Id %ld", super.playInstantly, super.placementId);
    
    if (super.playInstantly) {
        [self playInstant];
    }
}

//#pragma mark Main Display Function
//
//- (void) timerFunc {
//    if (super.currentRefresh > super.refreshPeriod) {
//        super.currentRefresh = 0;
//        [super.timer invalidate];
//        super.timer = nil;
//        
//        // play
//        [self play];
//    }
//    else {
//        NSLog(@"CURRENT TIMER ====> %ld / %ld", super.currentRefresh, super.refreshPeriod);
//        super.currentRefresh++;
//        return;
//    }
//}

- (void) play {
    [super play];
    
//    // in case webview already exists
//    if (raidview != nil) {
//        for (UIView *v in self.subviews) {
//            [v removeFromSuperview];
//        }
//        raidview = nil;
//    }
    
    // load MRAID HTML
    raidview = [[SKMRAIDView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                                     withHtmlData:[SAAdHTMLParser parseHTMLForAd:ad withExtectedSize:self.frame.size]
                                      withBaseURL:[NSURL URLWithString:ad.creative.details.url]
                                supportedFeatures:@[]
                                         delegate:self
                                  serviceDelegate:nil
                               rootViewController:nil];
    
//    raidview = [[SKMRAIDView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
//                                     withHtmlData:@"<!-- canvasSize:320x480 --><html><head><link rel='stylesheet' href='inpage-style.css'><script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script><script type='text/javascript' src='https://ads.superawesome.tv/v2/events.js'></script><script type='text/javascript' src='inpage-code.js'></script></head><body><div id='inpage-div'><div id='close-div'></div><div id='video-holder'><video id='video-player' controls='controls'><source src='video.mp4' type='video/mp4' /></video></div></div><a id='click-a' href='#'></a></body></html>"
//                                      withBaseURL:[NSURL URLWithString:@"https://s3-eu-west-1.amazonaws.com/beta-ads-uploads/rich-media/upload_9b3744ed1cf0487b56c992dd1394f1d7/zdo5t3rJAYQjQGNv4oeHwxROAeArgrmQ/index.html"]
//                                supportedFeatures:@[]
//                                         delegate:self
//                                  serviceDelegate:nil
//                               rootViewController:nil];
    
    // add to view to actually display it
    [self addSubview:raidview];
    
    // create padlock
    [self createPadlockButtonWithParent:raidview];
}

#pragma mark MKRAID View delegate

- (void) mraidViewAdReady:(SKMRAIDView *)mraidView {
    // log
    if (super.delegate && [super.delegate respondsToSelector:@selector(adWasShown:)]) {
        [super.delegate adWasShown:super.placementId];
    }
    
    // log
    [[SAEventManager sharedInstance] LogAdView:ad];
}

- (void) mraidViewAdFailed:(SKMRAIDView *)mraidView {
    // delegate
    if (super.delegate && [super.delegate respondsToSelector:@selector(adFailedToShow:)]) {
        [super.delegate adFailedToShow:super.placementId];
    }
    
    // log
    [[SAEventManager sharedInstance] LogAdFailedToView:ad];
}

- (void) mraidViewNavigate:(SKMRAIDView *)mraidView withURL:(NSURL *)url {
    [self onAdClick];
}


@end
