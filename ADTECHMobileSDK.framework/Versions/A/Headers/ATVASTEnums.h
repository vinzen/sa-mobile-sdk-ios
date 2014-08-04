//
//  ATVASTEnums.h
//  ADTECHMobileSDK
//
//  Created by ADTECH AG on 4/20/12.
//  Copyright (c) 2012 ADTECH AG. All rights reserved.
//

#ifndef ADTECHMobileSDK_ATVASTEnums_h
#define ADTECHMobileSDK_ATVASTEnums_h

typedef NS_ENUM(NSUInteger, ATVASTTriState)
{
    kATVASTNotSet,
    kATVASTTrue,
    kATVASTFalse,
};

typedef NS_ENUM(NSUInteger, ATVASTTrackingEvent)
{
    kATTrackingEventInvalid,
    kATTrackingEventCreativeView,
    kATTrackingEventStart,
    kATTrackingEventMidpoint,
    kATTrackingEventFirstQuartile,
    kATTrackingEventThirdQuartile,
    kATTrackingEventComplete,
    kATTrackingEventMute,
    kATTrackingEventUnmute,
    kATTrackingEventPause,
    kATTrackingEventRewind,
    kATTrackingEventResume,
    kATTrackingEventFullscreen,
    kATTrackingEventExpand,
    kATTrackingEventCollapse,
    kATTrackingEventAcceptInvitation,
    kATTrackingEventClose,
    
    // ADTECH extension for events.
    kATTrackingEventNonIABReplay,
    kATTrackingEventNonIABStop,
    
};

typedef NS_ENUM(NSUInteger, ATVASTProprietaryExtensionType)
{
    kATVASTExtensionTypeUnknown = 0,
    kATVASTExtensionTypeMidRollStartTime = 1,
	kATVASTExtensionTypeLinearSkipTime = 2,
    
};

#endif
