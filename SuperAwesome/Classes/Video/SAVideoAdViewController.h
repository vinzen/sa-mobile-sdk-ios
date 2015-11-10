//
//  SAVideoAdViewController2.h
//  Pods
//
//  Created by Gabriel Coman on 22/09/2015.
//
//

#import <UIKit/UIKit.h>

// forward declaration
@class SAVideoAdView;
@class SAVideoAdViewController;

// protocol
@protocol SAVideoAdViewControllerProtocol <NSObject>
@optional
- (void)didLoadVideoAd:(SAVideoAdViewController *)videoAdViewController;
- (void)didFailToLoadVideoAd:(SAVideoAdViewController *)videoAdViewController;

- (void) didPressOnSkip:(SAVideoAdViewController*)view;
- (void)didStartPlayingVideoAd:(SAVideoAdViewController *)videoAd;
- (void)didReachFirstQuartile:(SAVideoAdViewController*)videoAd;
- (void)didReachHalfpoint:(SAVideoAdViewController*)videoAd;
- (void)didReachThirdQuartile:(SAVideoAdViewController*)videoAd;
- (void)didFinishPlayingVideoAd:(SAVideoAdViewController *)videoAd;
- (void)didFailToPlayVideoAd:(SAVideoAdViewController *)videoAd; // not used
- (void)didClickVideoAd:(SAVideoAdViewController *)videoAd;

//- (void)didFinishPlayingVideoAd:(SAVideoAdViewController *)videoAdViewController;

@end

// interface
@interface SAVideoAdViewController : UIViewController

// inspectable
@property (nonatomic, strong) IBInspectable NSString *placementID;
@property (assign, nonatomic, getter=isParentalGateEnabled) IBInspectable BOOL parentalGateEnabled;

// custom init
- (id) initWithPlacementId:(NSString*)placementID;

// delegate
@property id<SAVideoAdViewControllerProtocol> delegate;

@end
