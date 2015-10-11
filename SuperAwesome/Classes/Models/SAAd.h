//
//  SAAd.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <Foundation/Foundation.h>

// formward declarations
@class SACreative;

@interface SAAd : NSObject

// member variables
@property (nonatomic, assign) NSInteger error;
@property (nonatomic, assign) NSInteger placementId;
@property (nonatomic, assign) NSInteger lineItemId;
@property (nonatomic, assign) NSInteger campaignId;
@property (nonatomic, assign) BOOL isTest;
@property (nonatomic, assign) BOOL isFallback;
@property (nonatomic, assign) BOOL isFill;
@property (nonatomic, strong) SACreative *creative;
@property (nonatomic, strong) NSString *adHTML;

// custom init
- (id) initWithPlacementId:(NSInteger)placementId andWithDictionary:(NSDictionary*)dict;

// other ad functions
- (BOOL) isAdDataComplete;

@end
