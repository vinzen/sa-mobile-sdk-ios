//
//  SAVideoView.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 03/09/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ADTECHMobileSDK/ADTECHMobileSDK.h>
#import "UIView+FindUIViewController.h"

typedef NS_ENUM(NSUInteger, SAVideoAdType) {
    kVideoAdPreRoll,
    kVideoAdMidRoll,
    kVideoAdPostRoll
};

@interface SAVideoView : UIView

@property (nonatomic,strong) ATMoviePlayerController *moviePlayerController;

- (void)playVideo:(NSURL *)url;
- (void)enableAdType:(SAVideoAdType)adType;

@end
