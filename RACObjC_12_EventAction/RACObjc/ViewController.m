//
//  ViewController.m
//  RACObjc
//
//  Created by Zahi on 2017/7/9.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import "RedView.h"
#import <ReactiveObjC.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet RedView *redView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self replaceDelegate];
    
//    [self replaceKVO];
    
//    [self controlEvents];
    
//    [self replaceNotification];
    
    [self controlTextField];
}

/// 监听文本框
- (void)controlTextField
{
    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
}

/// 代理通知
- (void)replaceNotification
{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        NSLog(@"%@",x);
        
    }];
}


/// 监听事件
- (void)controlEvents
{
 
    [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        NSLog(@"按钮被点击了");
        
    }];
}


/// 代替KVO
- (void)replaceKVO
{
    [[_redView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        
    }];
}

/// 代理代理
- (void)replaceDelegate
{
    /// 只要传值就必须使用RACSubject
    [[_redView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(RACTuple * _Nullable x) {
        
        NSLog(@"控制器知道redView上的按钮被点击");
        
    }];
    
    
//    [[self rac_signalForSelector:@selector(didReceiveMemoryWarning)] subscribeNext:^(RACTuple * _Nullable x) {
//        
//        NSLog(@"控制器调用didReceiveMemoryWarning");
//        
//    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _redView.frame = CGRectMake(60, 60, 300, 300);
}


@end
