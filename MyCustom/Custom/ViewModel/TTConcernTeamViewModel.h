//
//  TTConcernTeamViewModel.h
//  MyCustom
//
//  Created by houke on 2018/9/14.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTConcernTeamModel.h"

@interface TTConcernTeamViewModel : NSObject
@property (nonatomic, strong) NSMutableArray *concernTeamArr;
-(void)getConcernTeamList:(void(^)(bool))finish;
@end
