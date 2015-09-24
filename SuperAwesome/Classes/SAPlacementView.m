//
//  SAPlacement.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 01/12/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAPlacementView.h"
#import "SuperAwesome.h"
#import "SAPadlockView.h"

@implementation SAPlacementView : UIView

// function that setsup the padlock
- (void) setupPadlockButton:(UIView*)parent {
    CGRect main_frame = parent.frame;
    CGSize padlock_size = CGSizeMake(15, 15);
    CGRect padlock_frame = CGRectMake(main_frame.size.width - padlock_size.width,
                                      main_frame.size.height - padlock_size.height,
                                      padlock_size.width,
                                      padlock_size.height);
    
    _padlockBtn = [[UIButton alloc] initWithFrame:padlock_frame];
    [_padlockBtn setImage:[UIImage imageNamed:@"sa_padlock"] forState:UIControlStateNormal];
    [_padlockBtn addTarget:self action:@selector(padlockBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [parent addSubview:_padlockBtn];
    [parent bringSubviewToFront:_padlockBtn];
}

- (void) removePadlockButton {
    [_padlockBtn removeFromSuperview];
}

// if the user presses on the padlock button
// create a new padlock view
- (IBAction)padlockBtnAction:(id)sender {
    SAPadlockView *pad = [[SAPadlockView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:pad];
}


@end
