//
//  SAParser.m
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import "SAParser.h"
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"
#import "SAStringifier.h"

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
    
    _Nullable id creativeIdObj = [dict objectForKey:@"creative_id"];
    _Nullable id nameObj = [dict objectForKey:@"name"];
    _Nullable id cpmObj = [dict objectForKey:@"cpm"];
    _Nullable id formatObj = [dict objectForKey:@"format"];
    _Nullable id impressionUrlObj = [dict objectForKey:@"impression_url"];
    _Nullable id clickUrlObj = [dict objectForKey:@"click_url"];
    _Nullable id approvedObj = [dict objectForKey:@"approved"];
    
    creative.creativeId = (creativeIdObj != NULL ? [creativeIdObj integerValue] : -1);
    creative.cpm = (cpmObj != NULL ? [cpmObj integerValue] : 0);
    creative.name = (nameObj != NULL ? nameObj : NULL);
    creative.impressionURL = (impressionUrlObj != NULL ? impressionUrlObj : NULL);
    creative.clickURL = (clickUrlObj != NULL ? clickUrlObj : @"http://superawesome.tv");
    creative.approved = (approvedObj != NULL ? [approvedObj boolValue] : false);
    
    // get format & assign details based on format contract
    creative.format = format_unknown;
    if (formatObj != NULL) {
        if ([formatObj isEqualToString:[SAStringifier creativeFormatToString:image_with_link]]) {
            creative.format = image_with_link;
        }
        if ([formatObj isEqualToString:[SAStringifier creativeFormatToString:video]]) {
            creative.format = video;
        }
        if ([formatObj isEqualToString:[SAStringifier creativeFormatToString:rich_media]]) {
            creative.format = rich_media;
        }
        if ([formatObj isEqualToString:[SAStringifier creativeFormatToString:rich_media_resizing]]) {
            creative.format = rich_media_resizing;
        }
        if ([formatObj isEqualToString:[SAStringifier creativeFormatToString:swf]]) {
            creative.format = swf;
        }
        if ([formatObj isEqualToString:[SAStringifier creativeFormatToString:tag]]) {
            creative.format = tag;
        }
    }
    
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
    _Nullable id valueObj = [dict valueForKey:@"dict"];
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
    
    if (placementFormatObj != NULL) {
        if ([placementFormatObj isEqualToString:[SAStringifier placementFormatToString:web_display]]) {
            details.placementFormat = web_display;
        }
        if([placementFormatObj isEqualToString:@"floor"]){
            details.placementFormat = floor_display;
        }
    }
    
    return details;
}

@end
