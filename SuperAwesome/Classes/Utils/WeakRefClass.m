//
//  WeakRefClass.m
//  Pods
//
//  Created by Gabriel Coman on 08/10/2015.
//
//

#import "WeakRefClass.h"

@implementation WeakRefClass

@synthesize source;

- (id)init{
    self = [super init];
    //    if (self) {
    //    }
    return self;
}

+ (id) getWeakReferenceOf: (id) _source{
    
    WeakRefClass* ref = [[WeakRefClass alloc]init];
    ref.source = _source; //hold weak reference to original class
    
    return ref;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [[self.source class ] instanceMethodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation    invokeWithTarget:self.source ];
    
}

@end

