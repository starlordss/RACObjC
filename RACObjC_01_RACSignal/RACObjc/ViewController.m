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
    
    
    /**
     * RACSignal:有数据产生的时候，就是用RACSignal
     * RACSignal使用步骤:
            1.创建信号
            2.订阅信号
     ·      3.发送信号
     
     * 只要订阅者调用sendNext，就会执行NextBlock
     * 只要订阅RACDynamicSignal,就会执行didSubscribe
     * 前提条件是RACDynamicSignal,不同类型信号的订阅，处理订阅的事件
     */
    
    RACDisposable *(^didSubscribe)(id<RACSubscriber> subscriber) = ^RACDisposable *(id<RACSubscriber> subcriber)
    {
        //didSubscribe调用:只要一个信号被订阅就会调用
        //didSubscribe作用：发送数据
        NSLog(@"信号被订阅");
        
        // 3.发送信号
        [subcriber sendNext:@133];
        
        return nil;
        
    };
    
    // 1.创建信号（冷型号）
    RACSignal *signal = [RACSignal createSignal:didSubscribe];
    
    
    // 2.订阅信号（热信号）
    [signal subscribeNext:^(id  _Nullable x) {
        // nextBlock调用：只要订阅者发送数据就会调用
        // nextBlock作用:处理数据，展示到UI上面
        
        // x:信号发送的内容
        NSLog(@"%@",x);
        
    }];
    
    
    
}

@end
