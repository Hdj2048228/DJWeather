//
//  DJWeatherCell.h
//  DJSmallChat
//
//  Created by hdj on 16/9/27.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJLineChatListModel.h"
#import "DJDefines.h"
#import "TQTWeather.h"
@interface DJWeatherCell : UITableViewCell


@property (nonatomic,strong)DJLineChatListModel *model;
@property (nonatomic,strong)TQTWeather *tqtModel;

@property (nonatomic,strong)NSMutableArray *dataSource;
/**
 *  可以看到的cell的数量
 */
@property(nonatomic,assign) NSInteger  visibleCount;


@property(nonatomic,assign) CGFloat width_cell;
@end
