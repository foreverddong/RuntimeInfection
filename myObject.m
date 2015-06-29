//
//  myObject.m
//  RuntimeInfection
//
//  Created by Brian Hsu on 15/6/29.
//  Copyright (c) 2015年 Brian Hsu. All rights reserved.
//

#import "myObject.h"

@implementation myObject
-(id)init
{
    self = [super init];
    testString = @"this is fun!";
    return self;
}
-(void)testFunction1
{
    NSLog(@"this is a test Function");
}
-(NSString*)testFunction2withString:(NSString *)string
{
    NSString *newString = [string stringByAppendingString:@"... is tested"];
    NSLog(@"%@",newString);
    return newString;
}
-(NSString*)replacedFunction:(NSString *)string
{
    NSLog(@"this has been replaced!");
    return @"this has been replaced!";
}
@end
