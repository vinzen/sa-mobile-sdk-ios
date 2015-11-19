//
//  MainViewController.m
//  SuperAwesome Demo
//
//  Created by Balázs Kiss on 20/04/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "SuperAwesome.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, SALoaderProtocol>
@property (nonatomic, retain) NSArray *choices;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *coic = @[
        @{@"name":@"Banner Ad", @"segue":@"Segue1"},
        @{@"name":@"Video Ad", @"segue":@"Segue2"},
        @{@"name":@"Image Interstitial Ad",@"segue":@""},
        @{@"name":@"Tag Interstitial Ad", @"segue":@""},
        @{@"name":@"Rich media Interstitial Ad", @"segue":@""},
        @{@"name":@"Fullscreen Video Ad", @"segue":@""}
    ];
    _choices = coic;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UITableViewDelegate>

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_choices count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    NSDictionary *dict = [_choices objectAtIndex:indexPath.row];
    NSString *title = [dict objectForKey:@"name"];
    
    cell.textLabel.text = title;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // do nothing
    
    NSDictionary *dict = [_choices objectAtIndex:indexPath.row];
    NSString *segue = [dict objectForKey:@"segue"];
    
    if (![segue isEqualToString:@""]) {
        [self performSegueWithIdentifier:segue sender:segue];
    } else {
        [SALoader setDelegate:self];
        
        if (indexPath.row == 2){
            [SALoader loadAdForPlacementId:10324];
        } else if (indexPath.row == 3) {
            [SALoader loadAdForPlacementId:10278];
        } else if (indexPath.row == 4) {
            [SALoader loadAdForPlacementId:30025];
        } else {
            [SALoader loadAdForPlacementId:21022];
        }
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

#pragma mark <SALoaderProtocol>

- (void) didLoadAd:(SAAd *)ad {
    [ad print];
    
    if (ad.placementId == 10324) {
        SAInterstitialAd *i1 = [[SAInterstitialAd alloc] init];
        [i1 setAd:ad];
        [self presentViewController:i1 animated:YES completion:^{
            [i1 play];
        }];
    } else if (ad.placementId == 10278) {
        SAInterstitialAd *i2 = [[SAInterstitialAd alloc] init];
        [i2 setAd:ad];
//        i2.isParentalGateEnabled = true;
        [self presentViewController:i2 animated:YES completion:^{
            [i2 play];
        }];
    } else if (ad.placementId == 30025) {
        SAInterstitialAd *i3 = [[SAInterstitialAd alloc] init];
        [i3 setAd:ad];
        [self presentViewController:i3 animated:YES completion:^{
            [i3 play];
        }];
    } else {
        SAFullscreenVideoAd *fvideo = [[SAFullscreenVideoAd alloc] init];
        [fvideo setAd:ad];
        [self presentViewController:fvideo animated:YES completion:^{
            [fvideo play];
        }];
    }
}

- (void) didFailToLoadAdForPlacementId:(NSInteger)placementId {
    NSLog(@"Failed to load %ld", (long)placementId);
}

@end
