//
//  KeyVerify.m
//  iAuth
//
//  Created by Qi Kuang on 11-8-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "KeyVerify.h"
@implementation KeyVerify
@synthesize dIP;
@synthesize IP;
@synthesize Username;
@synthesize Password;
@synthesize Key;
@synthesize isRegisted;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:8];
    for(int i = 0; i < 4; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

+ (NSString *) getDeviceCode
{
    return [self md5:[[UIDevice currentDevice]uniqueIdentifier]];
}

+ (NSString *) getKey
{
    NSString *deviceCode = [self getDeviceCode];
    deviceCode = [deviceCode stringByAppendingString:@"KQ's Technology Studio"];
    const char *cStr = [deviceCode UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest );
    unsigned int key = 11171117;
    for(int i = 0;i < 16; i++)
    {
        if(digest[i]!=0) key *= digest[i];
        key %= 89898989;
    }
    while (key<10000000) {
        key *= 7;
    }
    return [[NSString alloc]initWithFormat:@"%d",key];
}

+(BOOL) verifyReg
{
    [self Values].isRegisted = [[self Values].Key isEqualToString:[self getKey]];
    //([self Values].Key == [self getKey]);
    return [self Values].isRegisted;
}

+ (KeyVerify*)Values
{
    static KeyVerify *vals;
    @synchronized(self)
    {
        if (!vals)
            vals = [[KeyVerify alloc] init];
        return vals;
    }
}

+ (void) fix
{
    if(![self Values].dIP || [[self Values].dIP isEqualToString:@""]) [self Values].dIP = @"172.16.240.8";
    if(![self Values].IP || [[self Values].IP isEqualToString:@""]) [self Values].IP = @"172.16.202.201";
    if(![self Values].Username) [self Values].Username = @"";
    if(![self Values].Password) [self Values].Password = @"";
    if(![self Values].Key) [self Values].Key = @"";
}

@end
