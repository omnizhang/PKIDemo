//
//  SignatureController.m
//  PKIDemo
//
//  Created by Netca on 16/4/22.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "SignatureController.h"
#import "SignatureActor.h"
#import "KeyPairGenerator.h"

@interface SignatureController ()
@property (weak, nonatomic) IBOutlet UITextView *plainTextView;
@property (weak, nonatomic) IBOutlet UITextView *signatureTextView;
@end

@implementation SignatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.plainTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.plainTextView.layer.borderWidth = 1;
    self.plainTextView.layer.cornerRadius = 5;
    self.signatureTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.signatureTextView.layer.borderWidth = 1;
    self.signatureTextView.layer.cornerRadius = 5;
}

- (IBAction)generateSignature:(id)sender {
    if ([self canDoCrypt:self.plainTextView]) {
        KeyPairGenerator *keyPairGenerator;
        SignatureActor *signatureActor = [SignatureActor new];
        NSString *stringToSig = self.plainTextView.text;
        SecKeyRef privateKey = [keyPairGenerator getPrivateKeyFromKeyChain];
        NSString *signature = [signatureActor generateSignatureUsingPlainText:stringToSig withPrivateKey:privateKey];
        self.signatureTextView.text = signature;
    }
}

- (BOOL)canDoCrypt:(UITextView *)textView {
    if (textView.text == nil || [textView.text isEqualToString:@""]) {
        [textView becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"明文或密文内容为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else return YES;
}


- (void)signatureTest {
    SignatureActor *signatureActor = [SignatureActor new];
    NSString *stringToSig = @"test Signature";
    KeyPairGenerator *keyPairGenerator;
    //签名
    SecKeyRef privateKey = [keyPairGenerator getPrivateKeyFromKeyChain];
    NSString *signature = [signatureActor generateSignatureUsingPlainText:stringToSig withPrivateKey:privateKey];
    NSLog(@"result: %@", signature);
    //验证签名
    SecKeyRef publicKey = [keyPairGenerator getPublicKeyFromKeyChain];
    BOOL verifyResult = [signatureActor verifySignature:signature withPlainText:stringToSig withPublicKey:publicKey];
    NSLog(@"verifyResult: %@",verifyResult?@"YES":@"NO");
}
@end
