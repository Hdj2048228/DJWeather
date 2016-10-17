//
//  TQTWeather.h
//  DJWeather
//
//  Created by hdj on 16/10/13.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TQTWeatherCondition.h"
#import "TQTWeatherForeca.h"
#import "TQTWeatherLifedex.h"
#import "TQTWeatherLifedex2.h"
#import "TQTWeatherForecasts.h"

@interface TQTWeather : NSObject
/*
 *<weather valid="yes" pubdate="2016-10-13 12:50" gmt="2016-10-13 04:50" location="丰台" citycode="CHXX0027" tz="8.0">


*/
@property (nonatomic,copy) NSString *valid;
@property (nonatomic,copy) NSString *tz;
@property (nonatomic,copy) NSString *pubdate;
@property (nonatomic,copy) NSString *gmt;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString *citycode;

@property (nonatomic,strong)TQTWeatherForecasts  *forecasts;
@property (nonatomic,strong)TQTWeatherCondition  *condition;
@property (nonatomic,strong)TQTWeatherLifedex2   *lifedex2;
@property (nonatomic,strong)TQTWeatherLifedex    *lifedex;

@end
