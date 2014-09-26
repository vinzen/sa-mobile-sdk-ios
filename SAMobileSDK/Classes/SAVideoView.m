//
//  SAVideoView.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 03/09/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAVideoView.h"
#import "SuperAwesome.h"

@interface SAVideoView ()

@property(nonatomic, strong) IMAAdsLoader *adsLoader;
@property(nonatomic, strong) IMAAdsManager *adsManager;
@property(nonatomic, strong) IMAAdDisplayContainer *adDisplayContainer;

@end

@implementation SAVideoView

- (void)setPlacementId:(NSNumber *)placementId
{
    _placementId = placementId;
    
    if(![[SuperAwesome sharedManager] isLoadingConfiguration]){
        [self requestAds];
    }
}

- (SAPreroll *)preroll
{
    NSArray *prerolls = [[SuperAwesome sharedManager] prerolls];
    if(self.placementId){
        for(SAPreroll *preroll in prerolls){
            if([self.placementId longValue] == [[preroll valueForKey:@"id"] longValue]){
                return preroll;
            }
        }
    }
    return [prerolls firstObject];
}

- (void)requestAds
{
    SAPreroll *preroll = [self preroll];
    NSString *adTag = preroll.vast;
    self.adDisplayContainer = [[IMAAdDisplayContainer alloc] initWithAdContainer:self companionSlots:nil];
    IMAAdsRequest *request = [[IMAAdsRequest alloc] initWithAdTagUrl:adTag adDisplayContainer:self.adDisplayContainer userContext:nil];
    [self.adsLoader requestAdsWithRequest:request];
}

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

- (void)configLoadedNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"SuperAwesomeConfigLoaded"]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestAds];
        });
    }
}

- (void)commonInit
{
    IMASettings *settings = [[IMASettings alloc] init];
    settings.ppid = @"IMA_PPID_0";
    settings.language = @"en";
    
    self.adsLoader = [[IMAAdsLoader alloc] initWithSettings:settings];
    self.adsLoader.delegate = self;
    
    if([[SuperAwesome sharedManager] isLoadingConfiguration]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configLoadedNotification:) name:@"SuperAwesomeConfigLoaded" object:nil];
    }else{
        [self requestAds];
    }
}

- (void)play{
    [self.adsManager initializeWithContentPlayhead:nil adsRenderingSettings:nil];
    [self.adsManager start];
}

- (void)stop
{
    [self.adsManager destroy];
}

#pragma mark AdLoader

- (void)adsLoader:(IMAAdsLoader *)loader adsLoadedWithData:(IMAAdsLoadedData *)adsLoadedData {
    NSLog(@"Ad loaded");
    self.adsManager = adsLoadedData.adsManager;
    self.adsManager.delegate = self;
    
    if(self.autoplay){
        [self play];
    }
}

- (void)adsLoader:(IMAAdsLoader *)loader failedWithErrorData:(IMAAdLoadingErrorData *)adErrorData {
    // Loading failed, log it.
    NSLog(@"Ad loading error: %@", adErrorData.adError.message);
}

#pragma mark AdPlayer

- (void)adsManagerDidRequestContentPause:(IMAAdsManager *)adsManager {
    // Pause the content.
}

- (void)adsManagerDidRequestContentResume:(IMAAdsManager *)adsManager {
    // Resume or start (if not started yet) the content.
}

// Process ad events.
- (void)adsManager:(IMAAdsManager *)adsManager didReceiveAdEvent:(IMAAdEvent *)event {
    NSLog(@"Received ad event.");
    // Perform different actions based on the event type.
    if (event.type == kIMAAdEvent_STARTED) {
        NSLog(@"Ad has started.");
    }else if(event.type == kIMAAdEvent_COMPLETE){
        NSLog(@"Ad has completed");
    }
}

// Process ad playing errors.
- (void)adsManager:(IMAAdsManager *)adsManager didReceiveAdError:(IMAAdError *)error {
    // There was an error while playing the ad.
//    NSLog(@"Error during ad playback: %@", error.message);
}

// Optional: receive updates about individual ad progress.
- (void)adDidProgressToTime:(NSTimeInterval)mediaTime totalTime:(NSTimeInterval)totalTime {
    // This can be very noisy log - called 5 times a second.
//    NSLog(@"Current ad time: %lf", mediaTime);
}

@end
