//
//  RedView.h
//  RACObjc
//
//  Created by Zahi on 2017/7/22.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>

@interface RedView : UIView

/**subject**/
@property (nonatomic, strong) RACSubject *btnClickSignal;

@end
