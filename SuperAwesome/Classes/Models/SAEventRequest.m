//
//  SAEventRequest.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 20/01/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "SAEventRequest.h"

@implementation SAEventRequest

- (NSDictionary *)dictionaryValue
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    return @{@"line_item": [f numberFromString:self.lineItemID], @"placement":[f numberFromString:self.placementID], @"type":self.type};
}

- (NSString *)JSONValue
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.dictionaryValue options:0 error:nil];
    return  [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
}

@end
