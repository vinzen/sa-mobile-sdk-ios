//
//  SAInterstitialView2.m
//  Pods
//
//  Created by Gabriel Coman on 29/09/2015.
//
//

#import "SAInterstitialView.h"

// import other headers
#import "SAAd.h"
#import "SACreative.h"
#import "SAImageDetials.h"

// import external libs
#import "SKMRAIDUtil.h"
#import "SAPopupViewController.h"
#import "UIWindow+VisibleVC.h"

@interface SAInterstitialView ()

// private members
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) SAPopupViewController *popupController;

@end

@implementation SAInterstitialView

- (void) show {
    // call to super
    [super show];
    
    // form the HTML
    NSString *adimg = [(SAImageDetials*)super.ad.creative.details image];
    NSString *htmlRaw = [NSString stringWithFormat:@"<div><img src=\"%@\"></a></div>", adimg];
    NSString *formattedHtml = [SKMRAIDUtil processRawHtml:htmlRaw];
    
    if (formattedHtml) {
        
        // create the controller
        _popupController = [[SAPopupViewController alloc] init];
        
        // get the raw frame
        CGRect targetFrame = [UIScreen mainScreen].bounds;
        
        // actually display the ad
        _webview = [[UIWebView alloc] initWithFrame:targetFrame];
        [_webview loadHTMLString:formattedHtml baseURL:nil];
        [_popupController.view addSubview:_webview];
        
        // create the decorators
        [super createTapButtonWithParent:_popupController.view];
        [super createPadlockButtonWithParent:_popupController.view];
        [super createCloseButtonWithParent:_popupController.view];
        
        // present this
        UIViewController *topController = [[UIApplication sharedApplication].keyWindow visibleViewController];
        [topController presentViewController:_popupController animated:NO completion:^{
            // call delegate
            if (super.delegate && [super.delegate respondsToSelector:@selector(adWasShown:)]) {
                [super.delegate adWasShown:super.placementId];
            }
        }];
    }
    else {
        // call delegate
        if (super.delegate && [super.delegate respondsToSelector:@selector(adFailedToShow:)]) {
            [super.delegate adFailedToShow:super.placementId];
        }
    }
}

- (void) close {
    [_popupController dismissViewControllerAnimated:NO completion:nil];
}

@end
