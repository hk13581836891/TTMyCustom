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
@property (nonatomic, strong) NSMutableArray *recommendTeamArr;
@property (nonatomic, strong) NSMutableArray *categoryTeamArr;

-(void)getConcernTeamList:(void(^)(bool))finish;
-(void)getRecommendTeamDataList:(void (^)(bool))finsih;

-(void)concernCancelTeam:(NSNumber *)wordId status:(NSString *)status finish:(void (^)(bool))finish;

-(void)pushToConcerTeam;
-(void)getBack;
@end
