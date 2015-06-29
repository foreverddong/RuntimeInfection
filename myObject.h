//
//  myObject.h
//  RuntimeInfection
//
//  Created by Brian Hsu on 15/6/29.
//  Copyright (c) 2015年 Brian Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ObjectiveC.NSObject;
@interface myObject : NSObject
{
    NSString *testString;
}
-(void)testFunction1;
-(NSString*)testFunction2withString:(NSString*)string;
-(NSString*)replacedFunction:(NSString*)string;
@end
