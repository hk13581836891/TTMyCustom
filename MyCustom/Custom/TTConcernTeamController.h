//
//  TTConcernTeamController.h
//  Tian_IOS
//
//  Created by houke on 16/9/19.
//  Copyright © 2016年 RichyLeo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTConcernTeamViewModel;

@interface TTConcernTeamController : UIViewController
{

    NSMutableArray * keywordsArr;
    NSMutableArray * columnsArr;
    NSMutableArray * iDArr;
    NSMutableArray * contentStrArr;
    NSMutableArray * idArr;
    NSMutableArray * typeArr;
    NSMutableArray * selectedArr;
    UIScrollView *scroll;
    NSArray * produArr;
    UIButton *bgView;
    NSMutableArray *ImgArr;
    NSMutableArray *titleArr;
 
}
@property(nonatomic,assign) BOOL isFormSet;

@property (nonatomic, strong) TTConcernTeamViewModel *vm;
@end
