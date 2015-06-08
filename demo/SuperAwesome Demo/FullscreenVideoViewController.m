//
//  FullscreenVideoViewController.m
//  SuperAwesome Demo
//
//  Created by Balázs Kiss on 21/04/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "FullscreenVideoViewController.h"
#import "SuperAwesome.h"

@interface FullscreenVideoViewController ()

@end

@implementation FullscreenVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Fullscreen Video Ad";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)play:(id)sender
{
    SAVideoAdViewController *vc = [[SAVideoAdViewController alloc] initWithPlacementID:@"271"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
