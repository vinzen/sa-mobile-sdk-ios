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
#import "IMAAdsLoader.h"


@class SAVideoView;

@protocol SAVideoViewDelegate <NSObject>
@optional

- (void)didLoadVideoAd:(SAVideoView *)videoAd;
- (void)didStartPlayingVideoAd:(SAVideoView *)videoAd;
- (void)didFinishPlayingVideoAd:(SAVideoView *)videoAd;

@end


@interface SAVideoView : UIView <IMAAdsLoaderDelegate, IMAAdsManagerDelegate>

@property (nonatomic,weak) id<SAVideoViewDelegate> delegate;
@property (nonatomic,assign) BOOL autoplay;
@property (nonatomic,strong) NSNumber *placementId;

- (void)play;
- (void)stop;

@end
