//
//  SAPlacement.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 01/12/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SADisplayAd.h"
#import "SAParentalGate.h"

@interface SAPlacementView : UIView

@property (nonatomic,strong) IBInspectable NSString *placementID;
@property (assign,nonatomic,getter=isParentalGateEnabled) IBInspectable BOOL parentalGateEnabled;

@end
