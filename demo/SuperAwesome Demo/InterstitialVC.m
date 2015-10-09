//
//  InterstitialVC.m
//  SuperAwesome Demo
//
//  Created by Gabriel Coman on 08/10/2015.
//  Copyright © 2015 SuperAwesome Ltd. All rights reserved.
//

#import "InterstitialVC.h"
#import "SuperAwesome.h"

@interface InterstitialVC () <SAPreloadProtocol>
@property (nonatomic, retain) SAInterstitialAd *inter;
@end

@implementation InterstitialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[SAAdPreloader sharedManager] setDelegate:self];
    [[SAAdPreloader sharedManager] preloadAd:21450];
    
    _inter = [[SAInterstitialAd alloc] initWithPlcementId:21450];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction) playAction:(id)sender {
    [_inter play];
}

- (void) didPreloadAd:(SAAd *)ad {
    [_inter assignAd:ad];
}

- (void) didFailToPreloadAd:(NSInteger)placementId {
    NSLog(@"Fail to load");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
