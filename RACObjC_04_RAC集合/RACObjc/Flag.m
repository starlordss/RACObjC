
//
//  Flag.m
//  RACObjc
//
//  Created by Zahi on 2017/8/16.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "Flag.h"

@implementation Flag


+ (instancetype)flagWithDict:(NSDictionary *)dict
{
    Flag *flag = [Flag new];
    
    // 字典转模型
    [flag setValuesForKeysWithDictionary:dict];
    
    return flag;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@",self.name,self.icon];
}

@end
