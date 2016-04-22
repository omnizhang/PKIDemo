//
//  DigestController.m
//  PKIDemo
//
//  Created by Netca on 16/4/22.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "DigestController.h"
#import "DigestActor.h"

@interface DigestController ()
@property (weak, nonatomic) IBOutlet UITextView *plainTextView;
@property (weak, nonatomic) IBOutlet UITextView *digestTextView;
@end

@implementation DigestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.plainTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.plainTextView.layer.borderWidth = 1;
    self.plainTextView.layer.cornerRadius = 5;
    self.digestTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.digestTextView.layer.borderWidth = 1;
    self.digestTextView.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)generateDigest:(id)sender {
    if ([self canDoCrypt:self.plainTextView]) {
        DigestActor *digestActor = [DigestActor new];
        NSString *stringToDigest = self.plainTextView.text;
        NSString *result = [digestActor stringByMD5Digest:stringToDigest];
        self.digestTextView.text = result;
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

- (void)digestTest {
    DigestActor *digestActor = [DigestActor new];
    NSString *stringToDigest = @"test Digest";
    NSString *result = [digestActor stringByMD5Digest:stringToDigest];
    NSLog(@"result: %@", result);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
