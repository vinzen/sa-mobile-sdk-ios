//
//  SAScreenView.m
//  Pods
//
//  Created by Gabriel Coman on 06/10/2015.
//
//

#import "SAInScreenAdView.h"
#import "SKMRAIDView.h"
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"

@interface SAInScreenAdView () <SKMRAIDViewDelegate>
@end

@implementation SAInScreenAdView

- (id) initWithFrame:(CGRect)frame andPlacementId:(NSInteger)placementId {
    if (self = [super initWithFrame:frame]) {
        super.placementId = placementId;
    }
    
    return self;
}

- (void) didMoveToWindow {
    [super didMoveToWindow];
    
    if (super.playInstantly) {
        [self play];
    }
}

#pragma mark Main Display Function

- (void) display {
    [super display];
    
    // in case webview already exists
    if (raidview != nil) {
        for (UIView *v in self.subviews) {
            [v removeFromSuperview];
        }
        raidview = nil;
    }
    
    // load MRAID HTML
    raidview = [[SKMRAIDView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                                     withHtmlData:[super.ad createAdHTMLWithSizeDetails:self.frame.size]
                                      withBaseURL:[NSURL URLWithString:super.ad.creative.clickURL]
                                supportedFeatures:@[]
                                         delegate:self
                                  serviceDelegate:nil
                               rootViewController:nil];
    
    // add to view to actually display it
    [self addSubview:raidview];
    
    // create padlock
    [self createPadlockButtonWithParent:raidview];
}

#pragma mark MKRAID View delegate

- (void) mraidViewAdReady:(SKMRAIDView *)mraidView {
    if (super.delegate && [super.delegate respondsToSelector:@selector(adWasShown:)]) {
        [super.delegate adWasShown:super.placementId];
    }
}

- (void) mraidViewAdFailed:(SKMRAIDView *)mraidView {
    if (super.delegate && [super.delegate respondsToSelector:@selector(adFailedToShow:)]) {
        [super.delegate adFailedToShow:super.placementId];
    }
}

- (void) mraidViewNavigate:(SKMRAIDView *)mraidView withURL:(NSURL *)url {
    [self onAdClick];
}


@end
