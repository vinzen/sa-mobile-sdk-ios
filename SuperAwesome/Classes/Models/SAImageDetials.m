//
//  SAImageDetials.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SAImageDetials.h"

@implementation SAImageDetials

- (id) initWithDictionary:(NSDictionary *)dict {
    if (self = [super initWithDictionary:dict]) {
        _Nullable id imageObj = [dict objectForKey:@"image"];
        
        _image = (imageObj != NULL ? imageObj : NULL);
    }
    
    return self;
}

@end
