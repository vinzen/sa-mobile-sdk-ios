//
//  SAVideoView.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 03/09/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAVideoView.h"

@interface SAVideoView ()

@property (nonatomic,strong) ATAdtechVideoAdConfiguration *configuration;

@end

@implementation SAVideoView

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
    self.moviePlayerController = [[ATMoviePlayerController alloc] init];
    
    self.configuration = [ATAdtechVideoAdConfiguration configuration];
    self.configuration.networkID = 1486;
    self.configuration.subNetworkID = 1;
    self.configuration.alias = @"706332-728x90-5";
    self.moviePlayerController.configuration = self.configuration;
    
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if(self.superview == nil) return;
    
    if(self.moviePlayerController.presentingViewController == nil){
        UIViewController *vc = [self firstAvailableUIViewController];
        self.moviePlayerController.presentingViewController = vc;
        [self.moviePlayerController prepareToPlay];
    }
}

- (void)playVideo:(NSURL *)url{
    [self.moviePlayerController setContentURL:url];
    self.moviePlayerController.view.frame = self.bounds;
    [self addSubview:self.moviePlayerController.view];
    [self.moviePlayerController play];
}

- (void)enableAdType:(SAVideoAdType)adType
{
    if(adType == kVideoAdPreRoll){
        [self.configuration enableAdType:kATVideoAdPreRoll];
    }else if(adType == kVideoAdMidRoll){
        [self.configuration enableAdType:kATVideoAdMidRoll];
    }else if(adType == kVideoAdPostRoll){
        [self.configuration enableAdType:kATVideoAdPostRoll];
    }
}

@end
