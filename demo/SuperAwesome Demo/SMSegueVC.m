//
//  SMSegueVC.m
//  SuperAwesome Demo
//
//  Created by Gabriel Coman on 12/10/2015.
//  Copyright © 2015 SuperAwesome Ltd. All rights reserved.
//

#import "SMSegueVC.h"
#import "SuperAwesome.h"

@interface SMSegueVC () <SALoaderProtocol>
@property (nonatomic, retain) SAInterstitialAd *inter;
@end

@implementation SMSegueVC

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [[SALoader sharedManager] preloadAdForPlacementId:21924];
    [[SALoader sharedManager] setDelegate:self];
    
    _inter = [[SAInterstitialAd alloc] init];
}

- (IBAction)openVC:(id)sender {
    [_inter playPreloaded];
}

- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId {
    [_inter setAd:ad];
}

- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId {
    NSLog(@"Fail to load ad");
}

@end
