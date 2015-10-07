//
//  SAAdView.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <UIKit/UIKit.h>

// forward declarations
@class SAAd;

// protocol
@protocol SAAdViewProtocol <NSObject>

@optional
// own things
- (void) adWasLoaded:(NSInteger)placementId;
- (void) adFailedToLoad:(NSInteger)placementId;
- (void) adWasShown:(NSInteger)placementId;
- (void) adFailedToShow:(NSInteger)placementId;
- (void) adWasClosed:(NSInteger)placementId;
- (void) adFollowedURL:(NSInteger)placementId;

// from parental gate
- (void)parentalGateWasCanceled:(NSInteger)placementId;
- (void)parentalGateWasFailed:(NSInteger)placementId;
- (void)parentalGateWasSucceded:(NSInteger)placementId;

@end

// interface declaration
@interface SAAdView : UIView

// delegate
@property id<SAAdViewProtocol> delegate;

// private member variables
@property (nonatomic, strong) SAAd *ad;

// public mmeber variables
@property (nonatomic, assign) IBInspectable NSInteger placementId;
@property (nonatomic, assign) IBInspectable BOOL isParentalGateEnabled;
@property (nonatomic, assign) IBInspectable BOOL playInstantly;
@property (nonatomic, assign) IBInspectable NSInteger refreshPeriod;

// major ad view functions
- (void) play;
- (void) display;
- (void) onAdClick;

// aux creation functions
//- (void) createTimerViewWithParent:(UIView*)parent;
- (void) createPadlockButtonWithParent:(UIView*)parent;
//- (void) createLearnMoreButtonWithParent:(UIView*)parent;
//- (void) createCloseButtonWithParent:(UIView*)parent;

@end
