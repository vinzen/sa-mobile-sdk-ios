#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^actionBlock) (UIAlertAction *action);
typedef void(^interactionBlock) (NSString *adname);

@class SAParentalGate;
@class SAAdResponse;

@protocol SAParentalGateDelegate <NSObject>

@optional
- (void)didCancelParentalGate:(SAParentalGate *)parentalGate;
- (void)didFailChallengeForParentalGate:(SAParentalGate *)parentalGate;
- (void)didGetThroughParentalGate:(SAParentalGate *)parentalGate;

@end

@interface SAParentalGate : NSObject <UIAlertViewDelegate>

// custom init
- (id) initWithAdResponse:(SAAdResponse*)response;

- (id) initWithPlacementId:(NSString*)placementID
             andCreativeId:(NSString*)creativeID
             andLineItemId:(NSString*)lineItemID;

// delegate
@property (nonatomic,weak) id<SAParentalGateDelegate> delegate;

// show function
- (void)show;

// blocks
- (void) addSuccessBlock:(interactionBlock)block;
- (void) addCancelBlock:(interactionBlock)block;
- (void) addErrorBlock:(interactionBlock)block;
- (void) setAdName:(NSString*)adname;

@end
