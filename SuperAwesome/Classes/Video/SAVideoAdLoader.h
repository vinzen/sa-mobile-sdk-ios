//
//  SAVideoAdLoader.h
//  Pods
//
//  Created by Balázs Kiss on 20/04/15.
//
//

#import <Foundation/Foundation.h>
#import "IMAAdsLoader.h"

@class SAVideoAdLoader;

@protocol SAVideoAdLoaderDelegate <NSObject>
@optional

- (void)didLoadVideoAd:(SAVideoAdLoader *)videoAdLoader;
- (void)didFailToLoadVideoAd:(SAVideoAdLoader *)videoAdLoader;

@end


@interface SAVideoAdLoader : NSObject <IMAAdsLoaderDelegate>

@property (nonatomic,weak) id<SAVideoAdLoaderDelegate> delegate;
@property (nonatomic,strong) UIView *adDisplayContainer;
@property (nonatomic,strong) IMAAdsManager *adsManager;
@property (nonatomic,readonly) BOOL success;
@property (nonatomic,readonly,getter=isLoading) BOOL loading;

- (instancetype)initWithPlacementID:(NSString *)placementID;
- (void)load;

@end
