//
//  loginViewModel.m
//  RACObjc
//
//  Created by Zahi on 2017/8/17.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "LoginViewModel.h"
#import "MBProgressHUD+SZ.h"

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

/// 初始化
- (void)setup
{
    // 1.处理登录点击的信号
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account), RACObserve(self, pwd)] reduce:^id(NSString *account, NSString *pwd){
        
        return @(account.length && pwd.length);
    }];
    
    // 2.处理登录点击命令
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"发送登录请求");
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [subscriber sendNext:@"请求登录的数据"];
                
                [subscriber sendCompleted];
            });
            
            
            
            return nil;
        }];
        
    }];
    
    // 3.处理登录请求返回的结果
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
    }];
    
    // 4.处理登录执行的过程
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        
        if (x.boolValue == YES) {
            NSLog(@"正在执行");
            // 显示蒙版
            [MBProgressHUD showMessage:@"正在登录..."];
        } else {
            
            // 隐藏蒙版
            [MBProgressHUD hideHUD];
            
            NSLog(@"执行完成");
            
        }
    }];
    
    
}
@end
