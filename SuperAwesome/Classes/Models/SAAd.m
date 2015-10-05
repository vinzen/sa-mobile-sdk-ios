//
//  SAAd.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

// import this model's header
#import "SAAd.h"

// import other model's headers
#import "SACreative.h"

@implementation SAAd

- (id) initWithPlacementId:(NSInteger)placementId andWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _Nullable id errorObj = [dict objectForKey:@"error"];
        _Nullable id lineItemIdObj = [dict objectForKey:@"line_item_id"];
        _Nullable id campaignIdObj = [dict objectForKey:@"campaing_id"];
        _Nullable id isTestObj = [dict objectForKey:@"test"];
        _Nullable id isFallbackObj = [dict objectForKey:@"is_fallback"];
        _Nullable id isFillObj = [dict objectForKey:@"is_fill"];
        _Nullable id creativeObj = [dict objectForKey:@"creative"];
        
        _placementId = placementId;
        _error = (errorObj != NULL ? [errorObj integerValue] : -1);
        _lineItemId = (lineItemIdObj != NULL ? [lineItemIdObj integerValue] : -1);
        _campaignId = (campaignIdObj != NULL ? [campaignIdObj integerValue] : -1);
        _isTest = (isTestObj != NULL ? [isTestObj boolValue] : true);
        _isFallback = (isFallbackObj != NULL ? [isFallbackObj boolValue] : false);
        _isFill = (isFillObj != NULL ? [isFillObj boolValue] : false);
        if (creativeObj != NULL) {
            _creative = [[SACreative alloc] initWithDictionary:creativeObj];
        }
    }
    
    return self;
}

@end
