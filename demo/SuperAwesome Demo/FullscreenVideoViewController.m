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

@property (nonatomic,strong) SAVideoAdViewController *vc;

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!self.vc){
        self.vc = [[SAVideoAdViewController alloc] initWithAppID:@"14" placementID:@"314228"];
        [self presentViewController:self.vc animated:YES completion:nil];
    }
}

@end
