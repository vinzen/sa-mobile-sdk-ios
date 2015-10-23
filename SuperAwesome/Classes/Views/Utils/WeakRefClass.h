//
//  WeakRefClass.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 08/10/2015.
//
//

#import <Foundation/Foundation.h>

@interface WeakRefClass : NSObject

+ (id) getWeakReferenceOf: (id) source;

- (void)forwardInvocation:(NSInvocation *)anInvocation;

@property(nonatomic,assign) id source;

@end

