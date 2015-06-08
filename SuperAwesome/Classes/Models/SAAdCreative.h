//
//  SAAdCreative.h
//  Pods
//
//  Created by Balázs Kiss on 08/06/2015.
//
//

#import "JSONModel.h"

@interface SAAdCreative : JSONModel

@property (nonatomic,strong) NSString *creativeID;
@property (nonatomic,strong) NSString *format;
@property (nonatomic,strong) NSString *clickURL;
@property (nonatomic,strong) NSDictionary *details;

- (NSString *)toHTML;

@end
