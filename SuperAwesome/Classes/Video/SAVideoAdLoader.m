//
//  SAVideoAdLoader.m
//  Pods
//
//  Created by Balázs Kiss on 20/04/15.
//
//

#import "SAVideoAdLoader.h"
#import "SuperAwesome.h"
#import "SKLogger.h"

@interface SAVideoAdLoader ()

@property (nonatomic,strong) NSString *placementID;
@property (nonatomic,strong) SAAdResponse *adResponse;
@property (nonatomic,strong) IMAAdsLoader *adsLoader;

@end

@implementation SAVideoAdLoader

- (instancetype)initWithPlacementID:(NSString *)placementID
{
    if (self = [super init]){
        _placementID = placementID;
        _adDisplayContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        _loading = YES;
        _success = NO;
    }
    return self;
}

- (void)load
{
    SAAdManager *adLoader = [[SuperAwesome sharedManager] adManager];
    SAAdRequest *adRequest = [[SAAdRequest alloc] initWithPlacementId:self.placementID];
    [adLoader loadAd:adRequest completion:^(SAAdResponse *response, NSError *error) {
        if(error != nil){
            [SKLogger error:@"SAVideoAdLoader" withMessage:@"Failed to fetch ad"];
            if(self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadVideoAd:)]){
                [self.delegate didFailToLoadVideoAd:self];
            }
            return ;
        }
        
        self.adResponse = response;
        
        if(![self.adResponse.creative.format isEqualToString:@"video"]){
            [SKLogger error:@"SAVideoAdLoader" withMessage:@"Unsupported format received from ad server"];
            if(self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadVideoAd:)]){
                [self.delegate didFailToLoadVideoAd:self];
            }
            return ;
        }
        
        NSString *vast = [self.adResponse.creative.details objectForKey:@"vast"];
        if(vast == nil || [vast isEqualToString:@""]){
            [SKLogger error:@"SAVideoAdLoader" withMessage:@"Ad response contained empty VAST tag"];
            if(self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadVideoAd:)]){
                [self.delegate didFailToLoadVideoAd:self];
            }
            return ;
        }
        
        [self requestAdsWithVAST:vast];
    }];
}

- (void)requestAdsWithVAST:(NSString *)vastURL
{
    
    IMAAdDisplayContainer *adDisplayContainer = [[IMAAdDisplayContainer alloc] initWithAdContainer:self.adDisplayContainer companionSlots:nil];
    IMAAdsRequest *request = [[IMAAdsRequest alloc] initWithAdTagUrl:vastURL adDisplayContainer:adDisplayContainer userContext:nil];
    
    IMASettings *settings = [[IMASettings alloc] init];
    settings.ppid = @"IMA_PPID_0";
    settings.language = @"en";
    
    self.adsLoader = [[IMAAdsLoader alloc] initWithSettings:settings];
    self.adsLoader.delegate = self;
    [self.adsLoader requestAdsWithRequest:request];
}


#pragma mark AdLoader

- (void)adsLoader:(IMAAdsLoader *)loader adsLoadedWithData:(IMAAdsLoadedData *)adsLoadedData {
    [SKLogger error:@"SAVideoAdLoader" withMessage:@"Ad has laoded"];
    
    _loading = NO;
    _success = YES;
    
    self.adsManager = adsLoadedData.adsManager;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didLoadVideoAd:)]){
        [self.delegate didLoadVideoAd:self];
    }    
}

- (void)adsLoader:(IMAAdsLoader *)loader failedWithErrorData:(IMAAdLoadingErrorData *)adErrorData {
    [SKLogger error:@"SAVideoAdLoader" withMessage:@"Ad loading error"];
    
    _loading = NO;
    _success = NO;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadVideoAd:)]){
        [self.delegate didFailToLoadVideoAd:self];
    }
}


@end
