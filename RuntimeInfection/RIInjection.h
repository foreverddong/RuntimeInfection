//
//  RuntimeInfection.h
//  RuntimeInfection
//
//  Created by Brian Hsu on 15/6/29.
//  Copyright (c) 2015年 Brian Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 RuntimeInfection: Povides multiple functions to easily manipulate Objective-C runtime.
 Major Features:
    1.Method Hijack: Replace a target method in a class, or execute method at the beginning/end of a target method.
    2.Return Value Hijack: Force a method to return a specific value.
    3.Dummy Object: Replace the target object with a dummy Object, forward all the messages
    4.Static Binding: Statically bind a method call to improve performance.
 */

/*
    RIInjection: an Injection is used to directly manipulate a class.
        Injection will bind itself to the class,so that it can alter neaerly all kind of class features.
        basically the interface for Objective-C runtime functions.
 
*/
@interface RIInjection : NSObject{
    
    Class           injectionHost;                  //the host class binding to
    IMP             originalMethodIMP;              //used to store the original method address in order to restore
    SEL             originalMethodSelector;         //original selector, in order to restore
    char*           originalMethodEncoding;         //original encoding, in order to restore
    BOOL            flag;                           //mark for restore
    NSException*    alreadyManipulatedException;    //make sure the manipulation can only be performed once
}

#pragma mark initialization
-(id)initWithInjectionHostClass:(Class)hostClass;
-(id)initWithInjectionHostClassName:(NSString*)hostClassName;


#pragma mark Method Hijack
-(IMP)hijackMethod:(SEL)targetSelector WithObject:(id)anObject selector:(SEL)aSelector overrideArgumentType:(BOOL)isOverriding;
                                                        //hijack the target method, returns the hijacked method IMP
-(IMP)restoreMethod; //restore the target method, returns the original IMP;


#pragma mark Special Setters
-(void)setInjectionHostWithString:(NSString*)string;
-(void)setInjectionHost:(Class)targetClass;
@end
