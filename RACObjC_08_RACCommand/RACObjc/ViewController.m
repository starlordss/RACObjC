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
    
//    [self command];
    
//    [self executionSignals];
    
//    [self switchToLatest];
    
    [self command2];
    
}


- (void)command2
{
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            // 发送数据
            [subscriber sendNext:@"执行命令产生的数据"];
            
            // 发送完成
            [subscriber sendCompleted];
            
            return nil;
        }];
        
    }];
    
    
    // 监听事件有没有完成
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        
        if ([x boolValue] == YES) { // 当前正在执行
            
            NSLog(@"当前正在执行");
            
        } else {
            
            NSLog(@"执行完成/没有执行");
        }
    }];
    
    // 执行命令
    [command execute:@12];
}

- (void)switchToLatest
{
    // 创建信中的信号
    RACSubject *signalOfSignals = [RACSubject subject];
    
    RACSubject *signalA = [RACSubject subject];
    
    RACSubject *signalB = [RACSubject subject];
    
    
    // 订阅 信号
    // switchToLatest:获取信号中信号发送的最新信号
    [signalOfSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
    }];
    
    // 发送信号
    [signalOfSignals sendNext:signalB];
    
    [signalA sendNext:@11];
    
    [signalB sendNext:@"BB"];
    
    [signalA sendNext:@"A11"];
    
    [signalB sendNext:@"B11"];
}

- (void)executionSignals
{
    // 建立命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //input: 执行命令传入参数
        // block调用：执行命令的时候就会掉用
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"执行命令产生的数据"];
            
            return nil;
        }];
        
    }];
    // 订阅信号
    // 必须在执行命令前，订阅
    // switchToLatest获取最新发送的信号，只能用于信号
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
    }];
    
    // 执行命令
    [command execute:@20];
}


/**
 * RACCommand:处理事件
 * 不能返回一个空的信号
 */
- (void)command
{
    
    
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
    
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            
            // 发送数据
            
            [subscriber sendNext:@"发送命令产生的数据"];
            return nil;
        }];
    }];
    
    // 2.执行命令
    RACSignal *signal = [command execute:@100];
    
    // 3.订阅型号
    [signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
        
    }];
    
}
@end
