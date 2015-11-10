//
//  SAVideoAdView2.m
//  Pods
//
//  Created by Gabriel Coman on 22/09/2015.
//
//

// load header
#import "SAVideoAdView.h"


#import "SuperAwesome.h"
#import "SKLogger.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SAAdCreative.h"
#import "SAEventManager.h"
#import "SAVASTParser.h"

#import <AdSupport/ASIdentifierManager.h>

// import video stuff
#import <AVFoundation/AVFoundation.h>
#import "IMAAdsLoader.h"
#import "IMAAdsManager.h"
#import "IMAAVPlayerContentPlayhead.h"
#import "IMAAdDisplayContainer.h"
#import "IMAUiElements.h"

@interface SAVideoAdView ()
<SAParentalGateDelegate,
 SAVASTProtocol,
 IMAAdsLoaderDelegate,
 IMAAdsManagerDelegate,
 IMAWebOpenerDelegate>

// the ad response
@property (nonatomic, retain) SAAdResponse *adResponse;
// and the viewo URL
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) NSURL *adURL;

// the movie player and other subviews
@property (nonatomic,strong) SAParentalGate *gate;
//@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) UIButton *learnMore;
@property (nonatomic, strong) UILabel *counterLabel;
@property (nonatomic, strong) UIButton *skip;

// the actual counter
@property (nonatomic, assign) NSInteger counter;
@property (nonatomic, assign) NSInteger counterHalf;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) BOOL isRunning;

/////////// VAST PART

// views
@property (nonatomic, strong) AVPlayer *contentPlayer;

// google specific stuff
@property (nonatomic, strong) IMAAdsLoader *adsLoader;
@property (nonatomic, strong) IMAAVPlayerContentPlayhead *contentPlayhead;
@property (nonatomic, strong) IMAAdsManager *adsManager;

// the parser
//@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSString *vastURL;

// notif center
@property (nonatomic, strong) NSNotificationCenter *notifCenter;

// create a XML parser
@property (nonatomic, strong) SAVASTParser *parser;

@end

@implementation SAVideoAdView

- (id) init {
    if (self = [super init]) {
        _isFullscreen = NO;
        _canSkip = false;
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _isFullscreen = NO;
        _canSkip = false;
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _isFullscreen = NO;
        _canSkip = false;
    }
    return self;
}

- (void) didMoveToWindow {
    [super didMoveToWindow];
}

//////////////////////////////////////////////////////
// Fetch ads
//////////////////////////////////////////////////////

- (void) fetchAd {
    SAAdManager *adLoader = [[SuperAwesome sharedManager] adManager];
    SAAdRequest *adRequest = [[SAAdRequest alloc] initWithPlacementId:self.placementID];
    
    [adLoader loadAd:adRequest completion:^(SAAdResponse *response, NSError *error) {
        
        if(error != nil || response == nil){
            [SKLogger error:@"SABannerView" withMessage:@"Failed to fetch ad"];
//            [[SAEventManager sharedInstance] LogAdFailed:_adResponse];
            if(self.delegate && [self.delegate respondsToSelector:@selector(didFailShowingAd:)]){
                [self.delegate didFailShowingAd:self];
            }
            return;
        }
        
        // go forward
        self.adResponse = response;
        _videoURL = [NSURL URLWithString:[_adResponse.creative.details objectForKey:@"video"]];
        _vastURL = [_adResponse.creative.details objectForKey:@"vast"];
        _adURL = [NSURL URLWithString:@"http://www.superawesome.tv/en/"];
        
        
        
        // create these
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            if(self.delegate && [self.delegate respondsToSelector:@selector(didFetchNextAd:)]){
//                [self.delegate didFetchNextAd:self];
//            }
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(didLoadVideoAd:)]){
                [self.delegate didLoadVideoAd:self];
            }
            
            [self renderAd];
            
//            if (_isFullscreen) {
//                [self renderAd];
//            }
        });
    }];
}

- (void) renderAd {
    // actually parse the VAST to get the correct clickURL!!!
    _parser = [[SAVASTParser alloc] init];
    _parser.delegate = self;
    [_parser findCorrectVASTClick:_vastURL];
}

#pragma mark <SAVASTProtocol>

- (void) didFindVASTClickURL:(NSString *)clickURL {
    _adURL = [NSURL URLWithString:clickURL];
    
    // setup ads loader
    _adsLoader = [[IMAAdsLoader alloc] initWithSettings:nil];
    _adsLoader.delegate = self;
    
    IMAAdDisplayContainer *adDisplayContainer = [[IMAAdDisplayContainer alloc] initWithAdContainer:self companionSlots:nil];
    IMAAdsRequest *request = [[IMAAdsRequest alloc] initWithAdTagUrl:_vastURL adDisplayContainer:adDisplayContainer userContext:nil];
    [_adsLoader requestAdsWithRequest:request];
}

- (void) createAuxDecorations {
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    // step 1. learn more button
    if (_learnMore == nil) {
        _learnMore = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30.0f)];
        [_learnMore setTitle:@"" forState:UIControlStateNormal];
        [_learnMore addTarget:self action:@selector(gotoTargetURL:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_learnMore];
    }
    
    [self bringSubviewToFront:_learnMore];
    
    // step 2. skip btn
    if (_skip == nil) {
        _skip = [[UIButton alloc] init];
        [_skip setTitle:@"Skip" forState:UIControlStateNormal];
        [[_skip titleLabel] setFont:[UIFont systemFontOfSize:11]];
        [_skip addTarget:self action:@selector(pressOnSkip:) forControlEvents:UIControlEventTouchUpInside];
        [_skip setFrame:CGRectMake(10, h-22, w-10, 22)];
        _skip.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:_skip];
        _skip.hidden = YES;
    }
    
    // step 3. counter
    if (_counterLabel == nil) {
        _counterLabel = [[UILabel alloc] init];
        [_counterLabel setBackgroundColor:[UIColor clearColor]];
        [_counterLabel setTextColor:[UIColor whiteColor]];
        [_counterLabel setFont:[UIFont systemFontOfSize:11]];
        [_counterLabel setTextAlignment:NSTextAlignmentLeft];
        _counterLabel.frame = CGRectMake(10, h-22, w-10, 22);
        _counterLabel.text = [NSString stringWithFormat:@"Ad: %ld", (long)_counter];
        [self addSubview:_counterLabel];
    }
    
    [self bringSubviewToFront:_counterLabel];
    
    // step 4. padlock
    if (!_adResponse.isFallback) {
        [self setupPadlockButton:self];
        [self bringSubviewToFront:super.padlockBtn];
    }
}

#pragma mark SAVideoAd functions

- (void) createContentPlayhead {
    
}

- (void) contentDidFinishPlaying:(NSNotification *)notification {
    // end of content
    if (notification.object == _contentPlayer.currentItem) {
        [_adsLoader contentComplete];
    }
}

#pragma mark AdsLoader Delegate

- (void) adsLoader:(IMAAdsLoader *)loader adsLoadedWithData:(IMAAdsLoadedData *)adsLoadedData {
    // get an ad manager and set it's delegate
    _adsManager = adsLoadedData.adsManager;
    _adsManager.delegate = self;
    
    // create settings for the ad manager
    IMAAdsRenderingSettings *adsRenderingSettings = [[IMAAdsRenderingSettings alloc] init];
    adsRenderingSettings.webOpenerPresentingController = nil;
    adsRenderingSettings.uiElements = @[];
    
    // create content playhead
    _contentPlayhead = [[IMAAVPlayerContentPlayhead alloc] initWithAVPlayer:_contentPlayer];
    [_notifCenter addObserver:self selector:@selector(contentDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[_contentPlayer currentItem]];
    
    // initialize manager with playhead and settings
    [_adsManager initializeWithContentPlayhead:_contentPlayhead adsRenderingSettings:adsRenderingSettings];
}

- (void) adsLoader:(IMAAdsLoader *)loader failedWithErrorData:(IMAAdLoadingErrorData *)adErrorData {
    [_contentPlayer play];
    
//    [[SAEventManager sharedInstance] LogAdFailed:_adResponse];
    if ([_delegate respondsToSelector:@selector(didFailToPlayVideoAd:)]) {
        [_delegate didFailToPlayVideoAd:self];
    }
}

#pragma mark AdsManager Delegate

- (void)adsManager:(IMAAdsManager *)adsManager didReceiveAdEvent:(IMAAdEvent *)event {
    // When the SDK notified us that ads have been loaded, play them.
    switch (event.type) {
        case kIMAAdEvent_LOADED: {
            
            [adsManager start];
            
            break;
        }
        case kIMAAdEvent_STARTED:{
            
            [self createAuxDecorations];
            [self turnTimerOn];
            
            [[SAEventManager sharedInstance] LogViewableImpression:_adResponse];
            if(self.delegate && [self.delegate respondsToSelector:@selector(didShowVideoAd:)]){
                [self.delegate didShowVideoAd:self];
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(didStartPlayingVideoAd:)]){
                [self.delegate didStartPlayingVideoAd:self];
            }
            
            break;
        }
        case kIMAAdEvent_FIRST_QUARTILE:{
            
            if (_delegate && [_delegate respondsToSelector:@selector(didReachFirstQuartile:)]) {
                [_delegate didReachFirstQuartile:self];
            }
            
            break;
        }
        case kIMAAdEvent_MIDPOINT: {
            
            if (_delegate && [_delegate respondsToSelector:@selector(didReachHalfpoint:)]) {
                [_delegate didReachHalfpoint:self];
            }
            
            break;
        }
        case kIMAAdEvent_THIRD_QUARTILE:{
            
            if (_delegate && [_delegate respondsToSelector:@selector(didReachThirdQuartile:)]) {
                [_delegate didReachThirdQuartile:self];
            }
            
            break;
        }
        case kIMAAdEvent_COMPLETE:{
            
            if (_delegate && [_delegate respondsToSelector:@selector(didFinishPlayingVideoAd:)]){
                [_delegate didFinishPlayingVideoAd:self];
            }
            
            break;
        }
        case kIMAAdEvent_SKIPPED:{
            
//            if ([_videoDelegate respondsToSelector:@selector(videoSkipped:)]){
//                [_videoDelegate videoSkipped:ad.placementId];
//            }
            
            break;
        }
            
        default:
            break;
    }
}

- (void)adsManager:(IMAAdsManager *)adsManager didReceiveAdError:(IMAAdError *)error {
    [_contentPlayer play];
    
//    [SASender postEventAdFailedToView:ad];
//    
//    if ([super.delegate respondsToSelector:@selector(adFailedToShow:)]) {
//        [super.delegate adFailedToShow:ad.placementId];
//    }
}

- (void)adsManagerDidRequestContentPause:(IMAAdsManager *)adsManager {
    [_contentPlayer pause];
}

- (void)adsManagerDidRequestContentResume:(IMAAdsManager *)adsManager {
    [_contentPlayer play];
}

//////////////////////////////////////////////////////
// Video Ad Controls & Actions
//////////////////////////////////////////////////////

- (void) play {
    [self fetchAd];
}

- (void) stop {
    [self turnTimerOff];
    [_adsManager destroy];
}

- (void) resume {

}

#pragma mark Switch Timer functions

- (void) turnTimerOn {
    [self turnTimerOff];
    
    // counter
    if ([_adResponse.creative.details objectForKey:@"duration"]) {
        _counter = [[_adResponse.creative.details objectForKey:@"duration"] intValue];
        _counterHalf = (NSInteger)(_counter / 2);
    }
    else {
        _counter = 0;
    }
    
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(counterFunc:) userInfo:nil repeats:YES];
        [_timer fire];
    }
}

- (void) turnTimerOff {
    if (_timer){
        [_timer invalidate];
        _timer = nil;
    }
}

- (void) counterFunc:(NSTimer*)timer {
    
    if (_counter <= 0) {
        [_timer invalidate];
        _timer = NULL;
        _counterLabel.text = @"Ad: 0";
    }
    else {
        _counterLabel.text = [NSString stringWithFormat:@"Ad: %ld", (long)_counter];
        _counter--;
        
        if (_counter < _counterHalf && _canSkip) {
            _skip.hidden = NO;
            _counterLabel.hidden = YES;
            [self bringSubviewToFront:_skip];
        }
    }
    
}

- (IBAction) gotoTargetURL:(id)sender {
    
    // did click
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickVideoAd:)]) {
        [self.delegate didClickVideoAd:self];
    }
    
    // use parental gatre
    if([self isParentalGateEnabled]){
        if(self.gate == nil){
            self.gate = [[SAParentalGate alloc] initWithAdResponse:_adResponse];
            self.gate.delegate = self;
        }
        [self.gate show];
    }else{
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(willLeaveApplicationForAd:)]){
            [self.delegate willLeaveApplicationForAd:self];
        }
        [[UIApplication sharedApplication] openURL:_adURL];
    }
}

//- (void) moviePlayBackDidFinish: (id)sender {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishPlayingVideoAd:)]){
//        [self.delegate didFinishPlayingVideoAd:self];
//    }
//}

- (void) pressOnSkip:(id)sender {
    [self turnTimerOff];
    [_adsManager skip];
    [_adsManager destroy];
    
    [_delegate didPressOnSkip:self];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFailToPlayVideoAd:)]) {
        [self.delegate didFinishPlayingVideoAd:self];
    }
}

//////////////////////////////////////////////////////
// Fetch SAParentalGateDelegate
//////////////////////////////////////////////////////

- (void)didGetThroughParentalGate:(SAParentalGate *)parentalGate {
    if(self.delegate && [self.delegate respondsToSelector:@selector(willLeaveApplicationForAd:)]){
        [self.delegate willLeaveApplicationForAd:self];
    }
    [[UIApplication sharedApplication] openURL:self.adURL];
}

- (void) didCancelParentalGate:(SAParentalGate *)parentalGate {
    // do nothing
}

- (void) didFailChallengeForParentalGate:(SAParentalGate *)parentalGate {
    // do nohting
}

@end
