//
//  DJLineChatModel.m
//  DJSmallChat
//
//  Created by hdj on 16/9/28.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import "DJLineChatListModel.h"
#import "DJDefines.h"
extern CGFloat DJLineChatHeight;
static NSInteger  xValue_count = 10;
@implementation DJLineChatListModel
- (CGFloat)y_Ratio{
  return  self.yMaxValue/DJLineChatHeight;
}
-(CGFloat)yMaxValue{
    return 50;
}
-(NSArray *)pointsArray{
    if (_pointsArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        CGFloat cellWidth = K_ScreenWidth/7.;
        CGFloat centerX = cellWidth/2.;
        for (int i= 0;i<self.x_valueArray.count;i++) {
            CGFloat x = centerX +i*cellWidth;// 每个cell 的中间位置
            CGFloat y = [[self.y_valueArray objectAtIndex:i] floatValue]*self.y_Ratio;
            [array addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        }
        _pointsArray = array;
    }
    return _pointsArray;
}
-(NSArray *)x_valueArray{
    if (_x_valueArray.count == 0) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        for (int i= 0;i < 10;i++) {
            CGFloat x = 20+i*20;;// 每个cell 的中间位置
            [array addObject:@(x)];
        }
        _x_valueArray = [NSArray arrayWithArray:array];
    }
    return _x_valueArray;
}
-(NSArray *)y_valueArray{
    if (_y_valueArray.count == 0) {
        CGFloat max = self.yMaxValue;
        NSInteger max_Integer = max;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        for (int i= 0;i<self.x_valueArray.count;i++) {
            CGFloat y = arc4random()%max_Integer;// 每个cell 的中间位置
            y>max?y=max:y;
            [array addObject:@(y)];
        }
        _y_valueArray = [NSArray arrayWithArray:array];
    }
    return _y_valueArray;
}
-(NSArray *)lineColorsArray{
    if (_lineColorsArray.count == 0) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i= 0;i<(self.x_valueArray.count);i++) {
            CGFloat r,g,b;
            r = arc4random()%255/255.0;
            g = arc4random()%255/255.0;
            b = arc4random()%255/255.0;
           UIColor *randomColor  =[UIColor colorWithRed:r green:g blue:b alpha:1.];
            [array addObject:randomColor];
        }
        _lineColorsArray = array;
    }
    return _lineColorsArray;
}
@end
