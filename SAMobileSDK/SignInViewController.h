//
//  SignInViewController.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 26/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SALoginViewController.h"

@interface SignInViewController : UIViewController <SALoginViewControllerDelegate>

- (IBAction)openSignIn:(id)sender;

@end
