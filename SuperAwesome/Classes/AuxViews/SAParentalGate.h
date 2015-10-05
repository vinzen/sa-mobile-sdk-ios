//
//  SAParentalGate2.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <UIKit/UIKit.h>

// different blocks needed for the parental gate
typedef void(^actionBlock) (UIAlertAction *action);
typedef void(^interactionBlock) (NSString *adname);

// forward declarations
@class SAAd;

// the custom delegate
@protocol SAParentalGateProtocol <NSObject>

// and optional functions
@optional
- (void)parentalGateWasCanceled;
- (void)parentalGateWasFailed;
- (void)parentalGateWasSucceded;

@end

// interface
@interface SAParentalGate : NSObject <UIAlertViewDelegate>

// custom init functions
- (id) initWithAd:(SAAd*)ad;
- (id) initWithPlacementId:(NSInteger)placementId
             andCreativeId:(NSInteger)creativeId
             andLineItemId:(NSInteger)lineItemId;

// delegate
@property (nonatomic,weak) id<SAParentalGateProtocol> delegate;

// show function
- (void) show;

// blocks
- (void) addSuccessBlock:(interactionBlock)block;
- (void) addCancelBlock:(interactionBlock)block;
- (void) addErrorBlock:(interactionBlock)block;
- (void) setAdName:(NSString*)adname;

@end
