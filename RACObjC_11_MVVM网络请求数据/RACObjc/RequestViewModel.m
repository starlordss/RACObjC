//
//  RequestViewModel.m
//  RACObjc
//
//  Created by Zahi on 2017/8/18.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "RequestViewModel.h"
#import "AFNetworking.h"
#import "Book.h"

@implementation RequestViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
            
            [mgr GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"美女"} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                
                NSLog(@"请求成功");
                
                NSArray *dictArray = responseObject[@"books"];
                
                NSArray *modelArray = [[dictArray.rac_sequence map:^id _Nullable(id  _Nullable value) {
                    
                    return [Book bookWithDict:value];
                }] array];
                
                [subscriber sendNext:modelArray];
                
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                
            }];
    
            return nil;
        }];
        
    }];
}
@end
