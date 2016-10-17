//
//  TQTWeatherForeca.h
//  DJWeather
//
//  Created by hdj on 16/10/13.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TQTWeatherForeca : NSObject

/**
 * <foreca date="2016-10-13" code="2" code2="2" text="霾" high="23" low="9" wind="微风"/>
 */
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *code2;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign)  CGFloat high;
@property (nonatomic,assign)  CGFloat low;
@property (nonatomic,copy) NSString *wind;


@end
