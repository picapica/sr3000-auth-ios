//
//  KeyVerify.h
//  iAuth
//
//  Created by Qi Kuang on 11-8-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface KeyVerify : NSObject{
    NSString *IP;
    NSString *dIP;
    NSString *Username;
    NSString *Password;
    NSString *Key;
    BOOL isRegisted;
}
+ (KeyVerify*) Values;
+ (NSString *) md5:(NSString *) input;
+ (NSString *) getDeviceCode;
+ (NSString *) getKey;
+ (BOOL) verifyReg;
+ (void) fix;
@property (nonatomic, retain) NSString *IP;
@property (nonatomic, retain) NSString *dIP;
@property (nonatomic, retain) NSString *Username;
@property (nonatomic, retain) NSString *Password;
@property (nonatomic, retain) NSString *Key;
@property (assign) BOOL isRegisted;

@end
