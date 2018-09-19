//
//  TTConcernLeftTableViewCell.m
//  Tian_IOS
//
//  Created by houke on 2017/6/16.
//  Copyright © 2017年 RichyLeo. All rights reserved.
//

#import "TTConcernLeftTableViewCell.h"
#import "TTConcernTeamViewModel.h"
#import "MasonryHeader.h"

@interface TTConcernLeftTableViewCell ()

@end
@implementation TTConcernLeftTableViewCell
-(void)setVm:(TTConcernTeamViewModel *)vm{
    _vm = vm;
}
-(void)setModel:(TTConcernTeamModel *)model
{
    _model = model;
    _textLab.text = [NSString stringWithFormat:@"%@ %li",model.name, model.ID.intValue == -1 ? _vm.concernTeamArr.count : (long)model.count];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xefefef);
        [self setupUI];
    }
    
    return self;
}
-(UILabel *)textLab{
    if (!_textLab) {
        _textLab = [[UILabel alloc] initWithText:@"分类" textColor:HEXCOLOR(0x444444) font:PingFangSC_Regular(14)];
        _textLab.numberOfLines = 1;
    }
    return _textLab;
}
-(void)setupUI{
    [self.contentView addSubview:self.textLab];
    [_textLab makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}



@end
