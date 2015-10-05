//
//  SAVideoView.m
//  Pods
//
//  Created by Gabriel Coman on 29/09/2015.
//
//

#import "SAVideoView.h"

// import other headers
#import "SAAd.h"
#import "SACreative.h"
#import "SAVideoDetails.h"

// import external libs
#import "SKMRAIDUtil.h"
#import "SAPopupViewController.h"
#import "UIWindow+VisibleVC.h"

// get the Media Player
#import <MediaPlayer/MediaPlayer.h>

@interface SAVideoView ()

// create the movie player
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) SAPopupViewController *popupController;

@end

@implementation SAVideoView

- (void) show {
    // form the URL
    NSString *videoString = [(SAVideoDetails*)super.ad.creative.details video];
    NSURL *videoURL = [NSURL URLWithString:videoString];
    
    // create the movie player
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    _moviePlayer.controlStyle   = MPMovieControlStyleNone;
    _moviePlayer.shouldAutoplay = false;
    [_moviePlayer setFullscreen:false animated:false];
    
    // setup a notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    if (super.isFullscreen) {
        // present this as a VC
        _popupController = [[SAPopupViewController alloc] init];
        _moviePlayer.view.frame = [UIScreen mainScreen].bounds;
        
        [_popupController.view addSubview:_moviePlayer.view];
        [self createLearnMoreButtonWithParent:_popupController.view];
        [self createPadlockButtonWithParent:_popupController.view];
        [self createCloseButtonWithParent:_popupController.view];
        [_moviePlayer play];
        
        UIViewController *topController = [[UIApplication sharedApplication].keyWindow visibleViewController];
        [topController.navigationController pushViewController:_popupController animated:NO];
//        [topController presentViewController:_popupController animated:NO completion:^{
//            // start playing
//            [_moviePlayer play];
//            
//            // call delegate
//            if (super.delegate && [super.delegate respondsToSelector:@selector(adWasShown:)]) {
//                [super.delegate adWasShown:super.placementId];
//            }
//        }];
    }
    else {
        _moviePlayer.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:_moviePlayer.view];
        [self createLearnMoreButtonWithParent:self];
        [self createPadlockButtonWithParent:self];
        
        // start playing
        [_moviePlayer play];
        
        // call delegate
        if (super.delegate && [super.delegate respondsToSelector:@selector(adWasShown:)]) {
            [super.delegate adWasShown:super.placementId];
        }
    }
    
//    [[SAEventManager sharedInstance] LogViewableImpression:_adResponse];
}

- (void) close {
    if (_popupController) {
        [_popupController dismissViewControllerAnimated:NO completion:nil];
    }
}

@end
