//
//  loginViewModel.h
//  RACObjc
//
//  Created by Zahi on 2017/8/17.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface LoginViewModel : NSObject

//  保存登录界面的账号和密码

/**账号**/
@property (nonatomic, strong) NSString *account;
/**密码**/
@property (nonatomic, strong) NSString *pwd;

/// 处理登录按钮是否运行点击
@property (nonatomic, strong, readonly) RACSignal *loginEnableSignal;

/// 登录按钮命令
@property (nonatomic, strong) RACCommand *loginCommand;



@end
