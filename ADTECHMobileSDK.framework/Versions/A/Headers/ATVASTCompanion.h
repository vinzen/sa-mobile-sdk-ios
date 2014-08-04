//
//  ATVASTCompanion.h
//  ADTECHMobileSDK
//
//  Created by ADTECH AG on 4/20/12.
//  Copyright (c) 2012 ADTECH AG. All rights reserved.
//

#import "ATVASTCompanionAndNonLinearBase.h"

@class ATVASTTracking;

@interface ATVASTCompanion : ATVASTCompanionAndNonLinearBase

@property (nonatomic, copy) NSURL *companionClickThrough;
@property (nonatomic, readonly) NSMutableArray *trackingEvents;
@property (nonatomic, copy) NSString *altText;

- (BOOL)shouldTrack:(ATVASTTrackingEvent)event;
- (NSArray*)trackingURLsForEvent:(ATVASTTrackingEvent)event;

@end
