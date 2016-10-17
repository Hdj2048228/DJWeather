//
//  TQTWeatherForecasts.h
//  DJWeather
//
//  Created by hdj on 16/10/14.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQTWeatherForecasts : NSObject

@property (nonatomic,copy) NSArray *foreca;
@property (nonatomic,copy) NSMutableArray *lowTmpArray;
@property (nonatomic,copy) NSMutableArray *highTmpArray;

@end
