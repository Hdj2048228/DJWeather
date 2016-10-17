//
//  DJWeatherCollectionCell.h
//  DJSmallChat
//
//  Created by hdj on 16/9/27.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJLineChatListModel.h"
@interface DJWeatherCollectionCell : UICollectionViewCell

@property (nonatomic,copy)NSMutableArray *dataSource;//  数据源

@property (nonatomic,strong)NSIndexPath *indexPath;// 位置
@property (nonatomic,strong) DJLineChatListModel *model;
@end

