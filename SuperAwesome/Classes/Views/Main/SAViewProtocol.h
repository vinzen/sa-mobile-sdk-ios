//
//  SAViewProtocol.h
//  Pods
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import <UIKit/UIKit.h>

// protocol
@protocol SAViewProtocol <NSObject>

@optional

// three protocol functions that are used to check the ad was
// shown OK or just failed to show
- (void) adWasShown:(NSInteger)placementId;
- (void) adFailedToShow:(NSInteger)placementId;

// two 'action' functions - for when the ad is closed or the user
// whishes to leave the app to follow the click_url
- (void) adWasClosed:(NSInteger)placementId;
- (void) adFollowedURL:(NSInteger)placementId;

// three protocol functions used for the parental gate
- (void)parentalGateWasCanceled:(NSInteger)placementId;
- (void)parentalGateWasFailed:(NSInteger)placementId;
- (void)parentalGateWasSucceded:(NSInteger)placementId;

@end
