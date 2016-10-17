//
//  DJLineChatModel.h
//  DJSmallChat
//
//  Created by hdj on 16/9/28.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJLineChatListModel : NSObject
/**
 *  y轴最大值
 */
@property (nonatomic,assign) CGFloat yMaxValue;
/**
 *  y轴最大值
 */
@property (nonatomic,assign) CGFloat yMinValue;

/**
 *  y值得比例
 */
@property (nonatomic,assign) CGFloat y_Ratio;

/**
 *  x轴最大值
 */
@property (nonatomic,assign) CGFloat xMaxValue;
/**
 *  x轴最小值
 */
@property (nonatomic,assign) CGFloat xMinValue;

/**
 *  x值得比例
 */
@property (nonatomic,assign) CGFloat x_Ratio;


/**
 *  横向的值即x坐标的值
 */
@property (nonatomic,copy) NSArray *x_valueArray;

/**
 *  竖向的即y坐标的值
 */
@property (nonatomic,copy) NSArray *y_valueArray;
@property (nonatomic,copy) NSArray *y_valueArray_2;
/**
 *  如果位置固定
 */
@property (nonatomic,strong) NSArray *pointsArray;

/**
 *  如果位置固定
 */
@property (nonatomic,strong) NSArray *lineColorsArray;

@end
