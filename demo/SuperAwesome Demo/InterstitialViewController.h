//
//  InterstitialViewController.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 26/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterstitialViewController : UIViewController

@property (nonatomic,weak) IBOutlet UIButton *showButton;

- (IBAction)presentInterstitial:(id)sender;

@end
