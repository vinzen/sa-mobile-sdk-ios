//
//  SASerializer.m
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import "SASerializer.h"
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"

@implementation SASerializer

+ (NSDictionary*) serializeAdEssentials:(SAAd *)ad {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (ad) {
        if (ad.placementId) {
            [dict setObject:[NSNumber numberWithInteger:ad.placementId] forKey:@"placement"];
        }
        if (ad.lineItemId) {
            [dict setObject:[NSNumber numberWithInteger:ad.lineItemId] forKey:@"line_item"];
        }
        if (ad.creative) {
            if (ad.creative.creativeId) {
                [dict setObject:[NSNumber numberWithInteger:ad.creative.creativeId] forKey:@"creative"];
            }
        }
    }
        
    return dict;
}

@end
