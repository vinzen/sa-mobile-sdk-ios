//
//  SAVideoAdLoader.m
//  Pods
//
//  Created by Balázs Kiss on 20/04/15.
//
//

#import "SAVideoAdLoader.h"
#import "SuperAwesome.h"

@interface SAVideoAdLoader ()

@property (nonatomic,strong) NSString *appID;
@property (nonatomic,strong) NSString *placementID;
@property (nonatomic,strong) IMAAdsLoader *adsLoader;

@end

@implementation SAVideoAdLoader

- (instancetype)initWithAppID:(NSString *)appID placementID:(NSString *)placementID
{
    if (self = [super init]){
        _appID = appID;
        _placementID = placementID;
        _adDisplayContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    }
    return self;
}

- (void)load
{
    [[SuperAwesome sharedManager] videoAdForApp:self.appID placement:self.placementID completion:^(SAVideoAd *videoAd) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(videoAd == nil){
                NSLog(@"SA: Could not find placement with the provided ID");
                if(self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadVideoAd:)]){
                    [self.delegate didFailToLoadVideoAd:self];
                }
            }else{
                [self requestAdsWithVideoAd:videoAd];
            }
        });
    }];
}


- (void)requestAdsWithVideoAd:(SAVideoAd *)videoAd
{
    if(videoAd == nil) return;
    
    NSString *adTag = videoAd.vast;
    IMAAdDisplayContainer *adDisplayContainer = [[IMAAdDisplayContainer alloc] initWithAdContainer:self.adDisplayContainer companionSlots:nil];
    IMAAdsRequest *request = [[IMAAdsRequest alloc] initWithAdTagUrl:adTag adDisplayContainer:adDisplayContainer userContext:nil];
    
    IMASettings *settings = [[IMASettings alloc] init];
    settings.ppid = @"IMA_PPID_0";
    settings.language = @"en";
    
    self.adsLoader = [[IMAAdsLoader alloc] initWithSettings:settings];
    self.adsLoader.delegate = self;
    [self.adsLoader requestAdsWithRequest:request];
}


#pragma mark AdLoader

- (void)adsLoader:(IMAAdsLoader *)loader adsLoadedWithData:(IMAAdsLoadedData *)adsLoadedData {
    NSLog(@"SA: Ad loaded");
    
    self.adsManager = adsLoadedData.adsManager;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didLoadVideoAd:)]){
        [self.delegate didLoadVideoAd:self];
    }    
}

- (void)adsLoader:(IMAAdsLoader *)loader failedWithErrorData:(IMAAdLoadingErrorData *)adErrorData {
    NSLog(@"SA: Ad loading error: %@", adErrorData.adError.message);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadVideoAd:)]){
        [self.delegate didFailToLoadVideoAd:self];
    }
}


@end
