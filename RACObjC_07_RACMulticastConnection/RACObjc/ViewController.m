//
//  ViewController.m
//  RACObjc
//
//  Created by Zahi on 2017/7/9.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self subject];
//    [self connection];
    
    [self requestBug];
    
}


- (void)subject
{
    RACSubject *subject = [RACSubject subject];
    
    [subject subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"1:%@",x);
        
    }];
    
    
    [subject subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"2:%@",x);
    }];
    
    [subject sendNext:@100];
}


/**
 * RACMulticastConnection：必须要有信号
 * 不管订阅多少次信号，就会请求一次
 */
- (void)connection
{
    // 1. 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"发送热门模块的请求");
        
        [subscriber sendNext:@100];
        
        return nil;
    }];
    
    // 2.把信号转成连接类 Multicast 多路广播
    RACMulticastConnection *connection = [signal multicast:[RACReplaySubject subject]];
    
    // 3.订阅链接信号
    [connection.signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"1:%@",x);
        
    }];
    
    // 4.连接
    [connection connect];
    
}


- (void)requestBug
{
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"发送热门模块的请求");
      
        [subscriber sendNext:@100];
        
        return nil;
    }];
    
    
    // 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"订阅者1:%@",x);
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"订阅者2：%@",x);
    }];
}
@end
