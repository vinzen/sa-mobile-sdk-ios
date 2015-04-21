//
//  MainViewController.m
//  SuperAwesome Demo
//
//  Created by Balázs Kiss on 20/04/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "FullscreenVideoViewController.h"
#import "FullscreenVideoPreloadViewController.h"

@interface MainViewController ()
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    
    if([text isEqualToString:@"Fullscreen Video Ad"]){
        FullscreenVideoViewController *vc = [[FullscreenVideoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
