//
//  SACreative.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

// import this model's header
#import "SACreative.h"

// import other model headers
#import "SAImageDetials.h"
#import "SAVideoDetails.h"

// custom function to convert creative type to string
NSString *SACreativeFormatToString(SACreativeFormat format) {
    const char* c_str = 0;
#define PROCESS_VAL(p) case(p): c_str = #p; break;
    switch(format) {
            PROCESS_VAL(image_with_link);
            PROCESS_VAL(video);
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
        _Nullable id formatObj = [dict objectForKey:@"format"];
        _Nullable id clickUrlObj = [dict objectForKey:@"click_url"];
        _Nullable id detailsObj = [dict objectForKey:@"details"];
        
        _creativeId = (creativeIdObj != NULL ? [creativeIdObj integerValue] : -1);
        _name = (nameObj != NULL ? nameObj : NULL);
        _clickURL = (clickUrlObj != NULL ? clickUrlObj : NULL);
        
        // get format & assign details based on format contract
        if (formatObj != NULL) {
            if ([formatObj isEqualToString:SACreativeFormatToString(image_with_link)]) {
                _format = image_with_link;
            }
            if ([formatObj isEqualToString:SACreativeFormatToString(video)]) {
                _format = video;
            }
        }
        if (detailsObj != NULL) {
            if (_format == image_with_link) {
                _details = [[SAImageDetials alloc] initWithDictionary:detailsObj];
            }
            if (_format == video) {
                _details = [[SAVideoDetails alloc] initWithDictionary:detailsObj];
            }
        }
    }
    
    return self;
}

@end
