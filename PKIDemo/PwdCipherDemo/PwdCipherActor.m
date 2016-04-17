//
//  PwdCipherActor.m
//  PKIDemo
//
//  Created by ezfen on 16/4/12.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "PwdCipherActor.h"

@implementation PwdCipherActor

- (NSData *)encryptPBEWithMD5AndDESData:(NSData *)inData password:(NSString *)password {
    return nil;
}






- (NSData *)encodePBEWithMD5AndDESData:(NSData *)inData password:(NSString *)password direction:(int)direction {
    static const char gSalt[] = {(unsigned char)0xaa, (unsigned char)0xd1, (unsigned char)0x3c, (unsigned char)0x31,
                                 (unsigned char)0x53, (unsigned char)0xa2, (unsigned char)0xee, (unsigned char)0x05};
    unsigned char *slat = (unsigned char *)gSalt;
    int saltLen = strlen(gSalt);
    int iterations = 15;
    
    return nil;
}
@end
