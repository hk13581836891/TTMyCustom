//
//  TTConcernTeamView.m
//  MyCustom
//
//  Created by houke on 2018/9/18.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTConcernTeamView.h"
#import "TTConcernTeamViewModel.h"
#import "TTConcernLeftTableViewCell.h"
#import "TTConcernRightTableViewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "MasonryHeader.h"

@interface TTConcernTeamView ()
@property (nonatomic, strong) MainNavView * nav;

@end
@implementation TTConcernTeamView

-(void)setVm:(TTConcernTeamViewModel *)vm{
    _vm = vm;
}
-(void)backBtnDown{
    [_vm getBack];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self prepareTableView];
    }
    return self;
}
-(void)prepareTableView{
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.showsVerticalScrollIndicator = NO;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor = HEXCOLOR(0xefefef);
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.showsVerticalScrollIndicator = NO;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.backgroundColor = [UIColor whiteColor];
    
    
    [_leftTableView registerClass:[TTConcernLeftTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TTConcernLeftTableViewCell class])];
    [_rightTableView registerClass:[TTConcernRightTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TTConcernRightTableViewCell class])];
    
}
#pragma mark tableView datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftTableView) {
        return _vm.teamTypeArr.count;
    }else{
        return _vm.categoryTeamArr.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        return 45;
    }else{
        return 65;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        TTConcernLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTConcernLeftTableViewCell class]) forIndexPath:indexPath];
        cell.vm = _vm;
        cell.model = _vm.teamTypeArr[indexPath.row];
        
        return cell;
    }else{
//        if (indexPath.row == customSecondaryArr.count) {
//            static NSString *ID  = @"labelId";
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//            if (!cell) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//            }
//            UILabel *label = [cell.contentView viewWithTag:10];
//            if (!label) {
//                label =[[UILabel alloc] init];
//                label.tag = 10;
//                label.frame = CGRectMake(0, 15, 250, 12);
//                label.textAlignment = NSTextAlignmentCenter;
//                label.text = @"已全部加载完毕";
//                label.textColor = HEXCOLOR(0x88888888);
//                label.font = PingFangSC_Regular(12);
//                [cell.contentView addSubview:label];
//            }
//            if (customSecondaryArr.count == 0) {
//                label.hidden = YES;
//            }else{
//                label.hidden = NO;
//            }
//            return cell;
//
//        }else{
//            TTConcernAllRightTableViewCell * cell = [TTConcernAllRightTableViewCell rightCell:tableView];
//
//            cell.model = customSecondaryArr[indexPath.row];
//            return cell;
//        }
        TTConcernRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTConcernRightTableViewCell class]) forIndexPath:indexPath];
        cell.model = _vm.categoryTeamArr[indexPath.row];
        cell.vm = _vm;
        return cell;
        
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTableView) {
        TTConcernLeftTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLab.textColor = HEXCOLOR(0xf33a28);
        TTConcernTeamModel *model = _vm.teamTypeArr[indexPath.row];
        @weakify(self)
        [_vm getCategoryTeamList:model.ID finish:^(bool isSuccess) {
            @strongify(self)
            if (isSuccess) {
                [self.rightTableView reloadData];
            }
        }];
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        TTConcernLeftTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLab.textColor = HEXCOLOR(0x444444);
    }
}
/*

 -(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
 {
 CGFloat height;
 if (customSecondaryArr.count>0) {
 if (tableView == rightTableView) {
 height = 0;
 }else{
 height = 0;
 }
 }else{
 height = 0;
 }
 
 
 return height;
 
 }
 -(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
 {
 footerView = [[UIView alloc] init];
 
 if (tableView == rightTableView) {
 footerView.backgroundColor = WhiteColor;
 UILabel *label = [[UILabel alloc] init];
 label.tag = 10;
 label.frame = CGRectMake(0, 15, 250, 12);
 label.textAlignment = NSTextAlignmentCenter;
 label.text = @"已全部加载完毕";
 label.textColor = [UIColor clearColor];
 label.font = PingFangSC_Regular(12);
 [footerView addSubview:label];
 
 }else{
 
 }
 
 
 return footerView;
 }
 
 
 
 
 -(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (indexPath.row == customSecondaryArr.count )
 {
 //        [self showFooterView];
 
 }
 
 
 }
 */
#pragma mark 懒加载创建控件
-(MainNavView *)nav{
    if (!_nav) {
        _nav = [[MainNavView alloc] initWithColor:UIColor.whiteColor andTaget1:self andAction:@selector(backBtnDown) andTitle:@"全部"];
    }
    return _nav;
}
-(NoEstimatedHeightUITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[NoEstimatedHeightUITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _leftTableView.backgroundColor = [UIColor yellowColor];
    }
    return _leftTableView;
}
-(NoEstimatedHeightUITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[NoEstimatedHeightUITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
   _rightTableView.backgroundColor = [UIColor redColor];
    }
    return _rightTableView;
}
-(void)setupUI{
    [self addSubview:self.nav];
    [self addSubview:self.leftTableView];
    [self addSubview:self.rightTableView];
    [_leftTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.nav.bottom);
        make.width.equalTo(self).multipliedBy(0.267);
        make.bottom.equalTo(self);
    }];
    [_rightTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTableView.right);
        make.top.equalTo(self.leftTableView);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}
@end
