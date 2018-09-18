//
//  TTConcernAllRightTableViewCell.m
//  Tian_IOS
//
//  Created by houke on 2017/6/16.
//  Copyright © 2017年 RichyLeo. All rights reserved.
//

#import "TTConcernAllRightTableViewCell.h"
#import "TTConcernTeamModel.h"

#define rightCellH 65
#define rightCellW 550*SCREEN_WIDTH/750

@implementation TTConcernAllRightTableViewCell
{
    UIImageView * iconImg;
    UIButton *concernBtn;
    UILabel *nameLab;
    NSString *status;
}

+(instancetype)rightCell:(UITableView *)tableview
{
    static NSString *ID = @"rightCell";
    TTConcernAllRightTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TTConcernAllRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.backgroundColor = HEXCOLOR(0xfbfbfb);
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}

-(void)initCell
{
    iconImg = [[UIImageView alloc] init];
    iconImg.frame = CGRectMake(0, 0, 40, 40);
    iconImg.center = CGPointMake(20+CGRectGetWidth(iconImg.frame)/2, rightCellH/2);
    iconImg.image = [UIImage imageNamed:@"qq"];
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.cornerRadius = CGRectGetHeight(iconImg.frame)/2;
    [self.contentView addSubview:iconImg];
    
    concernBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    concernBtn.frame = CGRectMake(0, 0, 65, 25);
    concernBtn.center = CGPointMake(rightCellW -10-CGRectGetWidth(concernBtn.frame)/2, rightCellH/2);
    [concernBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
    [concernBtn setTitleColor:HEXCOLOR(0xf33a28) forState:UIControlStateNormal];
    concernBtn.titleLabel.font = PingFangSC_Regular(12);
    [concernBtn addTarget:self action:@selector(concernButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    concernBtn.layer.borderWidth = 1;;
    concernBtn.layer.cornerRadius = CGRectGetHeight(concernBtn.frame)/2;
    concernBtn.layer.borderColor = HEXCOLOR(0xf33a28).CGColor;
    [self.contentView addSubview:concernBtn];
    
    nameLab = [[UILabel alloc] init];
    nameLab.frame = CGRectMake(CGRectGetMaxX(iconImg.frame)+10, rightCellH/2-15/2, CGRectGetMinX(concernBtn.frame) - CGRectGetMaxX(iconImg.frame) - 20, 15);
    nameLab.text = @"火箭";
    nameLab.textColor = HEXCOLOR(0x444444);
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.font = PingFangSC_Regular(15);
    [self.contentView addSubview:nameLab];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xe4e4e4);
    line.frame = CGRectMake(0, rightCellH-0.8, rightCellW, 0.8);
    [self.contentView addSubview:line];
    
    
}

-(void)setModel:(TTConcernTeamModel *)model
{
    _model = model;
    [iconImg sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"plic"]];
    
    nameLab.text = model.name;
    
    if ([model.status intValue]==0) {
        [concernBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
        [concernBtn setTitleColor:HEXCOLOR(0xf33a28) forState:UIControlStateNormal];
        concernBtn.layer.borderColor = HEXCOLOR(0xf33a28).CGColor;

    }else{
        [concernBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [concernBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        concernBtn.layer.borderColor = HEXCOLOR(0xe4e4e4).CGColor;

    }
}

@end
