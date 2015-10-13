//
//  SASender.m
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

// import header
#import "SASender.h"

// import models
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"

// import util files
#import "SASerializer.h"
#import "SuperAwesome.h"
#import "SAStringifier.h"
#import "SANetwork.h"

@implementation SASender

// (private) sa sender function

+ (void) postGenericEventToURL:(NSString*)endpoint forType:(SAEventType)type forAd:(SAAd*)ad {
    // prepare the URL
    NSString *url = [NSString stringWithFormat:@"%@/%@", [[SuperAwesome sharedManager] getBaseURL], endpoint];
    
    // prepare the dict
    NSMutableDictionary *dict = [[SASerializer serializeAdEssentials:ad] mutableCopy];

    // format the event type
    if (type != NoAd) {
        if (type == viewable_impression) {
            [dict setObject:[SAStringifier eventTypeFromValue:type] forKey:@"type"];
        }
        else {
            [dict setObject:[NSString stringWithFormat:@"custom.%@", [SAStringifier eventTypeFromValue:type]] forKey:@"type"];
        }
    }
    
    // format if there is some value attached to it
    if (ad.creative.details.value > 0) {
        [dict setObject:@{@"value":[NSNumber numberWithInteger:ad.creative.details.value]} forKey:@"details"];
    }

    // send data to net
    [SANetwork sendPOSTtoEndpoint:url withBodyDict:dict andSuccess:^(NSData *data) {
       // success
    } orFailure:^{
        // failure
    }];
}

// (public) sa sender functions
+ (void) postEventViewableImpression:(SAAd*)ad {
    [self postGenericEventToURL:@"event" forType:viewable_impression forAd:ad];
}

+ (void) postEventAdFailedToView:(SAAd*)ad {
    [self postGenericEventToURL:@"event" forType:AdFailedToView forAd:ad];
}

+ (void) postEventAdRate:(SAAd*)ad withValue:(NSInteger)value {
    SAAd *_ad = ad;
    _ad.creative.details.value = value;
    [self postGenericEventToURL:@"event" forType:AdRate forAd:ad];
}

+ (void) postEventPGCancel:(SAAd*)ad {
    [self postGenericEventToURL:@"event" forType:AdPGCancel forAd:ad];
}

+ (void) postEventPGSuccess:(SAAd*)ad {
    [self postGenericEventToURL:@"event" forType:AdPGSuccess forAd:ad];
}

+ (void) postEventPGError:(SAAd*)ad {
    [self postGenericEventToURL:@"event" forType:AdPGError forAd:ad];
}

+ (void) postEventClick:(SAAd*)ad {
    [self postGenericEventToURL:@"click" forType:NoAd forAd:ad];
}

@end
