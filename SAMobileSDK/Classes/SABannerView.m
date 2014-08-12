//
//  SABanner.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 11/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SABannerView.h"
#import "UIView+FindUIViewController.h"

@interface SABannerView ()

@property (nonatomic,strong) ATBannerView *bannerView;

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

- (void)commonInit
{
    self.bannerView = [[ATBannerView alloc] initWithFrame:CGRectMake(0,0,300,50)];
    ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
    configuration.alias = @"home-top-5";
    configuration.cacheableMediaExtensions = @[@"mp3", @"mp4", @"mkv"];
    self.bannerView.configuration = configuration;
    self.bannerView.delegate = self;
    [self addSubview:self.bannerView];
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

@end
