//
//  ATVASTNonLinearAds.h
//  ADTECHMobileSDK
//
//  Created by ADTECH AG on 4/20/12.
//  Copyright (c) 2012 ADTECH AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATVASTEnums.h"

@class ATVASTTracking;

@interface ATVASTNonLinearAds : NSObject

@property (nonatomic, readonly) NSMutableArray *trackingEvents; // array of ATVASTTracking objects
@property (nonatomic, readonly) NSMutableArray *nonLinear; // array of ATVASTNonLinear objects

- (BOOL)shouldTrack:(ATVASTTrackingEvent)event;
- (NSArray*)trackingURLsForEvent:(ATVASTTrackingEvent)event;

@end
