//
//  SAVideoAdViewController
//  SAMobileSDK
//
//  Created by Balázs Kiss on 03/02/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperAwesome.h"

@class SAVideoAdViewController;

@protocol SAVideoAdViewControllerDelegate <NSObject>
@optional

- (void)didLoadVideoAd:(SAVideoAdViewController *)videoAdViewController;
- (void)didFailToLoadVideoAd:(SAVideoAdViewController *)videoAdViewController;

@end

@interface SAVideoAdViewController : UIViewController <SAVideoAdViewDelegate>

@property (nonatomic,weak) id<SAVideoAdViewControllerDelegate> delegate;
@property (nonatomic,strong) SAVideoAdView *videoView;
@property (assign,nonatomic,getter=isParentalGateEnabled) BOOL parentalGateEnabled;

- (instancetype)initWithAppID:(NSString *)appID placementID:(NSString *)placementID;
- (instancetype)initWithAdLoader:(SAVideoAdLoader *)adLoader;

@end
