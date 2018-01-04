//
//  ViewController.m
//  RACObjc
//
//  Created by Zahi on 2017/7/9.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "Flag.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self tuple];
    
}


/// 元祖
- (void)tuple
{
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"abc", @"cd", @123]];
    
    NSString *str = tuple[2];

    
    NSLog(@"%@",str);
}

/// 数组
- (void)array
{
    NSArray *arr = @[@111, @"我是大n", @"什么嘛"];
    
    [arr.rac_sequence.signal subscribeNext:^(id x) {
        
        
        NSLog(@"%@",x);
    }];
}

/// 字典
- (void)dictionary
{
    NSDictionary *dict = @{@"name":@"zahi",@"sex":@"男",@"age": @24,@"phone":@13435466768};
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        
//        NSString *key = x[0];
//        
//        NSString *value = x[1];
        
        
//    RACTupleUnpack: 用来解析元祖
//    宏里面的参数，传需要解析处理的变量名
        
        RACTupleUnpack(NSString *key, NSString *value) = x;
        
        
        NSLog(@"%@ %@",key, value);
    }];
}

/// 字典数组
- (void)dictArray
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    
    /// 高级用法
    // 会把集合中所有元素映射成一个新对象
    NSArray *arr = [[dictArray.rac_sequence map:^id _Nullable(NSDictionary *value) {
        // value 集合中的元素
        
        // id 返回对象映射的值
        return [Flag flagWithDict:value];
    }] array];
    
    
    NSLog(@"%@",arr);
}

@end
