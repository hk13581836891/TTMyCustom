//
//  TTConcernTeamModel.m
//  MyCustom
//
//  Created by houke on 2018/9/14.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTConcernTeamModel.h"
#import "MJExtension.h"

@implementation TTConcernTeamModel

-(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end
