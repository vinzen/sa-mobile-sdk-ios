//
//  SAVideoAdView2.h
//  Pods
//
//  Created by Gabriel Coman on 22/09/2015.
//
//

#import <UIKit/UIKit.h>
#import "SAPlacementView.h"

/**
 * The simple delegate so far
 */
@protocol SAVideoAdViewProtocol <NSObject>

@optional
- (void) didLoadVideoAd:(UIView*)view;
- (void) didShowVideoAd:(UIView*)view;
- (void) didFailShowingAd:(UIView*)view; // not used
//- (void) didFetchNextAd:(UIView*)view;
- (void) didPressOnSkip:(UIView*)view;
- (void) willLeaveApplicationForAd:(UIView *)view;

- (void)didStartPlayingVideoAd:(UIView *)videoAd;
- (void)didReachFirstQuartile:(UIView*)videoAd;
- (void)didReachHalfpoint:(UIView*)videoAd;
- (void)didReachThirdQuartile:(UIView*)videoAd;
- (void)didFinishPlayingVideoAd:(UIView *)videoAd;
- (void)didFailToPlayVideoAd:(UIView *)videoAd; // not used
- (void)didClickVideoAd:(UIView *)videoAd;

@end

/**
 * This is the second attempt at building a view view, done right!
 */

@interface SAVideoAdView : SAPlacementView

// delegate
@property id<SAVideoAdViewProtocol> delegate;

// should autoplay
@property (nonatomic, assign, getter=shouldAutoplay) IBInspectable BOOL shouldAutoplay;
@property (nonatomic, assign) BOOL isFullscreen;
@property (nonatomic, assign) BOOL canSkip;

// play, stop buttons
- (void) play;
- (void) stop;
- (void) resume;
@end
