//
//  SAAdHTMLParser.m
//  Pods
//
//  Created by Gabriel Coman on 09/10/2015.
//
//

#import "SAAdHTMLParser.h"

#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"

@implementation SAAdHTMLParser

+ (NSString*) parseHTMLForAd:(SAAd*)ad withExtectedSize:(CGSize)screenSize {
    
    // form HTML
    NSString *htmlRaw = @"";
    
    // get ad details and calculate some variables
    NSInteger scrW = screenSize.width;
    NSInteger scrH = screenSize.height;
    NSInteger movW = (CGFloat)ad.creative.details.width;
    NSInteger movH = (CGFloat)ad.creative.details.height;
    CGFloat dW = MIN((scrW / (CGFloat)movW), 1.0f);
    CGFloat dH = MIN((scrH / (CGFloat)movH), 1.0f);
    CGFloat dT = MIN(dW, dH);
    
    // final movie values
    NSInteger relW = (NSInteger)movW * dT;
    NSInteger relH = (NSInteger)movH * dT;
    NSInteger relX = (NSInteger)((scrW - relW) / 2.0f);
    NSInteger relY = (NSInteger)((scrH - relH) / 2.0f);
    
    // depending on the type of creative
    switch (ad.creative.format) {
        case image_with_link:{
            
            NSString *click = ad.creative.clickURL;
            NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayImage" ofType:@"html"];
            htmlRaw = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"hrefURL" withString:click];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"imgURL" withString:ad.adHTML];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"scrW" withString:[NSString stringWithFormat:@"%ld", scrW]];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"scrH" withString:[NSString stringWithFormat:@"%ld", scrH]];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"relW" withString:[NSString stringWithFormat:@"%ld", relW]];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"relH" withString:[NSString stringWithFormat:@"%ld", relH]];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"relX" withString:[NSString stringWithFormat:@"%ld", relX]];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"relY" withString:[NSString stringWithFormat:@"%ld", relY]];
            
            break;
        }
        case video: {
            
            NSString *click = ad.creative.clickURL;
            NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayVideo" ofType:@"html"];
            htmlRaw = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"videoURL" withString:ad.adHTML];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"hrefURL" withString:click];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"scrW" withString:[NSString stringWithFormat:@"%ld", scrW]];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"scrH" withString:[NSString stringWithFormat:@"%ld", scrH]];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"relW" withString:[NSString stringWithFormat:@"%ld", relW]];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"relH" withString:[NSString stringWithFormat:@"%ld", relH]];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"relX" withString:[NSString stringWithFormat:@"%ld", relX]];
            htmlRaw = [htmlRaw stringByReplacingOccurrencesOfString:@"relY" withString:[NSString stringWithFormat:@"%ld", relY]];
            
            break;
        }
        case tag: {
            break;
        }
        case rich_media: {
            
            htmlRaw = ad.adHTML;
            
            break;
        }
        case rich_media_resizing: {
            break;
        }
        case swf:{
            break;
        }
        default:{
            break;
        }
    }
    
    return htmlRaw;
}

@end
