//
//  SABanner.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 11/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SABannerView.h"
#import "UIView+FindUIViewController.h"
#import "SuperAwesome.h"

@interface SABannerView ()

@property (nonatomic,strong) ATBannerView *bannerView;

- (ATAdtechAdConfiguration *)configurationForType:(SABannerType)bannerType;
- (ATAdtechAdConfiguration *)defaultConfigurationForType:(SABannerType)bannerType;
- (CGSize)bannerSizeForType:(SABannerType)type;
- (SABannerType)bannerTypeForSize:(CGSize)size;

@end

@implementation SABannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (ATAdtechAdConfiguration *)defaultConfigurationForType:(SABannerType)bannerType
{
    if(bannerType == kBannerSmall){
        ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
        configuration.networkID = 1486;
        configuration.subNetworkID = 1;
        configuration.alias = @"706332-300x50-5";
        return configuration;
    }else if (bannerType == kBannerMedium){
        ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
        configuration.networkID = 1486;
        configuration.subNetworkID = 1;
        configuration.alias = @"706332-320x50-5";
        return configuration;
    }else if (bannerType == kBannerLarge){
        ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
        configuration.networkID = 1486;
        configuration.subNetworkID = 1;
        configuration.alias = @"706332-728x90-5";
        return configuration;
    }
    return nil;
}

- (ATAdtechAdConfiguration *)configurationForType:(SABannerType)bannerType
{
    CGSize size = [self bannerSizeForType:bannerType];
    SAAdPlacement *placement = [[SuperAwesome sharedManager] placementForSize:size];
    if(placement){
        ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
        configuration.networkID = [placement.networkId unsignedIntegerValue];
        configuration.subNetworkID = [placement.subNetworkId unsignedIntegerValue];
        configuration.alias = placement.alias;
        return configuration;
    }
    return [self defaultConfigurationForType:bannerType];
}

- (CGSize)bannerSizeForType:(SABannerType)type
{
    if(type == kBannerLarge){
        return CGSizeMake(728,90);
    }else if (type == kBannerMedium){
        return CGSizeMake(320,50);
    }else if (type == kBannerSmall){
        return CGSizeMake(300,50);
    }
    return CGSizeMake(0, 0);
}

- (SABannerType)bannerTypeForSize:(CGSize)size
{
    if(size.height>=90 && size.width>=728){
        return kBannerLarge;
    }else if(size.height>=50 && size.width>=320){
        return kBannerMedium;
    }else if(size.height>=50 && size.width>=300){
        return kBannerSmall;
    }
    return kBannerSmall;
}

- (void)configLoadedNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"SuperAwesomeConfigLoaded"]){
        [self initBanner];
    }
}

- (void)commonInit
{
    if([[SuperAwesome sharedManager] isLoadingConfiguration]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configLoadedNotification:) name:@"SuperAwesomeConfigLoaded" object:nil];
    }else{
        [self initBanner];
    }
}

- (void)initBanner
{
    self.bannerView = [[ATBannerView alloc] initWithFrame:self.bounds];
    SABannerType type = [self bannerTypeForSize:self.bounds.size];
    self.bannerView.configuration = [self configurationForType:type];
    self.bannerView.delegate = self;
    [self addSubview:self.bannerView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if(self.window == nil){
        return;
    }
    
    if(self.viewController == nil){
        self.bannerView.viewController = [self firstAvailableUIViewController];
    }
    
    [self.bannerView load];
}

- (void)setVisible:(BOOL)visible
{
    _visible = visible;
    self.bannerView.visible = visible;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark ATBannerViewDelegate

- (void)shouldSuspendForAd:(ATBannerView *)view
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(shouldSuspendForAd:)]){
        [self.delegate shouldSuspendForAd:self];
    }
}

- (void)shouldResumeForAd:(ATBannerView *)view
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(shouldResumeForAd:)]){
        [self.delegate shouldResumeForAd:self];
    }
}

- (void)willLeaveApplicationForAd:(ATBannerView *)view
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(willLeaveApplicationForAd:)]){
        [self.delegate willLeaveApplicationForAd:self];
    }
}

- (void)didFetchNextAd:(ATBannerView*)view signals:(NSArray *)signals
{
    NSLog(@"SA AD Success");
}

- (void)didFailFetchingAd:(ATBannerView*)view signals:(NSArray *)signals
{
    NSLog(@"SA AD Fail");
    
}

@end
