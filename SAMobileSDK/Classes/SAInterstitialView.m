//
//  SAInterstitialView.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 12/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAInterstitialView.h"

@interface SAInterstitialView ()

@property (nonatomic,strong) ATInterstitialView *interstitialView;

@end

@implementation SAInterstitialView

- (instancetype)initWithViewController:(UIViewController *)viewController
{
    if(self = [super init]){
        // create an interstitial view
        self.interstitialView = [[ATInterstitialView alloc] init];
        self.interstitialView.delegate = self;
        self.interstitialView.viewController = viewController;
        // configure it
        ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
        configuration.alias = @"interstitial-middle-5";
        configuration.networkID = 23;
        configuration.subNetworkID = 10;
        self.interstitialView.configuration = configuration;
        // start the load process, you'll get callback on the delegate once the interstitial is loaded
        // for a better user experience you should wait untill the interstitial is loaded before you display it
        [self.interstitialView load];
    }
    return self;
}

- (void)present
{
    [self.interstitialView present];
}

#pragma mark - ATInterstitialViewDelegate

- (void)didSuccessfullyFetchInterstitialAd:(ATInterstitialView*)view
{
    
}

- (void)didHideInterstitialAd:(ATInterstitialView *)view
{
    [self.interstitialView load];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didHideInterstitialView:)]){
        [self.delegate didHideInterstitialView:self];
    }
}

@end
