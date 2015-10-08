//
//  SACreative.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

// import this model's header
#import "SACreative.h"
#import "SADetails.h"

// custom function to convert creative type to string
NSString *SACreativeFormatToString(SACreativeFormat format) {
    const char* c_str = 0;
#define PROCESS_VAL(p) case(p): c_str = #p; break;
    switch(format) {
            PROCESS_VAL(format_unknown);
            PROCESS_VAL(image_with_link);
            PROCESS_VAL(video);
            PROCESS_VAL(rich_media);
            PROCESS_VAL(rich_media_resizing);
            PROCESS_VAL(swf);
            PROCESS_VAL(tag);
    }
#undef PROCESS_VAL
    
    return [NSString stringWithCString:c_str encoding:NSASCIIStringEncoding];
}

// implementation
@implementation SACreative

- (id) initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _Nullable id creativeIdObj = [dict objectForKey:@"creative_id"];
        _Nullable id nameObj = [dict objectForKey:@"name"];
        _Nullable id cpmObj = [dict objectForKey:@"cpm"];
        _Nullable id formatObj = [dict objectForKey:@"format"];
        _Nullable id impressionUrlObj = [dict objectForKey:@"impression_url"];
        _Nullable id clickUrlObj = [dict objectForKey:@"click_url"];
        _Nullable id detailsObj = [dict objectForKey:@"details"];
        _Nullable id approvedObj = [dict objectForKey:@"approved"];
        
        _creativeId = (creativeIdObj != NULL ? [creativeIdObj integerValue] : -1);
        _cpm = (cpmObj != NULL ? [cpmObj integerValue] : 0);
        _name = (nameObj != NULL ? nameObj : NULL);
        _impressionURL = (impressionUrlObj != NULL ? impressionUrlObj : NULL);
        _clickURL = (clickUrlObj != NULL ? clickUrlObj : @"http://superawesome.tv");
        _approved = (approvedObj != NULL ? [approvedObj boolValue] : false);
        
        // get format & assign details based on format contract
        _format = format_unknown;
        if (formatObj != NULL) {
            if ([formatObj isEqualToString:SACreativeFormatToString(image_with_link)]) {
                _format = image_with_link;
            }
            if ([formatObj isEqualToString:SACreativeFormatToString(video)]) {
                _format = video;
            }
            if ([formatObj isEqualToString:SACreativeFormatToString(rich_media)]) {
                _format = rich_media;
            }
            if ([formatObj isEqualToString:SACreativeFormatToString(rich_media_resizing)]) {
                _format = rich_media_resizing;
            }
            if ([formatObj isEqualToString:SACreativeFormatToString(swf)]) {
                _format = swf;
            }
            if ([formatObj isEqualToString:SACreativeFormatToString(tag)]) {
                _format = tag;
            }
        }
        
        // go forward and parse Details
        if (detailsObj != NULL) {
            _details = [[SADetails alloc] initWithDictionary:detailsObj];
        }
    }
    
    return self;
}

@end
