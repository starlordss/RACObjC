//
//  Flag.h
//  RACObjc
//
//  Created by Zahi on 2017/8/16.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flag : NSObject



@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *icon;

/// 实例化flag
+ (instancetype)flagWithDict:(NSDictionary *)dict;


@end
