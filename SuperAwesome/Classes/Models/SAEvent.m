//
//  SAEvent.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

// import header file
#import "SAEvent.h"

// import other header files
#import "SAAd.h"
#import "SADetails.h"
#import "SACreative.h"

// function that transforms the event type enum into a string
NSString *SAEventTypeFromValue(SAEventType evt) {
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

@implementation SAEvent

- (id) initWithAd:(SAAd *)ad andDetails:(SADetails *)details andEventType:(SAEventType)type {
    if (self = [super init]) {
        _ad = ad;
        _details = details;
        _type = type;
    }
    
    return self;
}

- (NSDictionary*) dictionaryFromModel {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (_ad) {
        if (_ad.placementId) {
            [dict setObject:[NSNumber numberWithInteger:_ad.placementId] forKey:@"placement"];
        }
        if (_ad.lineItemId) {
            [dict setObject:[NSNumber numberWithInteger:_ad.lineItemId] forKey:@"line_item"];
        }
        if (_ad.creative) {
            if (_ad.creative.creativeId) {
                [dict setObject:[NSNumber numberWithInteger:_ad.creative.creativeId] forKey:@"creative"];
            }
        }
    }
    if (_type != NoAd) {
        if (_type == viewable_impression) {
            [dict setObject:SAEventTypeFromValue(_type) forKey:@"type"];
        }
        else {
            [dict setObject:[NSString stringWithFormat:@"custom.%@", SAEventTypeFromValue(_type)] forKey:@"type"];
        }
    }
    if (_details) {
        if (_details.value > 0) {
            [dict setObject:@{@"value":[NSNumber numberWithInteger:_details.value]} forKey:@"details"];
        }
    }
    
    return dict;
}

@end
