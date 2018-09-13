//
//  TTSbuscribeAuthorViewModel.h
//  MyCustom
//
//  Created by houke on 2018/9/13.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTSbuscribeAuthorModel.h"

@interface TTSbuscribeAuthorViewModel : NSObject
@property (nonatomic, strong) NSMutableArray *authorArr;
-(void) getRecommendAutorList:(void (^)(BOOL))finish;
@end
