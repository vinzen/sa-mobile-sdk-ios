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

@interface SAVideoAdView () <SAParentalGateDelegate, NSXMLParserDelegate>

// the ad response
@property (nonatomic, retain) SAAdResponse *adResponse;
// and the viewo URL
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) NSURL *adURL;

// the movie player and other subviews
@property (nonatomic,strong) SAParentalGate *gate;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) UIButton *learnMore;
@property (nonatomic, strong) UILabel *counterLabel;

// the actual counter
@property (nonatomic, assign) NSInteger counter;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) BOOL isRunning;

// the parser
@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSString *element;
@property (nonatomic, strong) NSMutableString *tmpClickURL;

@end

@implementation SAVideoAdView

- (id) init {
    if (self = [super init]) {
        _isFullscreen = NO;
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _isFullscreen = NO;
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _isFullscreen = NO;
    }
    return self;
}

- (void) didMoveToWindow {
    [super didMoveToWindow];
    
    // preload data
    [self fetchAd];
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
            [[SAEventManager sharedInstance] LogAdFailed:_adResponse];
            if(self.delegate && [self.delegate respondsToSelector:@selector(didFailShowingAd:)]){
                [self.delegate didFailShowingAd:self];
            }
            return;
        }
        
        // go forward
        self.adResponse = response;
        _videoURL = [NSURL URLWithString:[_adResponse.creative.details objectForKey:@"video"]];
        _adURL = [NSURL URLWithString:@"http://www.superawesome.tv/en/"];
        
        // counter
        if ([_adResponse.creative.details objectForKey:@"duration"]) {
            _counter = [[_adResponse.creative.details objectForKey:@"duration"] intValue];
        }
        else {
            _counter = 0;
        }
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(didFetchNextAd:)]){
            [self.delegate didFetchNextAd:self];
        }
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(didLoadVideoAd:)]){
            [self.delegate didLoadVideoAd:self];
        }
        
        // create these
        dispatch_async(dispatch_get_main_queue(), ^{
            [self renderAd];
            [self createAuxDecorations];
        });
    }];
}

- (void) renderAd {
    // actually parse the VAST to get the correct clickURL!!!
    NSString *vastURL = [_adResponse.creative.details objectForKey:@"vast"];
    NSURL *url = [NSURL URLWithString:vastURL];
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    _parser.delegate = self;
    _parser.shouldResolveExternalEntities = NO;
    [_parser parse];
}

#pragma mark <NSXMLParserDelegate>

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    _element = @"";
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    _element = elementName;
    
    if ([_element isEqualToString:@"ClickThrough"]) {
        _tmpClickURL = [[NSMutableString alloc] init];
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([_element isEqualToString:@"ClickThrough"]) {
        [_tmpClickURL appendString:string];
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([_element isEqualToString:@"ClickThrough"]) {
        _adURL = [NSURL URLWithString:_tmpClickURL];
    }
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    // now that the document has been parsed, start the video
    // and render other stuffs
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:_videoURL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    _moviePlayer.controlStyle   = MPMovieControlStyleNone;
    _moviePlayer.shouldAutoplay = false;
    _moviePlayer.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_moviePlayer setFullscreen:false animated:false];
    [self addSubview:_moviePlayer.view];
    
    if (_shouldAutoplay) {
        [self play];
    }
    
    [[SAEventManager sharedInstance] LogViewableImpression:_adResponse];
    if(self.delegate && [self.delegate respondsToSelector:@selector(didShowVideoAd:)]){
        [self.delegate didShowVideoAd:self];
    }
}

- (void) createAuxDecorations {
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    CGFloat offset = (_isFullscreen ? 40 : 0);
    
    // step 1. learn more button
    _learnMore = [[UIButton alloc] init];
    [_learnMore setBackgroundColor:[UIColor clearColor]];
    [_learnMore setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_learnMore setTitle:@"Learn more" forState:UIControlStateNormal];
    [[_learnMore titleLabel] setFont:[UIFont systemFontOfSize:12]];
    _learnMore.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _learnMore.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [_learnMore setFrame:CGRectMake(w - 120, offset, 120, 22)];
    [_learnMore addTarget:self action:@selector(gotoTargetURL:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_learnMore];
    [self bringSubviewToFront:_learnMore];
    
    // step 2. counter
    _counterLabel = [[UILabel alloc] init];
    [_counterLabel setBackgroundColor:[UIColor clearColor]];
    [_counterLabel setTextColor:[UIColor whiteColor]];
    [_counterLabel setFont:[UIFont systemFontOfSize:11]];
    [_counterLabel setTextAlignment:NSTextAlignmentLeft];
    _counterLabel.frame = CGRectMake(10, h-22, w-10, 22);
    _counterLabel.text = [NSString stringWithFormat:@"Ad: %ld", _counter];
    [self addSubview:_counterLabel];
    [self bringSubviewToFront:_counterLabel];
    
    // step 3. padlock
    if (!_adResponse.isFallback) {
        [self setupPadlockButton:self];
    }
}

//////////////////////////////////////////////////////
// Video Ad Controls & Actions
//////////////////////////////////////////////////////

- (void) play {
    [_moviePlayer play];
    [self turnTimerOn];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didStartPlayingVideoAd:)]){
        [self.delegate didStartPlayingVideoAd:self];
    }
}

- (void) stop {
    [_moviePlayer pause];
    [self turnTimerOff];
}

- (void) resume {
    [_moviePlayer play];
    [self turnTimerOn];
}

#pragma mark Switch Timer functions

- (void) turnTimerOn {
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
        _counterLabel.text = [NSString stringWithFormat:@"Ad: %ld", _counter];
        _counter--;
    }
    
}

- (IBAction)gotoTargetURL:(id)sender {
    
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
        // log a click
        [[SAEventManager sharedInstance] LogClick:_adResponse];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(willLeaveApplicationForAd:)]){
            [self.delegate willLeaveApplicationForAd:self];
        }
        [[UIApplication sharedApplication] openURL:_adURL];
    }
}

- (void) moviePlayBackDidFinish: (id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishPlayingVideoAd:)]){
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
