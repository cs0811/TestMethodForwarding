//
//  ViewController.m
//  TestMethodForwarding
//
//  Created by tongxuan on 17/2/18.
//  Copyright © 2017年 tongxuan. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Message * msg = [Message new];
    [msg sendMessage:@"hello world"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
