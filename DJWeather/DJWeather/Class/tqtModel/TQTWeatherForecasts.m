//
//  TQTWeatherForecasts.m
//  DJWeather
//
//  Created by hdj on 16/10/14.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import "TQTWeatherForecasts.h"
#import "TQTWeatherForeca.h"
@implementation TQTWeatherForecasts
+ (NSDictionary *)objectClassInArray{
    return @{
             @"foreca" : @"TQTWeatherForeca"
             };
}
    
- (NSMutableArray *)lowTmpArray{
    if (_lowTmpArray == nil) {
        _lowTmpArray = [NSMutableArray array];
        for (TQTWeatherForeca *foreca in self.foreca) {
            CGFloat low = foreca.low;
            [_lowTmpArray addObject:@(low)];
        }
    }
    return _lowTmpArray;
}
- (NSMutableArray *)highTmpArray{
    if (_highTmpArray == nil) {
        _highTmpArray = [NSMutableArray array];
        for (TQTWeatherForeca *foreca in self.foreca) {
            CGFloat high = foreca.high;
            [_highTmpArray addObject:@(high)];
        }
    }
    return _highTmpArray;
}
@end
