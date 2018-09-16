//
//  TTConcernTeamModel.h
//  MyCustom
//
//  Created by houke on 2018/9/14.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTConcernTeamModel : NSObject

//"keywords": "篮球11",
//"name": "test11",
//"icon": "http://q.qlogo.cn/qqapp/1104653566/CB218C288B9E446C04E3BDF24F6025A1/100",
//"id": 7

@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, strong) NSNumber *status;

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *desc;
@end


















