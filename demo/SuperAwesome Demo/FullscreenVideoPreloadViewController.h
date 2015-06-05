//
//  FullscreenVideoPreloadViewController.h
//  SuperAwesome Demo
//
//  Created by Balázs Kiss on 20/04/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperAwesome.h"

@interface FullscreenVideoPreloadViewController : UIViewController <SAVideoAdViewControllerDelegate>

@property (nonatomic,weak) IBOutlet UIButton *loadButton;
@property (nonatomic,weak) IBOutlet UIButton *playButton;

- (IBAction)load:(id)sender;
- (IBAction)play:(id)sender;

@end
