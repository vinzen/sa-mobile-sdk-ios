//
//  SAValueDetails.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SAValueDetails.h"

@implementation SAValueDetails

- (id) initWithDictionary:(NSDictionary *)dict {
    if (self = [super initWithDictionary:dict]) {
        _Nullable id valueObj = [dict valueForKey:@"dict"];
        _value = (valueObj != NULL ? [valueObj integerValue] : -1);
    }
    
    return self;
}

@end
