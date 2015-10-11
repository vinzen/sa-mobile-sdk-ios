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
#import "SADetails.h"

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

// this function checks the minimum stuffs so that an Ad is displaying
// properly for it's intended use (e.g. if it's a video Ad it has to have
// a <video> tag in the returned JSON, etc)

- (BOOL) isAdDataComplete {
    if (_creative == NULL)
        return false;
    
    if (_creative != NULL) {
        if (_creative.format == format_unknown)
            return false;
        
        if (_creative.details == NULL)
            return false;
        
        if (_creative.details != NULL) {
            switch (_creative.format) {
                case image_with_link:{
                    if (_creative.details.image == NULL)
                        return false;
                    break;
                }
                case video:{
                    if (_creative.details.video == NULL)
                        return false;
                    if (_creative.details.vast == NULL)
                        return false;
                    break;
                }
                case rich_media:{
                    if (_creative.details.url == NULL) {
                        return false;
                    }
                    break;
                }
                case rich_media_resizing:{
                    break;
                }
                case swf:{
                    break;
                }
                case tag:{
                    if (_creative.details.tag == NULL)
                        return false;
                    break;
                }
                default:{
                    break;
                }
            }
        }
    }
    
    return true;
}

@end
