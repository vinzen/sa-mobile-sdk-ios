//
//  SAParentalGate2.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <UIKit/UIKit.h>

// import the parentla gate protocol
#import "SAParentalGateProtocol.h"

// define a block used by UIAlertActions
typedef void(^actionBlock) (UIAlertAction *action);

// define a block used for custom interactions
// (mostly needed because of Unity plugin limitations)
typedef void(^interactionBlock) (NSString *adname);

// forward declaration of SAAd
@class SAAd;

// interface
@interface SAParentalGate : NSObject <UIAlertViewDelegate>

// custom init functions
- (id) initWithAd:(SAAd*)ad;
- (id) initWithPlacementId:(NSInteger)placementId
             andCreativeId:(NSInteger)creativeId
             andLineItemId:(NSInteger)lineItemId;

// delegate
@property (nonatomic,weak) id<SAParentalGateProtocol> delegate;

// the URL the parental gate should go to
@property (nonatomic, strong) NSURL *gotoURL;

// show function
- (void) show;

// blocks
- (void) addSuccessBlock:(interactionBlock)block;
- (void) addCancelBlock:(interactionBlock)block;
- (void) addErrorBlock:(interactionBlock)block;
- (void) setAdName:(NSString*)adname;

@end
