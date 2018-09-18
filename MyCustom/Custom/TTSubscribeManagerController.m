//
//  TTSubscribeManagerController.m
//  MyCustom
//
//  Created by houke on 2018/9/17.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSubscribeManagerController.h"
#import "TTSubscribeTypeView.h"
#import "TTSubscribeManagerView.h"
#import "TTSubscribeAuthorViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface TTSubscribeManagerController ()
@property (nonatomic, strong) TTSubscribeManagerView *subManagerView;
@end

@implementation TTSubscribeManagerController

-(void)setVm:(TTSubscribeAuthorViewModel *)vm{
    _vm = vm;
}
-(void)loadView{
    [super loadView];
    self.subManagerView = [[TTSubscribeManagerView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _subManagerView.vm = _vm;
    self.view = self.subManagerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self prepareView];
    [self reloadDate];
    [self clickEvent];
}
-(void)clickEvent{
    @weakify(self);
    [[_vm rac_signalForSelector:@selector(subscribeManagerBack)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [[_vm rac_signalForSelector:@selector(reloadCategoryTableView)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
            [self.subManagerView.tableView reloadData];
    }];
}
-(void)reloadDate{
    @weakify(self)
    [_vm getAuthorTypeList:^(bool isSuccess) {
        @strongify(self)
        [self.subManagerView.typeView reloadData];
    }];
}
-(void)prepareView{
    
}
@end
