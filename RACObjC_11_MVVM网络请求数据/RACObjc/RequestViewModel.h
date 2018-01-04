//
//  RequestViewModel.h
//  RACObjc
//
//  Created by Zahi on 2017/8/18.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface RequestViewModel : NSObject

/**请求命令**/
@property (nonatomic, strong) RACCommand *requestCommand;

@end
