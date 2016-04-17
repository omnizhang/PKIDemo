//
//  DigestDemo.m
//  PKIDemo
//
//  Created by ezfen on 16/4/7.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "DigestActor.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation DigestActor

- (NSString *)MD5Digest:(NSString *)stringToDigest {
    NSData *dataToDigest = [stringToDigest dataUsingEncoding:NSUTF8StringEncoding];
    UInt8 hash[CC_MD5_DIGEST_LENGTH];
    CC_MD5([dataToDigest bytes], (CC_LONG)[dataToDigest length], hash);
    return [GTMBase64 stringByEncodingData:[NSData dataWithBytes:hash length:CC_MD5_DIGEST_LENGTH]];
}

- (NSString *)SHA1Digest:(NSString *)stringToDigest {
    NSData *dataToDigest = [stringToDigest dataUsingEncoding:NSUTF8StringEncoding];
    UInt8 hash[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1([dataToDigest bytes], (CC_LONG)[dataToDigest length], hash);
    return [GTMBase64 stringByEncodingData:[NSData dataWithBytes:hash length:CC_SHA1_DIGEST_LENGTH]];
}

- (NSString *)SHA256Digest:(NSString *)stringToDigest {
    NSData *dataToDigest = [stringToDigest dataUsingEncoding:NSUTF8StringEncoding];
    UInt8 hash[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([dataToDigest bytes], (CC_LONG)[dataToDigest length], hash);
    return [GTMBase64 stringByEncodingData:[NSData dataWithBytes:hash length:CC_SHA256_DIGEST_LENGTH]];
}

@end
