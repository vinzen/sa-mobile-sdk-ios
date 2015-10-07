//
//  SAEvent.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <Foundation/Foundation.h>

// forward declaration
@class SAAd;
@class SADetails;

// specific events for the ads
typedef NS_ENUM(NSUInteger, SAEventType) {
    NoAd = -1,
    AdLoad = 0,
    AdFail,
    viewable_impression,
    AdStop,
    AdRate,
    UserPGCancel,
    UserPGSuccess,
    UserPGError
};

// external function
NSString *SAEventTypeFromValue(SAEventType evt);

// interface declaration
@interface SAEvent : NSObject

// member variables
@property (nonatomic, strong) SAAd *ad;
@property (nonatomic, strong) SADetails *details;
@property (nonatomic, assign) SAEventType type;

// custom init
- (id) initWithAd:(SAAd*)ad andDetails:(SADetails*)details andEventType:(SAEventType)type;

// function that reansforms this into an NSMutableDictionary
- (NSDictionary*) dictionaryFromModel;

@end
