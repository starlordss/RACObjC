//
//  ViewController.m
//  RACObjc
//
//  Created by Zahi on 2017/7/9.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

/**登录vm**/
@property (nonatomic, strong) LoginViewModel *loginVM;

@end

@implementation ViewController


- (LoginViewModel *)loginVM
{
    if (_loginVM == nil) {
        
        _loginVM = [LoginViewModel new];
    }
    
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindLoginVM];
    
    [self loginEvent];
    
    
}


- (void)bindLoginVM
{
    RAC(self.loginVM, account) = _usernameField.rac_textSignal;
    
    RAC(self.loginVM, pwd) = _passwordField.rac_textSignal;
}


- (void)loginEvent
{
    RAC(_loginButton, enabled) = self.loginVM.loginEnableSignal;
    
    [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // 处理事件
        [self.loginVM.loginCommand execute:nil];
        
    }];
}
@end
