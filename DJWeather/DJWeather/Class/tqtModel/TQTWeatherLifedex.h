//
//  TQTWeatherLifedex.h
//  DJWeather
//
//  Created by hdj on 16/10/13.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQTWeatherLifedex : NSObject
/**
 * <lifedex sport="低糖低热量" uv="中等" cloth="单衣类" cwash="不适宜" cold="低发期" comfort="暂无" insolate="暂无" umbrella="暂无" car="3,8"/>

 */
@property (nonatomic,copy) NSString *sport;
@property (nonatomic,copy) NSString *uv;
@property (nonatomic,copy) NSString *cloth;
@property (nonatomic,copy) NSString *humidity;
@property (nonatomic,copy) NSString *cwash;
@property (nonatomic,copy) NSString *cold;
@property (nonatomic,copy) NSString *comfort;
@property (nonatomic,copy) NSString *insolate;
@property (nonatomic,copy) NSString *umbrella;
@property (nonatomic,copy) NSString *car;


@end
