//
//  MainViewController.m
//  SuperAwesome Demo
//
//  Created by Balázs Kiss on 20/04/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) NSDictionary *choices;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *choic = @{
        @"In view Ads":@[
                @{@"name":@"Standard Mobile",
                  @"segue": @"ToBannerSegue"},
                @{@"name":@"SM Mobile",
                  @"segue":@"ToSMSegue"},
                @{@"name":@"Leaderboard",
                  @"segue":@"ToLeaderboardSegue"},
                @{@"name":@"MPU",
                  @"segue":@"ToMPUSegue"},
                @{@"name":@"Video",
                  @"segue":@"ToVideoSegue"}
        ],
        @"Fullscreen Ads":@[
                @{@"name":@"Intestitial",
                  @"segue":@"ToInterstitialSegue"},
                @{@"name":@"Video",
                  @"segue":@"ToFullscreenVideoSegue"},
                @{@"name":@"Gamewall",
                  @"segue":@"ToGamewallSegue"}
                ],
        @"Complex Ad display":@[
                @{@"name":@"Complex display",
                  @"segue":@"ToComplexSegue"},
                @{@"name":@"Rich media display",
                  @"segue":@"ToRichMediaSegue"}
                ]
    };
    _choices = choic;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [_choices allKeys].count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [[_choices allKeys] objectAtIndex:section];
    NSArray *arr = [_choices objectForKey:key];
    return [arr count];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *key1 = [[_choices allKeys] objectAtIndex:section];
    
    UIView *black = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-10, 50)];
    black.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:27.0f/255.0f blue:35.0f/255.0f alpha:1];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-10, 50)];
    lbl.text = [key1 capitalizedString];
    lbl.textColor = [UIColor whiteColor];
    [black addSubview:lbl];
    
    return black;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    NSString *key = [[_choices allKeys] objectAtIndex:indexPath.section];
    NSArray *arr = [_choices objectForKey:key];
    NSDictionary *dict = [arr objectAtIndex:indexPath.row];
    NSString *title = [dict objectForKey:@"name"];
    
    cell.textLabel.text = title;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // do nothing
    
    NSString *key = [[_choices allKeys] objectAtIndex:indexPath.section];
    NSArray *arr = [_choices objectForKey:key];
    NSDictionary *dict = [arr objectAtIndex:indexPath.row];
    NSString *segue = [dict objectForKey:@"segue"];
    
    [self performSegueWithIdentifier:segue sender:self];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

@end
