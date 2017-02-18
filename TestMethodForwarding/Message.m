//
//  Message.m
//  TestMethodForwarding
//
//  Created by tongxuan on 17/2/18.
//  Copyright © 2017年 tongxuan. All rights reserved.
//

#import "Message.h"
#import <objc/runtime.h>
#import "MessageTemp.h"

@implementation Message

//- (void)sendMessage:(NSString *)msg {
//    NSLog(@"msg %@", msg);
//}


/**
 1. 首先Objective-C在运行时调用+ resolveInstanceMethod:或+ resolveClassMethod:方法，让你添加方法的实现。如果你添加方法并返回YES，那系统在运行时就会重新启动一次消息发送的过程。
 如果resolveInstanceMethod方法返回NO，运行时就跳转到下一步：消息转发(Message Forwarding)。
 */
#pragma mark - Method Resolution
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(sendMessage:)) {
        class_addMethod([self class], @selector(sendMessage:), imp_implementationWithBlock(^(id self, NSString *word) {
            NSLog(@"method resolution way : send message = %@", word);
        }), "v@:@");
    }
    
    return YES;
}

/**
 2. 如果目标对象实现- forwardingTargetForSelector:方法，系统就会在运行时调用这个方法，只要这个方法返回的不是nil或self，也会重启消息发送的过程，把这消息转发给其他对象来处理。否则，就会继续Normal Fowarding。
 */
#pragma mark - Fast Forwarding
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(sendMessage:)) {
        return [MessageTemp new];
    }
    return nil;
}

/**
 3. 如果没有使用Fast Forwarding来消息转发，最后只有使用Normal Forwarding来进行消息转发。它首先调用methodSignatureForSelector:方法来获取函数的参数和返回值，如果返回为nil，程序会Crash掉，并抛出unrecognized selector sent to instance异常信息。如果返回一个函数签名，系统就会创建一个NSInvocation对象并调用-forwardInvocation:方法。
 */
#pragma mark - Normal Forwarding
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature * methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    MessageTemp * temp = [MessageTemp new];
    if ([temp respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:temp];
    }
}


@end
