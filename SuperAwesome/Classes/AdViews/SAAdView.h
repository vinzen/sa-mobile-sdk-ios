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

// three protocol functions that are used to check the ad was
// shown OK or just failed to show
- (void) adWasShown:(NSInteger)placementId;
- (void) adFailedToShow:(NSInteger)placementId;
- (void) adIsNotCorrectFormat:(NSInteger)placementId;

// two 'action' functions - for when the ad is closed or the user
// whishes to leave the app to follow the click_url
- (void) adWasClosed:(NSInteger)placementId;
- (void) adFollowedURL:(NSInteger)placementId;

// three protocol functions used for the parental gate
- (void)parentalGateWasCanceled:(NSInteger)placementId;
- (void)parentalGateWasFailed:(NSInteger)placementId;
- (void)parentalGateWasSucceded:(NSInteger)placementId;

@end

// interface declaration
@interface SAAdView : UIView {
    SAAd *ad;
}

// delegate
@property id<SAAdViewProtocol> delegate;

// public mmeber variables
@property (nonatomic, assign) IBInspectable NSInteger placementId;
@property (nonatomic, assign) IBInspectable BOOL isParentalGateEnabled;
@property (nonatomic, assign) IBInspectable NSInteger refreshPeriod;
@property (nonatomic, assign) IBInspectable BOOL playInstantly;

@property (nonatomic, assign) NSInteger currentRefresh;
@property (nonatomic, strong) NSTimer *timer;

// major ad view functions
- (void) assignAd:(SAAd*)ad;
- (void) play;
- (void) playInstant;

// aux creation functions
- (void) onAdClick;
//- (void) timerFunc;
- (void) createPadlockButtonWithParent:(UIView*)parent;
- (void) removePadlockButtonFromParent;

@end
