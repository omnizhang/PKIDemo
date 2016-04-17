//
//  DigestDemo.h
//  PKIDemo
//
//  Created by ezfen on 16/4/7.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DigestActor : NSObject

- (NSString *)MD5Digest:(NSString *)stringToDigest;
- (NSString *)SHA1Digest:(NSString *)stringToDigest;
- (NSString *)SHA256Digest:(NSString *)stringToDigest;

@end
