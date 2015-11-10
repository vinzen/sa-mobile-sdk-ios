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
    
    _videoAd = [[SAVideoAdView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height - 25.0f)];
    _videoAd.shouldAutoplay = false;
    _videoAd.isFullscreen = true;
    _videoAd.placementID = _placementID;
    _videoAd.parentalGateEnabled = _parentalGateEnabled;
    _videoAd.delegate = self;
    _videoAd.canSkip = true;
    [self.view addSubview:_videoAd];
    [_videoAd play];
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
    
}

- (void) didFailShowingAd:(UIView *)view {
    // dismiss & clear on error
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadVideoAd:)]) {
        [self.delegate didFailToLoadVideoAd:self];
    }
}

- (void)didStartPlayingVideoAd:(UIView *)videoAd {
    if (_delegate && [_delegate respondsToSelector:@selector(didStartPlayingVideoAd:)]){
        [_delegate didStartPlayingVideoAd:self];
    }
}
- (void)didReachFirstQuartile:(UIView*)videoAd {
    if (_delegate && [_delegate respondsToSelector:@selector(didReachFirstQuartile:)]){
        [_delegate didReachFirstQuartile:self];
    }
}
- (void)didReachHalfpoint:(UIView*)videoAd {
    if (_delegate && [_delegate respondsToSelector:@selector(didReachHalfpoint:)]){
        [_delegate didReachHalfpoint:self];
    }
}
- (void)didReachThirdQuartile:(UIView*)videoAd {
    if (_delegate && [_delegate respondsToSelector:@selector(didReachThirdQuartile:)]){
        [_delegate didReachThirdQuartile:self];
    }
}
- (void)didFailToPlayVideoAd:(UIView *)videoAd {
    if (_delegate && [_delegate respondsToSelector:@selector(didFailToPlayVideoAd:)]){
        [_delegate didFailToPlayVideoAd:self];
    }
}
- (void)didClickVideoAd:(UIView *)videoAd {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickVideoAd:)]){
        [_delegate didClickVideoAd:self];
    }
}

- (void) didFinishPlayingVideoAd:(UIView *)videoAd {
    // dismiss & clear
//    [_videoAd stop];
//    [_videoAd removeFromSuperview];
//    _videoAd = nil;

//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishPlayingVideoAd:)]) {
        [self.delegate didFinishPlayingVideoAd:self];
    }
}

- (void) didPressOnSkip:(UIView *)view {
    // dismiss & clear
//    [_videoAd stop];
//    [_videoAd removeFromSuperview];
//    _videoAd = nil;
    
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didPressOnSkip:)]){
        [_delegate didPressOnSkip:self];
    }
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishPlayingVideoAd:)]) {
//        [self.delegate didFinishPlayingVideoAd:self];
//    }
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
