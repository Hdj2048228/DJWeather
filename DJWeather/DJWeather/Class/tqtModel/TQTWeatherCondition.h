//
//  DJWeatherCondition.h
//  DJWeather
//
//  Created by hdj on 16/10/13.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQTWeatherCondition : NSObject

/**
 *  <condition code="18" temp="20" wind="南风2级" humidity="58" ycode="20" pm="1" pres="1021.5" feels="20" desc_short="温度适宜" desc_long="不冷不热的天，不离不弃的人，还有不__不__的__"/>
 */
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *temp;
@property (nonatomic,copy) NSString *wind;
@property (nonatomic,copy) NSString *humidity;
@property (nonatomic,copy) NSString *ycode;
@property (nonatomic,copy) NSString *pm;
@property (nonatomic,copy) NSString *pres;
@property (nonatomic,copy) NSString *feels;
@property (nonatomic,copy) NSString *desc_short;
@property (nonatomic,copy) NSString *desc_long;


@end
