//
//  DJWeatherCollectionCell.h
//  DJSmallChat
//
//  Created by hdj on 16/9/27.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJLineChatListModel.h"
#import "TQTWeather.h"
@interface DJWeatherCollectionCell : UICollectionViewCell

@property (nonatomic,copy)NSMutableArray *highTmpArray;//  高数据源
@property (nonatomic,copy)NSMutableArray *lowTpmArray;//  低数据源

@property (nonatomic,strong)NSIndexPath *indexPath;// 位置
@property (nonatomic,strong) DJLineChatListModel *model;
@property (nonatomic,strong) TQTWeather *tqtModel;

@end

