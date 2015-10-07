//
//  SADetails.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SADetails.h"

// custom function to convert creative type to string
NSString *SAPlacementFormatToString(SAPlacementFormat format) {
    const char* c_str = 0;
#define PROCESS_VAL(p) case(p): c_str = #p; break;
    switch(format) {
            PROCESS_VAL(web_display);
    }
#undef PROCESS_VAL
    
    return [NSString stringWithCString:c_str encoding:NSASCIIStringEncoding];
}

@implementation SADetails

- (id) initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        
        // parse the info
        _Nullable id widthObj = [dict objectForKey:@"width"];
        _Nullable id heightObj = [dict objectForKey:@"height"];
        _Nullable id imageObj = [dict objectForKey:@"image"];
        _Nullable id valueObj = [dict valueForKey:@"dict"];
        _Nullable id nameObj = [dict objectForKey:@"name"];
        _Nullable id videoObj = [dict objectForKey:@"video"];
        _Nullable id bitrateObj = [dict objectForKey:@"bitrate"];
        _Nullable id durationObj = [dict objectForKey:@"duration"];
        _Nullable id vastObj = [dict objectForKey:@"vast"];
        _Nullable id tagObj = [dict objectForKey:@"tag"];
        _Nullable id placementFormatObj = [dict objectForKey:@"placement_format"];
        
        _width = (widthObj != NULL ? [widthObj integerValue] : 0);
        _height = (heightObj != NULL ? [heightObj integerValue] : 0);
        _image = (imageObj != NULL ? imageObj : NULL);
        _value = (valueObj != NULL ? [valueObj integerValue] : -1);
        _name = (nameObj != NULL ? nameObj : NULL);
        _video = (videoObj != NULL ? videoObj : NULL);
        _bitrate = (bitrateObj != NULL ? [bitrateObj integerValue] : 0);
        _duration = (durationObj != NULL ? [durationObj integerValue] : 0);
        _vast = (vastObj != NULL ? vastObj : NULL);
        _tag = (tagObj != NULL ? tagObj : NULL);
        
        if (placementFormatObj != NULL) {
            if ([placementFormatObj isEqualToString:SAPlacementFormatToString(web_display)]) {
                _placementFormat = web_display;
            }
        }
        
    }
    
    return self;
}

@end
