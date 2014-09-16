//
//  SAAlertView.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 16/09/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAAlertView.h"

@implementation SAAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    return [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if(buttonIndex == 1){
        return;
    }
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

@end
