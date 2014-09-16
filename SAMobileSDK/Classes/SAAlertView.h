//
//  SAAlertView.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 16/09/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAAlertView : UIAlertView
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;
@end
