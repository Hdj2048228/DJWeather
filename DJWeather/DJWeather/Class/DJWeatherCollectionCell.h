//
//  DJWeatherCollectionCell.h
//  DJSmallChat
//
//  Created by hdj on 16/9/27.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJWeatherCollectionCell : UICollectionViewCell

@property (nonatomic,copy)NSMutableArray *dataSource;

@property (nonatomic,strong)NSIndexPath *indexPath;
@end

