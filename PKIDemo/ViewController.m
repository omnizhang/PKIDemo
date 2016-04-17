//
//  ViewController.m
//  PKIDemo
//
//  Created by ezfen on 16/4/7.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "ViewController.h"
#import "DESCipherActor.h"
#import "AESCipherActor.h"
#import "RC4CipherActor.h"
#import "RSACipherActor.h"
#import "DigestActor.h"
#import "SignatureActor.h"

@interface ViewController ()
@property (strong, nonatomic) SignatureActor *sig;
@end

@implementation ViewController

# pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //    Do any additional setup after loading the view, typically from a nib.
//    [self desTest];
//    [self rc4Test];
//    [self rsaTest];
    [self digestTest];
    //    [self signatureDemoTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)rsaTest {
    RSACipherActor *rsaCipherActor = [[RSACipherActor alloc] init];
    NSString *plainString = @"testteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasadasdqwdqwfqwascasdaksjflkajglkjdlkasghiejrdlkwfnl";
    NSString *cipherString = [rsaCipherActor encryptWithPublicKey:plainString];
    NSLog(@"cipherText: %@", cipherString);
    plainString = [rsaCipherActor decryptWithPrivateKey:cipherString];
    NSLog(@"plainText: %@", plainString);
}

- (void)digestTest {
    DigestActor *digestActor = [DigestActor new];
    NSString *stringToDigest = @"test Digest";
    NSString *result = [digestActor MD5Digest:stringToDigest];
    NSLog(@"result: %@", result);
}

- (void)signatureDemoTest {
    self.sig = [SignatureActor new];
    NSString *stringToSig = @"test Signature";
    NSData *data = [stringToSig dataUsingEncoding:NSUTF8StringEncoding];
    //签名
    NSData *sigResult = [self.sig signUsingData:data];
    NSLog(@"result = %s, length = %lu", [sigResult bytes], [sigResult length]);
    //验证签名
    BOOL verifyResult = [self.sig verifyUsingData:data signature:sigResult];
    NSLog(@"%i",verifyResult);
}

@end
