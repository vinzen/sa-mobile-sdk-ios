//
//  SAEnumToString.m
//  Pods
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import "SAStringifier.h"

@implementation SAStringifier

// custom function to convert creative type to string
+ (NSString*) creativeFormatToString:(SACreativeFormat) format {
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

// custom function to convert creative type to string
+ (NSString*) placementFormatToString:(SAPlacementFormat) format {
    const char* c_str = 0;
#define PROCESS_VAL(p) case(p): c_str = #p; break;
    switch(format) {
            PROCESS_VAL(web_display);
            PROCESS_VAL(floor_display);
    }
#undef PROCESS_VAL
    
    return [NSString stringWithCString:c_str encoding:NSASCIIStringEncoding];
}

// function that transforms the event type enum into a string
+ (NSString*) eventTypeFromValue:(SAEventType) evt {
    const char* c_str = 0;
#define PROCESS_VAL(p) case(p): c_str = #p; break;
    switch(evt) {
            PROCESS_VAL(NoAd);
            PROCESS_VAL(viewable_impression);
            PROCESS_VAL(AdFailedToView);
            PROCESS_VAL(AdRate);
            PROCESS_VAL(AdPGCancel);
            PROCESS_VAL(AdPGSuccess);
            PROCESS_VAL(AdPGError);
    }
#undef PROCESS_VAL
    
    return [NSString stringWithCString:c_str encoding:NSASCIIStringEncoding];
}

@end