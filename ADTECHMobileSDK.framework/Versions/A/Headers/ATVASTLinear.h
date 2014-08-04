//
//  ATVASTLinear.h
//  ADTECHMobileSDK
//
//  Created by ADTECH AG on 4/20/12.
//  Copyright (c) 2012 ADTECH AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATVASTEnums.h"

@class ATVASTVideoClicks;
@class ATVASTTracking;

@interface ATVASTLinear : NSObject

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, readonly) NSMutableArray *trackingEvents; // array of ADTECHVASTTracking
@property (nonatomic, copy) NSString *adParameters;
@property (nonatomic, strong) ATVASTVideoClicks *videoClicks;
@property (nonatomic, readonly) NSMutableArray *mediaFiles; // array of ADTECHVASTMediaFile

- (BOOL)shouldTrack:(ATVASTTrackingEvent)event;
- (NSArray*)trackingURLsForEvent:(ATVASTTrackingEvent)event;

@end
