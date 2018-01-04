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
    
    
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 3,发送信号
        [subscriber sendNext:@123];
        
        return [RACDisposable disposableWithBlock:^{
            // 只要信号被取消就会执行这个block
            
            // 一般可以在这里清空资源
            NSLog(@"信号订阅被取消了");
        }];
    }];
   
    // 2.订阅信号
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    /**
     * 默认一个信号发送数据完毕就会主动取消订阅
     * 只要订阅者在，就不会自动取消信号订阅
     */
    
    // 取消信号订阅
    [disposable dispose];
    
    
}

@end
