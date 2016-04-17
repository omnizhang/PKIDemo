//
//  SignatureActor.m
//  PKIDemo
//
//  Created by ezfen on 16/4/7.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <Security/Security.h>
#import "SignatureActor.h"
#import "RSACipherActor.h"
#import "KeyPairGenerator.h"
#import "DigestActor.h"

@interface SignatureActor()
@property (strong, nonatomic) DigestActor *digestActor;
@property (strong, nonatomic) KeyPairGenerator *keyPairGenerator;
@end

@implementation SignatureActor

- (DigestActor *)digestActor {
    if (!_digestActor) {
        _digestActor = [DigestActor new];
    }
    return _digestActor;
}

- (KeyPairGenerator *)keyPairGenerator {
    if (!_keyPairGenerator) {
        _keyPairGenerator = [[KeyPairGenerator alloc] init];
    }
    return _keyPairGenerator;
}

- (NSData *)signUsingData:(NSData *)dataToSign {
    NSData *data = [self.digestActor SHA1Digest:dataToSign];
    if (!data) return nil;
    SecKeyRef privateKey = NULL;
    OSStatus status = [self.keyPairGenerator getPrivateKey:&privateKey];
    if (status != noErr) {
        NSLog(@"can not find the private Key");
        return nil;
    }
    size_t sigLen = SecKeyGetBlockSize(privateKey);
    uint8_t *sig = malloc(sigLen);
    status = SecKeyRawSign(privateKey, kSecPaddingPKCS1SHA1, [data bytes], [data length], sig, &sigLen);
    if (status != noErr) {
        NSLog(@"SigErr");
        return nil;
    }
    NSLog(@"%s",sig);
    NSData *resultData = [NSData dataWithBytes:sig length:sigLen];
    free(sig);
    return resultData;
}

- (BOOL)verifyUsingData:(NSData *)signedData signature:(NSData *)signature {
    NSData *data = [self.digestActor SHA1Digest:signedData];
    if (!data) return nil;
    SecKeyRef publicKey = NULL;
    OSStatus status = [self.keyPairGenerator getPublicKey:&publicKey];
    if (status != noErr) {
        NSLog(@"can not find the public Key");
        return nil;
    }
    status = SecKeyRawVerify(publicKey, kSecPaddingPKCS1SHA1, [data bytes], [data length], [signature bytes], [signature length]);
    if (status != noErr) {
        NSLog(@"error");
        return false;
    } else {
        return true;
    }
}

@end
