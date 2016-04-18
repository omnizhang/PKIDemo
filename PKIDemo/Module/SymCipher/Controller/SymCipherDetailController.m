//
//  SymCipherDetailController.m
//  PKIDemo
//
//  Created by ezfen on 16/4/18.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "SymCipherDetailController.h"
#import "DESCipherActor.h"
#import "AESCipherActor.h"
#import "RC4CipherActor.h"

@interface SymCipherDetailController()

@end

@implementation SymCipherDetailController

- (IBAction)selectSymOperation:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
        {
            
        }
        break;
        case 1:
        {
            
        }
        break;
    }
}


- (void)desTest {
    DESCipherActor *desCipherActor = [DESCipherActor new];
    
    NSString *plainText = @"test SymCipher Demo";
    NSLog(@"plainText:%@",plainText);
    
    NSString *key = @"12345678";
    Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef};
    NSData *ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
    
    NSString *CBCcipherText = [desCipherActor encryptInCBC:plainText key:key iv:ivData];
    NSLog(@"cipherText: %@", CBCcipherText);
    NSString *EBCcipherText = [desCipherActor encryptInEBC:plainText key:key];
    NSLog(@"cipherText: %@", EBCcipherText);
    
    plainText = [desCipherActor decryptInEBC:EBCcipherText key:key];
    NSLog(@"%@", plainText);
    plainText = [desCipherActor decryptInCBC:CBCcipherText key:key iv:ivData];
    NSLog(@"%@", plainText);
}

- (void)aesTest {
    NSString *plainText = @"test SymCipher Demo";
    NSLog(@"plainText:%@",plainText);
    NSString *key = @"1234567890123456";//128
    //key = @"123456789012345678901234";//192
    //key = @"12345678901234567890123456789012";//256
    NSLog(@"%lu",(unsigned long)key.length);
    AESCipherActor *aesCipherActor = [AESCipherActor new];
    NSString *EBCcipherText = [aesCipherActor encryptInEBC:plainText key:key];
    NSLog(@"cipherText: %@", EBCcipherText);
    NSString *CBCcipherText = [aesCipherActor encryptInCBC:plainText key:key iv:[key dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"cipherText: %@", CBCcipherText);
    plainText = [aesCipherActor decryptInEBC:EBCcipherText key:key];
    NSLog(@"%@", plainText);
    plainText = [aesCipherActor decryptInCBC:CBCcipherText key:key iv:[key dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@", plainText);
}

- (void)rc4Test {
    NSString *plainText = @"test SymCipher Demo";
    NSLog(@"plainText:%@",plainText);
    NSString *key = @"12345678901234567890";
    RC4CipherActor *rc4CipherActor = [RC4CipherActor new];
    NSString *cipherText = [rc4CipherActor encrypt:plainText key:key];
    NSLog(@"%@", cipherText);
    
    plainText = [rc4CipherActor decrypt:cipherText key:key];
    NSLog(@"%@", plainText);
}

@end
