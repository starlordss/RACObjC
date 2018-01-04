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
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self RACMacro];
    
    [self liftSeletor];
}

/// liftSelector
- (void)liftSeletor
{
    // 请求热销模块
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 请求数据
        NSLog(@"请求数据热销模块");
        
        [subscriber sendNext:@"热销模块的数据"];
        
        return nil;
    }];
    
    
    // 请求最新模块
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 请求数据
        NSLog(@"请求最新模块");
        
        [subscriber sendNext:@"最新模块数据"];
        
        return nil;
    }];
    
    // 数组：存放信号
    // 当数组中的所有信号都发送数据的时候,才会执行Selector
    // 方法的参数:必须跟数组的信号一一对应
    // 方法的参数;就是每一个信号发送的数据
    [self rac_liftSelector:@selector(updateUIWithHotData:newData:) withSignalsFromArray:@[hotSignal, newSignal]];
    
}

- (void)updateUIWithHotData:(NSString *)hotData newData:(NSString *)newData
{
    // 拿到请求的数据
    NSLog(@"更新UI %@ %@",hotData,newData);
}

/// 包装元祖
- (void)packingTupleMacro
{
    // 包装元祖 RACTuplePack宏
    RACTuple *tuple = RACTuplePack(@1, @2);
    
    NSLog(@"%@",tuple);
}

/// RAC宏
- (void)RACMacro
{
    // 用来给某个对象的某个属性绑定信号，只要产生信号内容 就会把内容给属性赋值
    RAC(_label, text) = _textField.rac_textSignal;
    
    NSLog(@"%@",_label.text);
}

@end
