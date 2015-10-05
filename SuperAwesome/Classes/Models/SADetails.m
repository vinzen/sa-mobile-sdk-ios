//
//  SADetails.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SADetails.h"

@implementation SADetails

- (id) initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        
        // parse the info
        _Nullable id widthObj = [dict objectForKey:@"width"];
        _Nullable id heightObj = [dict objectForKey:@"height"];
        
        _width = (widthObj != NULL ? [widthObj integerValue] : 0);
        _height = (heightObj != NULL ? [heightObj integerValue] : 0);
    }
    
    return self;
}

@end
