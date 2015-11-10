//
//  FullscreenVideoViewController.m
//  SuperAwesome Demo
//
//  Created by Balázs Kiss on 21/04/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "FullscreenVideoViewController.h"
#import "SuperAwesome.h"

@interface FullscreenVideoViewController () <SAVideoAdViewControllerProtocol>

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
    SAVideoAdViewController *vc = [[SAVideoAdViewController alloc] initWithPlacementId:@"21022"];
    vc.parentalGateEnabled = YES;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didLoadVideoAd:(SAVideoAdViewController *)videoAdViewController {
    NSLog(@"Video Delegate ---- Load video ad");
}
- (void)didFailToLoadVideoAd:(SAVideoAdViewController *)videoAdViewController {
    NSLog(@"Video Delegate ---- fail to load video ad");
}
- (void)didPressOnSkip:(SAVideoAdViewController*)view {
    NSLog(@"Video Delegate ---- press on skip");
}
- (void)didStartPlayingVideoAd:(SAVideoAdViewController *)videoAd {
    NSLog(@"Video Delegate ---- start playing video ad");
}
- (void)didReachFirstQuartile:(SAVideoAdViewController*)videoAd {
    NSLog(@"Video Delegate ---- reach 1/4");
}
- (void)didReachHalfpoint:(SAVideoAdViewController*)videoAd {
    NSLog(@"Video Delegate ---- reach 1/2");
}
- (void)didReachThirdQuartile:(SAVideoAdViewController*)videoAd {
    NSLog(@"Video Delegate ---- reach 3/4");
}
- (void)didFinishPlayingVideoAd:(SAVideoAdViewController *)videoAd {
    NSLog(@"Video Delegate ---- reach end");
}
- (void)didFailToPlayVideoAd:(SAVideoAdViewController *)videoAd {
    NSLog(@"Video Delegate ---- fail to play ad");
}
- (void)didClickVideoAd:(SAVideoAdViewController *)videoAd {
    NSLog(@"Video Delegate ---- click on ad");
}

@end
