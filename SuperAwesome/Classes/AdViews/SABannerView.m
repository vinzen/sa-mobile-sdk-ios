//
//  SABannerView.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SABannerView.h"

// import other headers
#import "SAAd.h"
#import "SACreative.h"
#import "SAImageDetials.h"

// import external libs
#import "SKMRAIDUtil.h"

@interface SABannerView ()

// private members
@property (nonatomic, strong) UIWebView *webview;

@end

@implementation SABannerView

- (void) show {
    // call to super
    [super show];
    
    // in case webview already exists
    if (_webview != nil) {
        for (UIView *v in self.subviews) {
            [v removeFromSuperview];
        }
        _webview = nil;
    }
    
    // form the HTML
    NSString *adimg = [(SAImageDetials*)super.ad.creative.details image];
    NSString *htmlRaw = [NSString stringWithFormat:@"<div><img src=\"%@\"></a></div>", adimg];
    NSString *formattedHtml = [SKMRAIDUtil processRawHtml:htmlRaw];
    
    if (formattedHtml) {
        
        // actually display the ad
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_webview loadHTMLString:formattedHtml baseURL:nil];
        [self addSubview:_webview];
        
        // create the decorators
        [super createTapButtonWithParent:self];
        [super createPadlockButtonWithParent:self];
        
        // call delegate
        if (super.delegate && [super.delegate respondsToSelector:@selector(adWasShown:)]) {
            [super.delegate adWasShown:super.placementId];
        }
    }
    else {
        // call delegate
        if (super.delegate && [super.delegate respondsToSelector:@selector(adFailedToShow:)]) {
            [super.delegate adFailedToShow:super.placementId];
        }
    }
}

@end
