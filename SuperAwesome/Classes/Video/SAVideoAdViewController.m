//
//  SAVideoAdViewController2.m
//  Pods
//
//  Created by Gabriel Coman on 22/09/2015.
//
//

#import "SAVideoAdViewController.h"
#import "SAVideoAdView.h"

@interface SAVideoAdViewController () <SAVideoAdViewProtocol>

// internal property
@property (nonatomic, strong) SAVideoAdView *videoAd;

@end

@implementation SAVideoAdViewController

- (id) initWithPlacementId:(NSString *)placementID {
    if (self = [super init]) {
        _placementID = placementID;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _videoAd = [[SAVideoAdView alloc] initWithFrame:self.view.frame];
    _videoAd.shouldAutoplay = false;
    _videoAd.isFullscreen = true;
    _videoAd.placementID = _placementID;
    _videoAd.parentalGateEnabled = _parentalGateEnabled;
    _videoAd.delegate = self;
    _videoAd.canSkip = true;
    [self.view addSubview:_videoAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SAVideoAdView2 delegate

- (void) didLoadVideoAd:(UIView *)view {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didLoadVideoAd:)]) {
        [self.delegate didLoadVideoAd:self];
    }
}

- (void) didShowVideoAd:(UIView *)view {
    [_videoAd play];
}

- (void) didFailShowingAd:(UIView *)view {
    // dismiss & clear on error
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadVideoAd:)]) {
        [self.delegate didFailToLoadVideoAd:self];
    }
}

- (void) didFinishPlayingVideoAd:(UIView *)videoAd {
    // dismiss & clear
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishPlayingVideoAd:)]) {
        [self.delegate didFinishPlayingVideoAd:self];
    }
}

- (void) didPressOnSkip:(UIView *)view {
    // dismiss & clear
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishPlayingVideoAd:)]) {
        [self.delegate didFinishPlayingVideoAd:self];
    }
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
