//
//  TTNoConcernView.h
//  MyCustom
//
//  Created by houke on 2018/9/15.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTNoConcernView : UICollectionView

@end

#define itemW (UIScreen.mainScreen.bounds.size.width - 20 *2 - 26 *3)/4
#define itemH itemW + 6+ 16

@interface TTNoConcernCollectionCell : UICollectionViewCell

@end
