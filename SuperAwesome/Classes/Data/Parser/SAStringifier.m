//
//  SAEnumToString.m
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import "SAStringifier.h"

@implementation SAStringifier

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