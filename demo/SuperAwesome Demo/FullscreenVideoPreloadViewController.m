//
//  FullscreenVideoPreloadViewController.m
//  SuperAwesome Demo
//
//  Created by Balázs Kiss on 20/04/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "FullscreenVideoPreloadViewController.h"

@interface FullscreenVideoPreloadViewController ()


@end

@implementation FullscreenVideoPreloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.playButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)load:(id)sender
{
    self.playButton.enabled = NO;
}

- (IBAction)play:(id)sender
{
}


@end
