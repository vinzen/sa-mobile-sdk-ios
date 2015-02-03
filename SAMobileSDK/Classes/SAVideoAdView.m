//
//  SAVideoView.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 03/09/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAVideoAdView.h"
#import "SuperAwesome.h"

@interface SAVideoAdView ()

@property(nonatomic, strong) IMAAdsLoader *adsLoader;
@property(nonatomic, strong) IMAAdsManager *adsManager;
@property(nonatomic, strong) IMAAdDisplayContainer *adDisplayContainer;

@end

@implementation SAVideoAdView

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
    IMASettings *settings = [[IMASettings alloc] init];
    settings.ppid = @"IMA_PPID_0";
    settings.language = @"en";
    
    self.adsLoader = [[IMAAdsLoader alloc] initWithSettings:settings];
    self.adsLoader.delegate = self;
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if(self.window == nil){
        [self stop];
        return;
    }
    
    [[SuperAwesome sharedManager] videoAdForApp:self.appID placement:self.placementID completion:^(SAVideoAd *videoAd) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(videoAd == nil){
                NSLog(@"SA: Could not find placement with the provided ID");
            }else{
                [self requestAdsWithVideoAd:videoAd];
            }
        });
    }];
}


- (void)requestAdsWithVideoAd:(SAVideoAd *)videoAd
{
    if(videoAd == nil) return;
    
    NSString *adTag = videoAd.vast;
    self.adDisplayContainer = [[IMAAdDisplayContainer alloc] initWithAdContainer:self companionSlots:nil];
    IMAAdsRequest *request = [[IMAAdsRequest alloc] initWithAdTagUrl:adTag adDisplayContainer:self.adDisplayContainer userContext:nil];
    [self.adsLoader requestAdsWithRequest:request];
}

- (void)play{
    [self.adsManager initializeWithContentPlayhead:nil adsRenderingSettings:nil];
    [self.adsManager start];
}

- (void)stop
{
    [self.adsManager destroy];
}

- (void)resume
{
    [self.adsManager resume];
}

#pragma mark AdLoader

- (void)adsLoader:(IMAAdsLoader *)loader adsLoadedWithData:(IMAAdsLoadedData *)adsLoadedData {
    NSLog(@"SA: Ad loaded");
    if(self.delegate && [self.delegate respondsToSelector:@selector(didLoadVideoAd:)]){
        [self.delegate didLoadVideoAd:self];
    }
    
    self.adsManager = adsLoadedData.adsManager;
    self.adsManager.delegate = self;
    
    if(self.autoplay){
        [self play];
    }
}

- (void)adsLoader:(IMAAdsLoader *)loader failedWithErrorData:(IMAAdLoadingErrorData *)adErrorData {
    // Loading failed, log it.
    NSLog(@"SA: Ad loading error: %@", adErrorData.adError.message);
    if(self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadVideoAd:)]){
        [self.delegate didFailToLoadVideoAd:self];
    }
}

#pragma mark AdPlayer

- (void)adsManagerDidRequestContentPause:(IMAAdsManager *)adsManager {
    // Pause the content.
    NSLog(@"should pause");
}

- (void)adsManagerDidRequestContentResume:(IMAAdsManager *)adsManager {
    // Resume or start (if not started yet) the content.
    NSLog(@"should resume");
}

// Process ad events.
- (void)adsManager:(IMAAdsManager *)adsManager didReceiveAdEvent:(IMAAdEvent *)event {
    NSLog(@"SA: Received ad event.");
    // Perform different actions based on the event type.
    if (event.type == kIMAAdEvent_STARTED) {
        NSLog(@"SA: Ad has started.");
        if(self.delegate && [self.delegate respondsToSelector:@selector(didStartPlayingVideoAd:)]){
            [self.delegate didStartPlayingVideoAd:self];
        }
    }else if(event.type == kIMAAdEvent_COMPLETE){
        NSLog(@"SA: Ad has completed");
        if(self.delegate && [self.delegate respondsToSelector:@selector(didFinishPlayingVideoAd:)]){
            [self.delegate didFinishPlayingVideoAd:self];
        }
    }else if(event.type == kIMAAdEvent_CLICKED){
        NSLog(@"SA: Ad has been clicked");
        if(self.delegate && [self.delegate respondsToSelector:@selector(didFinishPlayingVideoAd:)]){
            //[self.delegate didFinishPlayingVideoAd:self];
        }
    }else if(event.type == kIMAAdEvent_TAPPED){
        NSLog(@"SA: Ad has been tapped");
        if(self.delegate && [self.delegate respondsToSelector:@selector(didFinishPlayingVideoAd:)]){
            //[self.delegate didFinishPlayingVideoAd:self];
            if([self.adsManager.adPlaybackInfo isPlaying]){
                [self.adsManager pause];
            }else{
                [self.adsManager resume];
            }
        }
    }
}

// Process ad playing errors.
- (void)adsManager:(IMAAdsManager *)adsManager didReceiveAdError:(IMAAdError *)error {
    // There was an error while playing the ad.
    NSLog(@"Error during ad playback: %@", error.message);
    if(self.delegate && [self.delegate respondsToSelector:@selector(didFailToPlayVideoAd:)]){
        [self.delegate didFailToPlayVideoAd:self];
    }
}

// Optional: receive updates about individual ad progress.
- (void)adDidProgressToTime:(NSTimeInterval)mediaTime totalTime:(NSTimeInterval)totalTime {
    // This can be very noisy log - called 5 times a second.
//    NSLog(@"Current ad time: %lf", mediaTime);
}

@end
