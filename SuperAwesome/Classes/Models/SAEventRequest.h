//
//  SAEventRequest.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 20/01/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "JSONModel.h"

// forward declarations
@class SAAdResponse;

// events for the ads
typedef NS_ENUM(NSUInteger, SAEventType) {
    NoAd = -1,
    AdFetched = 0,
    AdLoaded,
    viewable_impression,        // used
    AdFailed,       // used
    AdStart,
    AdStop,
    AdResume,
    AdRate, // used
    UserCanceledParentalGate, // used
    UserSuccessWithParentalGate, // used
    UserErrorWithParentalGate // used
};

@interface SAEventRequest : JSONModel

// members of SAAdResponse
@property (nonatomic,strong) NSString *placementID;
@property (nonatomic,strong) NSString *creativeID;
@property (nonatomic,strong) NSString *lineItemID;
@property (nonatomic,assign) SAEventType type;
@property (nonatomic,assign) int detailValue;

- (instancetype)initWithAdResponse:(SAAdResponse *)adResponse;

@end
