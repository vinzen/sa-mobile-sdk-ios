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

- (ATAdtechAdConfiguration *)configurationForType:(SAInterstitialType)type;
- (SAInterstitialType)typeForSize:(CGSize)size;

@end

@implementation SAInterstitialView

- (ATAdtechAdConfiguration *)configurationForType:(SAInterstitialType)type
{
    if(type == kInterstitialSmall){
        ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
        configuration.networkID = 1486;
        configuration.subNetworkID = 1;
        configuration.alias = @"706332-320x480-5";
        return configuration;
    }else if(type == kInterstitialLarge){
        ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
        configuration.networkID = 1486;
        configuration.subNetworkID = 1;
        configuration.alias = @"706332-768x1024-5";
        return configuration;
    }
    return nil;
}

- (SAInterstitialType)typeForSize:(CGSize)size
{
    if(size.height >= 1024 && size.width >= 768){
        return kInterstitialLarge;
    }
    return kInterstitialSmall;
}

- (instancetype)initWithViewController:(UIViewController *)viewController
{
    if(self = [super init]){

        self.interstitialView = [[ATInterstitialView alloc] init];
        self.interstitialView.delegate = self;
        self.interstitialView.viewController = viewController;

        SAInterstitialType type = [self typeForSize:[UIScreen mainScreen].bounds.size];
        self.interstitialView.configuration = [self configurationForType:type];

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
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSuccessfullyFetchInterstitialAd:)]){
        [self.delegate didSuccessfullyFetchInterstitialAd:self];
    }
}

- (void)didHideInterstitialAd:(ATInterstitialView *)view
{
    [self.interstitialView load];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didHideInterstitialView:)]){
        [self.delegate didHideInterstitialView:self];
    }
}

@end
