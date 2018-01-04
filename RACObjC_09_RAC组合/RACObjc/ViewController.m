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
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self concat];
    
//    [self then];
    
//    [self merge];
    
    
//    [self zip];
    
    [self login];

    
}

- (void)login
{
    
    // 结合
    RACSignal *combineSignal = [RACSignal combineLatest:@[_usernameField.rac_textSignal, _passwordField.rac_textSignal] reduce:^id(NSString *username, NSString *password){
        
        NSLog(@"%@ %@",username, password);
        
        return @(username.length && password.length);
    }];
    
    RAC(_loginButton, enabled) = combineSignal;
}


- (void)zip
{
    RACSubject *signalA = [RACSubject subject];
    
    RACSubject *signalB = [RACSubject subject];
    
    RACSignal *zipSignal = [signalA zipWith:signalB];
    
    
    // 订阅信号
    // 等所有的信号发送内容的时候才会调用
    [zipSignal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
        
    }];
    
    [signalA sendNext:@"上半部分数据"];
    [signalB sendNext:@"下半部分数据"];
}

// 合并
- (void)merge
{
    
    RACSubject *signalA = [RACSubject subject];
    
    RACSubject *signalB = [RACSubject subject];
    
    RACSignal *mergeSignal = [signalA merge:signalB];
    
    // 订阅信号
    [mergeSignal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
    }];
    
    [signalA sendNext:@"上半部分数据"];
    [signalB sendNext:@"下半部分数据"];
}


- (void)then
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"发送上部分请求");
        
        [subscriber sendNext:@"上部分数据"];
        
        [subscriber sendCompleted];
        return nil;
    
    }];
    
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"发送下部分请求");
        
        [subscriber sendNext:@"下部分数据"];
        
        return nil;
    }];
    
    // 创建组合信号
    // 忽略第一个信号所有的的值
    RACSignal *thenSignal = [signalA then:^RACSignal * _Nonnull{
        
        // 返回的信号就是需要组合的信号
        return signalB;
    }];
    
    
    // 订阅组合信号
    [thenSignal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
    }];
    
    
}

- (void)concat
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"发送上部分请求");
        
        // 发送信号
        [subscriber sendNext:@"上部分数据"];
        
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"发送下部分请求");
        
        [subscriber sendNext:@"下部分数据"];
        
        return nil;
    }];
    
    // 创建组合信号
    // 第一个信号必须调用sendCompleted
    RACSignal *concatSignal = [signalA concat:signalB];
    
    // 订阅组合信号
    [concatSignal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
    }];
}

@end
