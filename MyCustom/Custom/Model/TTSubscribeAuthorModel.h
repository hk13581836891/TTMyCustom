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
/*
 autohrDescription: "体坛+篮球记者",
 newstime: 1532338118660,
 authorAuthentication: 1,
 authorName: "孔德昕",
 authorHeadImage: "https://resourcedev.ttplus.cn/editor/headphoto/05f041f1-96fa-49e5-bd70-8a43b7062da3.jpg",
 authorId: "6ec43645-9d15-416d-bc01-516c59452894",
 title: "本届新秀谁最令人期待？状元榜眼都排不上号"
 */
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *authorHeadImage;
@property (nonatomic, copy) NSString *authorProfile;
@property (nonatomic, copy) NSString *authorDescription;
@property (nonatomic, copy) NSString *authorId;

@property (nonatomic, strong) NSNumber *newstime;
@property (nonatomic, assign) NSInteger authorAuthentication;
@property (nonatomic, copy) NSString *title;

@end
