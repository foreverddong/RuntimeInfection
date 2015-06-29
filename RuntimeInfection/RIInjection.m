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

#pragma mark Method Hijack
-(IMP)hijackMethod:(SEL)targetSelector WithObject:(id)anObject selector:(SEL)aSelector overrideArgumentType:(BOOL)isOverriding
{
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
    return newMethodIMP;
}
-(IMP)restoreMethod
{
    class_replaceMethod(injectionHost, originalMethodSelector, originalMethodIMP, originalMethodEncoding);
    return originalMethodIMP;
}
-(id)injectionMethodObj
{
    return nil;
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
