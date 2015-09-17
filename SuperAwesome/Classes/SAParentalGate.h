#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^actionBlock) (UIAlertAction *action);
typedef void(^interactionBlock) (NSString *adname);

@class SAParentalGate;

@protocol SAParentalGateDelegate <NSObject>

@optional
- (void)didCancelParentalGate:(SAParentalGate *)parentalGate;
- (void)didFailChallengeForParentalGate:(SAParentalGate *)parentalGate;
- (void)didGetThroughParentalGate:(SAParentalGate *)parentalGate;

@end

@interface SAParentalGate : NSObject <UIAlertViewDelegate>

@property (nonatomic,weak) id<SAParentalGateDelegate> delegate;

- (void)show;

- (void) addSuccessBlock:(interactionBlock)block;
- (void) addCancelBlock:(interactionBlock)block;
- (void) addErrorBlock:(interactionBlock)block;
- (void) setAdName:(NSString*)adname;

@end
