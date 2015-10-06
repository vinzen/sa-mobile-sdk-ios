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
@property (nonatomic, strong) SAFullscreenVideoAd *vad;
@end

@implementation FullscreenVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Fullscreen Video Ad";
    
    _vad = [[SAFullscreenVideoAd alloc] initWithParentVC:self andPlcementId:10002];
    [_vad play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)play:(id)sender
{
    [_vad play];
}

@end
