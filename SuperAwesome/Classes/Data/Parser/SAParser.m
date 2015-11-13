//
//  SAParser.m
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import "SAParser.h"
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"
#import "SAStringifier.h"
#import "SuperAwesome.h"

// parser implementation
@implementation SAParser

+ (SAAd*) parseAdWithDictionary:(NSDictionary*)dict {
    SAAd *ad = [[SAAd alloc] init];
    
    _Nullable id errorObj = [dict objectForKey:@"error"];
    _Nullable id lineItemIdObj = [dict objectForKey:@"line_item_id"];
    _Nullable id campaignIdObj = [dict objectForKey:@"campaing_id"];
    _Nullable id isTestObj = [dict objectForKey:@"test"];
    _Nullable id isFallbackObj = [dict objectForKey:@"is_fallback"];
    _Nullable id isFillObj = [dict objectForKey:@"is_fill"];
    
    ad.error = (errorObj != NULL ? [errorObj integerValue] : -1);
    ad.lineItemId = (lineItemIdObj != NULL ? [lineItemIdObj integerValue] : -1);
    ad.campaignId = (campaignIdObj != NULL ? [campaignIdObj integerValue] : -1);
    ad.isTest = (isTestObj != NULL ? [isTestObj boolValue] : true);
    ad.isFallback = (isFallbackObj != NULL ? [isFallbackObj boolValue] : false);
    ad.isFill = (isFillObj != NULL ? [isFillObj boolValue] : false);
    
    return ad;
}

+ (SACreative*) parseCreativeWithDictionary:(NSDictionary*)maindict {
    // check for empty failure
    _Nullable id creativeObj = [maindict objectForKey:@"creative"];
    if (creativeObj == NULL) {
        return nil;
    }
    
    NSDictionary *dict = (NSDictionary*)creativeObj;
    SACreative *creative = [[SACreative alloc] init];
    
    _Nullable id creativeIdObj = [dict objectForKey:@"id"];
    _Nullable id nameObj = [dict objectForKey:@"name"];
    _Nullable id cpmObj = [dict objectForKey:@"cpm"];
    _Nullable id baseFormatObj = [dict objectForKey:@"format"];
    _Nullable id impressionUrlObj = [dict objectForKey:@"impression_url"];
    _Nullable id targetUrlObj = [dict objectForKey:@"click_url"];
    _Nullable id approvedObj = [dict objectForKey:@"approved"];
    
    creative.creativeId = (creativeIdObj != NULL ? [creativeIdObj integerValue] : -1);
    creative.cpm = (cpmObj != NULL ? [cpmObj integerValue] : 0);
    creative.name = (nameObj != NULL ? nameObj : NULL);
    creative.impressionURL = (impressionUrlObj != NULL ? impressionUrlObj : NULL);
    creative.targetURL = (targetUrlObj != NULL ? targetUrlObj : @"http://superawesome.tv");
    creative.approved = (approvedObj != NULL ? [approvedObj boolValue] : false);
    creative.baseFormat = (baseFormatObj != NULL ? baseFormatObj : NULL);
    
    return creative;
}

// function that parses the SADetails main data
+ (SADetails*) parseDetailsWithDictionary:(NSDictionary*)maindict {
    // check for empty failure
    _Nullable id creativeObj = [maindict objectForKey:@"creative"];
    if (creativeObj == NULL) {
        return nil;
    }
    
    _Nullable id detailsObj = [(NSDictionary*)creativeObj objectForKey:@"details"];
    if (detailsObj == NULL) {
        return nil;
    }
    
    NSDictionary *dict = (NSDictionary*)detailsObj;
    SADetails *details = [[SADetails alloc] init];
    
    // parse the info
    _Nullable id widthObj = [dict objectForKey:@"width"];
    _Nullable id heightObj = [dict objectForKey:@"height"];
    _Nullable id imageObj = [dict objectForKey:@"image"];
    _Nullable id valueObj = [dict valueForKey:@"value"];
    _Nullable id nameObj = [dict objectForKey:@"name"];
    _Nullable id videoObj = [dict objectForKey:@"video"];
    _Nullable id bitrateObj = [dict objectForKey:@"bitrate"];
    _Nullable id durationObj = [dict objectForKey:@"duration"];
    _Nullable id vastObj = [dict objectForKey:@"vast"];
    _Nullable id tagObj = [dict objectForKey:@"tag"];
    _Nullable id placementFormatObj = [dict objectForKey:@"placement_format"];
    _Nullable id zipFileObj = [dict objectForKey:@"zip_file"];
    _Nullable id urlObj = [dict objectForKey:@"url"];
    
    details.width = (widthObj != NULL ? [widthObj integerValue] : 0);
    details.height = (heightObj != NULL ? [heightObj integerValue] : 0);
    details.image = (imageObj != NULL ? imageObj : NULL);
    details.value = (valueObj != NULL ? [valueObj integerValue] : -1);
    details.name = (nameObj != NULL ? nameObj : NULL);
    details.video = (videoObj != NULL ? videoObj : NULL);
    details.bitrate = (bitrateObj != NULL ? [bitrateObj integerValue] : 0);
    details.duration = (durationObj != NULL ? [durationObj integerValue] : 0);
    details.vast = (vastObj != NULL ? vastObj : NULL);
    details.tag = (tagObj != NULL ? tagObj : NULL);
    details.zip = (zipFileObj != NULL ? zipFileObj : NULL);
    details.url = (urlObj != NULL ? urlObj : NULL);
    details.placementFormat = (placementFormatObj != NULL ? placementFormatObj : NULL);
    
    return details;
}

+ (SAAd*) finishAdParsing:(SAAd *)_ad {
    SAAd *ad = _ad;
    
    ad.creative.format = invalid;
    if ([ad.creative.baseFormat isEqualToString:@"image_with_link"])   ad.creative.format = image;
    else if ([ad.creative.baseFormat isEqualToString:@"video"])        ad.creative.format = video;
    else if ([ad.creative.baseFormat containsString:@"rich_media"])    ad.creative.format = rich;
    else if ([ad.creative.baseFormat isEqualToString:@"tag"])          ad.creative.format = tag;
    
    NSString *baseURL = [[SuperAwesome sharedManager] getBaseURL];
    ad.creative.clickURL = [NSString stringWithFormat:@"%@/click?placement=%d&line_item=%d&creative=%d&redir=%@",
                            [[SuperAwesome sharedManager] getBaseURL],
                            ad.placementId,
                            ad.lineItemId,
                            ad.creative.creativeId,]
    
    NSString *abc = @"{\"placement\":5692,\"creative\":-1,\"line_item\":-1,\"type\":\"viewable_impression\"}";
    
    
    return ad;
}

@end
