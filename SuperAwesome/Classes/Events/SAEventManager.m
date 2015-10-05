//
//  SAEventManager.m
//  Pods
//
//  Created by Gabriel Coman on 19/09/2015.
//
//

#import "SAEventManager.h"
#import "SuperAwesome.h"
#import "SAAd.h"
#import "SAEvent.h"
#import "SACreative.h"
#import "SANetwork+Ad.h"

////////////////////////////////////////////////////////////////////////
// Event Manager Implementation (Base class)
////////////////////////////////////////////////////////////////////////

@interface SAEventManager ()
@property (nonatomic, strong) SAEvent *event;
@end

@implementation SAEventManager

+ (id)sharedInstance {
    static SAEventManager *sharedSA = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSA = [[self alloc] init];
    });
    return sharedSA;
}

- (id) init {
    if (self = [super init]) {
        // do nothing
        _event = [[SAEvent alloc] init];
    }
    
    return self;
}

///////////////
// Actual Logging functions

- (void) LogAdLoad:(SAAd*) ad {
    _event = [[SAEvent alloc] initWithAd:ad andDetails:nil andEventType:AdLoad];
    [SANetwork postEvent:_event withSuccess:^{
       // do nothing
    } orFailure:^{
        // do nohting
    }];
}

- (void) LogAdFail:(SAAd*) ad {
    _event = [[SAEvent alloc] initWithAd:ad andDetails:nil andEventType:AdFail];
    [SANetwork postEvent:_event withSuccess:^{
        // do nothing
    } orFailure:^{
        // do nohting
    }];
}

- (void) LogViewableImpression:(SAAd*) ad {
    _event = [[SAEvent alloc] initWithAd:ad andDetails:nil andEventType:viewable_impression];
    [SANetwork postEvent:_event withSuccess:^{
        // do nothing
    } orFailure:^{
        // do nohting
    }];
}

- (void) LogAdStop:(SAAd*) ad {
    _event = [[SAEvent alloc] initWithAd:ad andDetails:nil andEventType:AdStop];
    [SANetwork postEvent:_event withSuccess:^{
        // do nothing
    } orFailure:^{
        // do nohting
    }];
}

- (void) LogAdRate:(SAAd*) ad  withValue:(NSInteger)value {
    SAValueDetails *details = [[SAValueDetails alloc] init];
    details.value = value;
    
    _event = [[SAEvent alloc] initWithAd:ad andDetails:details andEventType:AdRate];
    [SANetwork postEvent:_event withSuccess:^{
        // do nothing
    } orFailure:^{
        // do nohting
    }];
}

- (void) LogPGCancel:(SAAd*) ad {
    _event = [[SAEvent alloc] initWithAd:ad andDetails:nil andEventType:UserPGCancel];
    [SANetwork postEvent:_event withSuccess:^{
        // do nothing
    } orFailure:^{
        // do nohting
    }];
}

- (void) LogPGSuccess:(SAAd*) ad {
    _event = [[SAEvent alloc] initWithAd:ad andDetails:nil andEventType:UserPGSuccess];
    [SANetwork postEvent:_event withSuccess:^{
        // do nothing
    } orFailure:^{
        // do nohting
    }];
}

- (void) LogPGError:(SAAd*)ad {
    _event = [[SAEvent alloc] initWithAd:ad andDetails:nil andEventType:UserPGError];
    [SANetwork postEvent:_event withSuccess:^{
        // do nothing
    } orFailure:^{
        // do nohting
    }];
}

- (void) LogClick:(SAAd*)ad {
    _event = [[SAEvent alloc] initWithAd:ad andDetails:nil andEventType:NoAd];
    [SANetwork postClick:_event withSuccess:^{
        
    } orFailure:^{
        
    }];
}

@end
