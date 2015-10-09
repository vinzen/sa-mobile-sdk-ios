//
//  SAPadlockView2.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <UIKit/UIKit.h>

// forward declaration
@class SAAd;

@interface SAPadlockView : UIView

// custom init
- (id) initWithAd:(SAAd *)ad;
- (id) initWithPlacementId:(NSInteger)placementId
             andCreativeId:(NSInteger)creativeId
             andLineItemId:(NSInteger)lineItemId;

@end
