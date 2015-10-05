//
//  SAVideoDetails.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SAVideoDetails.h"

@implementation SAVideoDetails

- (id) initWithDictionary:(NSDictionary *)dict {
    if (self = [super initWithDictionary:dict]) {
        _Nullable id nameObj = [dict objectForKey:@"name"];
        _Nullable id videoObj = [dict objectForKey:@"video"];
        _Nullable id bitrateObj = [dict objectForKey:@"bitrate"];
        _Nullable id durationObj = [dict objectForKey:@"duration"];
        _Nullable id vastObj = [dict objectForKey:@"vast"];
        
        _name = (nameObj != NULL ? nameObj : NULL);
        _video = (videoObj != NULL ? videoObj : NULL);
        _bitrate = (bitrateObj != NULL ? [bitrateObj integerValue] : 0);
        _duration = (durationObj != NULL ? [durationObj integerValue] : 0);
        _vast = (vastObj != NULL ? vastObj : NULL);
    }
    
    return self;
}

@end
