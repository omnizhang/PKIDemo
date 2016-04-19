//
//  AsymCipherDetailController.m
//  PKIDemo
//
//  Created by ezfen on 16/4/19.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "AsymCipherDetailController.h"
#import "KeyPairGenerator.h"
#import "RSACipherActor.h"

@interface AsymCipherDetailController()
@property (weak, nonatomic) IBOutlet UITextView *plainTextView;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextView *cipherTextView;

@property (strong, nonatomic) KeyPairGenerator *keyPairGenerator;
@end

@implementation AsymCipherDetailController

- (void)viewDidLoad {
    self.plainTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.plainTextView.layer.borderWidth = 1;
    self.plainTextView.layer.cornerRadius = 5;
    self.cipherTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.cipherTextView.layer.borderWidth = 1;
    self.cipherTextView.layer.cornerRadius = 5;
}

- (IBAction)encrypt:(id)sender {
    if ([self canDoCrypt:self.plainTextView]) {
        RSACipherActor *rsaCipherActor = [[RSACipherActor alloc] init];
        SecKeyRef publicKey = [self.keyPairGenerator getPublicKeyFromKeyChain];
        NSString *plainString = self.plainTextView.text;
        NSString *cipherString = [rsaCipherActor encrypt:plainString withPublicKey:publicKey];
        self.cipherTextView.text = cipherString;
    }
}

- (IBAction)decrypt:(id)sender {
    if ([self canDoCrypt:self.cipherTextView]) {
        RSACipherActor *rsaCipherActor = [[RSACipherActor alloc] init];
        SecKeyRef privateKey = [self.keyPairGenerator getPrivateKeyFromKeyChain];
        NSString *cipherString = self.cipherTextView.text;
        NSString *plainString = [rsaCipherActor decrypt:cipherString withPrivateKey:privateKey];
        self.plainTextView.text = plainString;
    }
}

- (BOOL)canDoCrypt:(UITextView *)textView {
    if (textView.text == nil || [textView.text isEqualToString:@""]) {
        [textView becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"明文或密文内容为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else if (self.keyTextField.text == nil || [self.keyTextField.text isEqualToString:@""]){
        [self.keyTextField becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密钥为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else return NO;
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
@end
