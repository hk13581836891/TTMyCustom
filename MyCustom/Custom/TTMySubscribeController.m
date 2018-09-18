//
//  TTMySubscribeController.m
//  MyCustom
//
//  Created by houke on 2018/9/18.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTMySubscribeController.h"
#import "TTMySubscribeView.h"
#import "TTSubscribeAuthorViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "TTSubscribeManagerController.h"

@interface TTMySubscribeController ()
@property (nonatomic, strong) TTMySubscribeView *mySubView;
@end

@implementation TTMySubscribeController
-(void)setVm:(TTSubscribeAuthorViewModel *)vm{
    _vm = vm;
}
-(void)loadView{
    [super loadView];
    self.mySubView = [TTMySubscribeView new];
    self.mySubView.vm = _vm;
    self.view = self.mySubView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self reloadDate];
    [self clickEvent];
}
-(void)clickEvent{
    @weakify(self);
    [[_vm rac_signalForSelector:@selector(getBack)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [[_vm rac_signalForSelector:@selector(pushToSubscribeManager)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        TTSubscribeManagerController *vc = [TTSubscribeManagerController new];
        vc.vm = self.vm;
        [self presentViewController:vc animated:YES completion:nil];
    }];
}
-(void)reloadDate{
    @weakify(self)
    [_vm getMySubscribeAuthorNewsList:^(bool isSuccess) {
        @strongify(self)
        if (isSuccess) {
            [self.mySubView.tableView reloadData];
        }
    }];

}
@end
