//
//  SignatureActor.h
//  PKIDemo
//
//  Created by ezfen on 16/4/7.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignatureActor : NSObject

- (NSData *)signUsingData:(NSData *)dataToSign;
- (BOOL)verifyUsingData:(NSData *)signedData signature:(NSData *)signature;
@end
