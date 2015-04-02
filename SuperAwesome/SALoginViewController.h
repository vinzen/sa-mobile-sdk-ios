//
//  SALoginViewController.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 01/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SALoginViewController;

@protocol SALoginViewControllerDelegate <UINavigationControllerDelegate>

@optional
- (void)loginViewController:(SALoginViewController *)loginVC didSucceedWithToken:(NSString *)token;
- (void)loginViewController:(SALoginViewController *)loginVC didFailWithError:(NSString *)error;

@end

@interface SALoginViewController : UINavigationController

@property (nonatomic,weak) id<SALoginViewControllerDelegate> delegate;

@end
