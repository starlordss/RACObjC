//
//  ViewController.m
//  RACObjc
//
//  Created by Zahi on 2017/7/9.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import "RequestViewModel.h"
#import "Book.h"

@interface ViewController ()


/**请求视图模型**/
@property (nonatomic, strong) RequestViewModel *requestVM;

@end

@implementation ViewController

- (RequestViewModel *)requestVM
{
    if (!_requestVM) {
        
        _requestVM = [[RequestViewModel alloc] init];
    }
    return _requestVM;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 发送请求
    RACSignal *signal = [self.requestVM.requestCommand execute:nil];
    
    [signal subscribeNext:^(id  _Nullable x) {
        
        // 模型数组
        Book *book = x[0];
        
        NSLog(@"%@  %@",book.subtitle,book.title);
    }];
}



@end
