//
//  TTSbuscribeAuthorModel.h
//  MyCustom
//
//  Created by houke on 2018/9/13.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTSubscribeAuthorModel : NSObject
/*
authorName: "叶慧",
authorHeadImage: "https://resourcedev.ttplus.cn/editor/headphoto/441a0302-4cb4-4427-a414-b779997ff7d6.jpg",
authorProfile: "驻广州首席记者",
authorDescription: "《体坛周报》驻广州首席记者",
authorId: "067bc6a0-1860-46ff-8547-9489ca9a8d07"
 */
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *authorHeadImage;
@property (nonatomic, copy) NSString *authorProfile;
@property (nonatomic, copy) NSString *authorDescription;
@property (nonatomic, copy) NSString *authorId;

@end
