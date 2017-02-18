//
//  MessageTemp.m
//  TestMethodForwarding
//
//  Created by tongxuan on 17/2/18.
//  Copyright © 2017年 tongxuan. All rights reserved.
//

#import "MessageTemp.h"

@implementation MessageTemp

- (void)sendMessage:(NSString *)msg {
    NSLog(@"fast forwarding way : send message = %@", msg);
}

@end
