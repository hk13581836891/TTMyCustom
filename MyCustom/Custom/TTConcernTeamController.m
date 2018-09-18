//
//  TTConcernTeamController.m
//  Tian_IOS
//
//  Created by houke on 16/9/19.
//  Copyright © 2016年 RichyLeo. All rights reserved.
//

#import "TTConcernTeamController.h"
#import "TTConcernTeamViewModel.h"
#import "TTConcernTeamView.h"
#import <ReactiveObjC/ReactiveObjC.h>


#define finishBtnW 55
#define finishBtnH 25
#define footerH 42
@interface TTConcernTeamController ()<UITableViewDelegate,UITableViewDataSource>
{
  
    NSMutableArray *customRootArr;
    __block NSMutableArray *customSecondaryArr;
    NSInteger nCurrent;
    int pageNumber;
    NSNumber *_pid;
    UIView *footerView;
    float _oldOffset;
}
@property (nonatomic, strong) TTConcernTeamView *teamView;
@end

@implementation TTConcernTeamController
-(void)setVm:(TTConcernTeamViewModel *)vm{
    _vm = vm;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    nCurrent = 0;
    customRootArr = [NSMutableArray arrayWithCapacity:0];
    customSecondaryArr = [NSMutableArray arrayWithCapacity:0];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [YRNotification postNotificationName:@"creatRecommendList" object:nil];
}
-(void)loadView{
    [super loadView];
    self.teamView = [TTConcernTeamView new];
    self.teamView.vm = _vm;
    self.view = self.teamView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xefefef);
    [self loadData];
    [self clickEvent];
}
-(void)loadData{
    
}
-(void)clickEvent{
    [[self.vm rac_signalForSelector:@selector(getBack)] subscribeNext:^(RACTuple * _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

//-(void)showFooterView
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:customSecondaryArr.count inSection:0];
//        UITableViewCell *cell = [rightTableView cellForRowAtIndexPath:indexPath];
//
//        UILabel *label = [cell.contentView viewWithTag:10];
//        label.textColor = ColorBottomGray;
//    });
//
//}

@end
