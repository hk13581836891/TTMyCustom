//
//  TTConcernAllLeftTableViewCell.m
//  Tian_IOS
//
//  Created by houke on 2017/6/16.
//  Copyright © 2017年 RichyLeo. All rights reserved.
//

#import "TTConcernAllLeftTableViewCell.h"
#import "TTConcernTeamModel.h"

#define leftCellH 45
#define leftCellW 200*SCREEN_WIDTH/750

@implementation TTConcernAllLeftTableViewCell
{
    UIView *leftView;
    UILabel *textLab;
}

+(instancetype)leftCell:(UITableView *)tableview
{
    static NSString *ID = @"leftCell";
    TTConcernAllLeftTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TTConcernAllLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.backgroundColor = HEXCOLOR(0xefefef);
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
    leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, 5, leftCellH);
    leftView.backgroundColor = HEXCOLOR(0xf33a28);
    [self.contentView addSubview:leftView];
    leftView.hidden = YES;
    
    textLab = [[UILabel alloc] init];
    textLab.text = @"ddd";
    textLab.frame = CGRectMake(10, 0, leftCellW-20, 14);
    textLab.center = CGPointMake(leftCellW/2, leftCellH/2);
    textLab.textColor = HEXCOLOR(0x444444);
    textLab.textAlignment = NSTextAlignmentCenter;
    textLab.font = PingFangSC_Regular(14);
    if (IS_IPHONE_5) {
        textLab.font = PingFangSC_Regular(14);
    }
    [self.contentView addSubview:textLab];
    
}

-(void)setModel:(TTConcernTeamModel *)model
{
    _model = model;
    textLab.text = [NSString stringWithFormat:@"%@ %li",model.name,model.count];
}

@end
