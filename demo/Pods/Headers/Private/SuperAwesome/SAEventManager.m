//
//  SAEventManager.m
//  Pods
//
//  Created by Gabriel Coman on 19/09/2015.
//
//

#import "SAEventManager.h"
#import "SuperAwesome.h"
#import "SAAdManager.h"
#import "SAAdRequest.h"
#import "SAEventRequest.h"
#import "SAAdCreative.h"
#import "SANetManager.h"

////////////////////////////////////////////////////////////////////////
// part of the code that dynamically transforms Enum values into string values
// basically these are internal functions anyway
////////////////////////////////////////////////////////////////////////
NSString *SAEventTypeFromValue(SAEventType evt) {
    const char* c_str = 0;
#define PROCESS_VAL(p) case(p): c_str = #p; break;
    switch(evt) {
            PROCESS_VAL(NoAd);
            PROCESS_VAL(AdFetched);
            PROCESS_VAL(AdLoaded);
            PROCESS_VAL(viewable_impression);
            PROCESS_VAL(AdFailed);
            PROCESS_VAL(AdStart);
            PROCESS_VAL(AdStop);
            PROCESS_VAL(AdResume);
            PROCESS_VAL(AdRate);
            PROCESS_VAL(UserCanceledParentalGate);
            PROCESS_VAL(UserSuccessWithParentalGate);
            PROCESS_VAL(UserErrorWithParentalGate);
    }
#undef PROCESS_VAL
    
    return [NSString stringWithCString:c_str encoding:NSASCIIStringEncoding];
}

////////////////////////////////////////////////////////////////////////
// Event Manager Implementation (Base class)
////////////////////////////////////////////////////////////////////////

@interface SAEventManager ()
@property (nonatomic, strong) SAEventRequest *request;
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
        _request = [[SAEventRequest alloc] init];
    }
    
    return self;
}

// internal Event manager functions
- (NSDictionary*) transformSAEventRequestToDictionary:(SAEventRequest*)request {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (request.lineItemID) {
        [dict setObject:[f numberFromString:request.lineItemID] forKey:@"line_item"];
    }
    if (request.creativeID) {
        [dict setObject:[f numberFromString:request.creativeID] forKey:@"creative"];
    }
    if (request.placementID) {
        [dict setObject:[f numberFromString:request.placementID] forKey:@"placement"];
    }
    if (request.type != NoAd) {
        if (request.type == viewable_impression) {
            [dict setObject:SAEventTypeFromValue(request.type) forKeyedSubscript:@"type"];
        }
        else {
            [dict setObject:[NSString stringWithFormat:@"custom.%@", SAEventTypeFromValue(request.type)] forKeyedSubscript:@"type"];
        }
    }
    if (request.detailValue > 0) {
        [dict setObject:@{@"value":[NSNumber numberWithInt:request.detailValue]} forKey:@"details"];
    }
    
    return dict;
}

- (void) assignRequestFromResponse:(SAAdResponse*)response {
    _request.creativeID = response.creative.creativeID;
    _request.lineItemID = response.lineItemID;
    _request.placementID = response.placementID;
    _request.detailValue = -1; // reset the detail value
}

// private function to actually send the event
- (void) sendEventWithRequest:(SAEventRequest*)evtrequest {
    // final getting ready
    NSDictionary *evtrequestDict = [[SAEventManager sharedInstance] transformSAEventRequestToDictionary:evtrequest];
    
    // send POST event
    dispatch_async(dispatch_get_main_queue(), ^{
        [SANetManager sendPOSTtoEndpoint:@"event" withBodyDict:evtrequestDict andSuccess:^(NSData *data){} orFailure:^{}];
    });
}

- (void) sendClickWithRequest:(SAEventRequest*)evtrequest {
    // final getting ready
    NSDictionary *evtrequestDict = [[SAEventManager sharedInstance] transformSAEventRequestToDictionary:evtrequest];
    
    // send POST event
    dispatch_async(dispatch_get_main_queue(), ^{
        [SANetManager sendPOSTtoEndpoint:@"click" withBodyDict:evtrequestDict andSuccess:^(NSData *data){} orFailure:^{}];
    });
}

///////////////
// Actual Logging functions

- (void) LogAdFetched:(SAAdResponse*) response{
    _request.type = AdFetched;
    [self assignRequestFromResponse:response];
    [[SAEventManager sharedInstance] sendEventWithRequest:_request];
}
- (void) LogAdLoaded:(SAAdResponse*) response{
    _request.type = AdLoaded;
    [self assignRequestFromResponse:response];
    [[SAEventManager sharedInstance] sendEventWithRequest:_request];
}
- (void) LogViewableImpression:(SAAdResponse*) response{
    _request.type = viewable_impression;
    [self assignRequestFromResponse:response];
    [[SAEventManager sharedInstance] sendEventWithRequest:_request];
}
- (void) LogAdFailed:(SAAdResponse*) response{
    _request.type = AdFailed;
    [self assignRequestFromResponse:response];
    [[SAEventManager sharedInstance] sendEventWithRequest:_request];
}
- (void) LogAdStart:(SAAdResponse*) response{
    _request.type = AdStart;
    [self assignRequestFromResponse:response];
    [[SAEventManager sharedInstance] sendEventWithRequest:_request];
}
- (void) LogAdStop:(SAAdResponse*) response{
    _request.type = AdStop;
    [self assignRequestFromResponse:response];
    [[SAEventManager sharedInstance] sendEventWithRequest:_request];
}
- (void) LogAdResume:(SAAdResponse*) response{
    _request.type = AdResume;
    [self assignRequestFromResponse:response];
    [[SAEventManager sharedInstance] sendEventWithRequest:_request];
}
- (void) LogUserCanceledParentalGate:(SAAdResponse*) response{
    _request.type = UserCanceledParentalGate;
    [self assignRequestFromResponse:response];
    [[SAEventManager sharedInstance] sendEventWithRequest:_request];
}
- (void) LogUserSuccessWithParentalGate:(SAAdResponse*) response{
    _request.type = UserSuccessWithParentalGate;
    [self assignRequestFromResponse:response];
    [[SAEventManager sharedInstance] sendEventWithRequest:_request];
}
- (void) LogUserErrorWithParentalGate:(SAAdResponse*) response{
    _request.type = UserErrorWithParentalGate;
    [self assignRequestFromResponse:response];
    [[SAEventManager sharedInstance] sendEventWithRequest:_request];
}

- (void) LogClick:(SAAdResponse*) response {
    _request.type = -1;
    [self assignRequestFromResponse:response];
    [[SAEventManager sharedInstance] sendClickWithRequest:_request];
}

- (void) LogRating:(SAAdResponse *)response withValue:(int)rating {
    [self assignRequestFromResponse:response];
    _request.type = AdRate;
    _request.detailValue = rating;
    [[SAEventManager sharedInstance] sendEventWithRequest:_request];
}

@end
