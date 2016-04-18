//
//  ViewController.m
//  PKIDemo
//
//  Created by ezfen on 16/4/7.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "ViewController.h"
#import "MainEffectView.h"

#import "KeyPairGenerator.h"

#import "RSACipherActor.h"
#import "DigestActor.h"
#import "PwdCipherActor.h"
#import "SignatureActor.h"

@interface ViewController () <MainEffectViewDelegate>
@property (strong, nonatomic) KeyPairGenerator *keyPairGenerator;
@end

@implementation ViewController

# pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    MainEffectView *mainEffectView = [[MainEffectView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mainEffectView.delegate = self;
    [self.view addSubview:mainEffectView];
    self.keyPairGenerator = [KeyPairGenerator new];
    [self.keyPairGenerator generateKeyPair];
    //    Do any additional setup after loading the view, typically from a nib.
//    [self desTest];
//    [self rc4Test];
//    [self rsaTest];
//    [self digestTest];
//    [self signatureTest];
//    [self pwdCipherTest];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickButtonTag:(NSInteger)tag inView:(MainEffectView *)view {
    NSLog(@"%i", tag);
    switch (tag) {
        case 0:{
            [self performSegueWithIdentifier:@"SymCipher" sender:nil];
        }
        break;
        case 1:{
            [self performSegueWithIdentifier:@"AsymCipher" sender:nil];
        }
        break;
        default:
            break;
    }
}

- (void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender {
    self.navigationController.navigationBarHidden = NO;
}


- (void)rsaTest {
    RSACipherActor *rsaCipherActor = [[RSACipherActor alloc] init];
    NSString *plainString = @"testteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasadasdqwdqwfqwascasdaksjflkajglkjdlkasghiejrdlkwfnl";
    SecKeyRef publicKey = [self.keyPairGenerator getPublicKeyFromKeyChain];
    NSString *cipherString = [rsaCipherActor encrypt:plainString withPublicKey:publicKey];
    NSLog(@"cipherText: %@", cipherString);
    SecKeyRef privateKey = [self.keyPairGenerator getPrivateKeyFromKeyChain];
    plainString = [rsaCipherActor decrypt:cipherString withPrivateKey:privateKey];
    NSLog(@"plainText: %@", plainString);
}

- (void)digestTest {
    DigestActor *digestActor = [DigestActor new];
    NSString *stringToDigest = @"test Digest";
    NSString *result = [digestActor stringByMD5Digest:stringToDigest];
    NSLog(@"result: %@", result);
}

- (void)signatureTest {
    SignatureActor *signatureActor = [SignatureActor new];
    NSString *stringToSig = @"test Signature";
    //签名
    SecKeyRef privateKey = [self.keyPairGenerator getPrivateKeyFromKeyChain];
    NSString *signature = [signatureActor generateSignatureUsingPlainText:stringToSig withPrivateKey:privateKey];
    NSLog(@"result: %@", signature);
    //验证签名
    SecKeyRef publicKey = [self.keyPairGenerator getPublicKeyFromKeyChain];
    BOOL verifyResult = [signatureActor verifySignature:signature withPlainText:stringToSig withPublicKey:publicKey];
    NSLog(@"verifyResult: %@",verifyResult?@"YES":@"NO");
}

- (void)pwdCipherTest {
    PwdCipherActor *pwdCipherActor = [PwdCipherActor new];
    NSString *plainText = @"test Pwd";
    static const char gSalt[] =
    {
        (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA,
        (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA
    };
    NSData *salt = [NSData dataWithBytes:gSalt length:sizeof(gSalt)/sizeof(gSalt[0])];
    NSData *key = [pwdCipherActor generateKeyWithPassword:@"12345678" andSalt:salt andIterating:16];
    
    NSString *cipherText = [pwdCipherActor DESEncrypt:plainText withPwdKey:key];
    NSLog(@"cipherText: %@", cipherText);
    
    plainText = [pwdCipherActor DESDecrypt:cipherText withPwdKey:key];
    NSLog(@"%@", plainText);
}

@end
