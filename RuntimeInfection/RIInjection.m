//
//  RuntimeInfection.m
//  RuntimeInfection
//
//  Created by Brian Hsu on 15/6/29.
//  Copyright (c) 2015年 Brian Hsu. All rights reserved.
//

#import "RIInjection.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation RIInjection
#pragma mark initialization
-(id)init
{
    self = [super init];
    [self commonInit];
    if (self) {
        return self;
    }
    return nil;
}

-(id)initWithInjectionHostClass:(Class)hostClass
{
    self = [super init];
    [self commonInit];
    injectionHost = hostClass;
    if (self) {
        return self;
    }
    return nil;
}

-(id)initWithInjectionHostClassName:(NSString*)hostClassName
{
    self = [super init];
    [self commonInit];
    injectionHost = NSClassFromString(hostClassName);
    if (self) {
        return self;
    }
    return nil;
}

-(void)commonInit
{
    flag = NO;
    alreadyManipulatedException = [[NSException alloc] initWithName:@"alreadyManipulatedException" reason:@"Manipultaion has already performed." userInfo:nil];
}


#pragma mark Method Hijack

-(IMP)hijackMethod:(SEL)targetSelector WithObject:(id)anObject selector:(SEL)aSelector overrideArgumentType:(BOOL)isOverriding
{
    if (flag == YES) {
        [alreadyManipulatedException raise];
        return nil;
    }
    originalMethodSelector = targetSelector;
    IMP originalMethod = class_getMethodImplementation(injectionHost, targetSelector);
    originalMethodIMP = originalMethod;
    IMP newMethodIMP = class_getMethodImplementation(object_getClass(anObject), aSelector);
    if (isOverriding) {
        class_replaceMethod(injectionHost, targetSelector, newMethodIMP, method_getTypeEncoding(class_getInstanceMethod(injectionHost, targetSelector)));
    }
    else {
        class_replaceMethod(injectionHost, targetSelector, newMethodIMP, method_getTypeEncoding(class_getInstanceMethod(object_getClass(anObject), aSelector)));
    }
    flag = YES;
    return newMethodIMP;
}
-(IMP)restoreMethod
{
    if (flag == YES) {
        class_replaceMethod(injectionHost, originalMethodSelector, originalMethodIMP, originalMethodEncoding);
        flag = NO;
        return originalMethodIMP;
    }
    else {
        return nil;
    }
}

#pragma mark Special Setters
-(void)setInjectionHostWithString:(NSString*)string
{
    injectionHost = NSClassFromString(string);
}
-(void)setInjectionHost:(Class)targetClass
{
    injectionHost = targetClass;
}
@end
