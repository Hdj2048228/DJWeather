//
//  DJDefines.h
//  DJWeather
//
//  Created by hdj on 16/10/12.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#ifndef DJDefines_h
#define DJDefines_h

#import "Masonry.h"
#import "XMLDictionary.h"
#import "GDataXMLNode.h"
#import "MJExtension.h"
#import <UIKit/UIKit.h>

#define K_ScreenWidth   [UIScreen mainScreen].bounds.size.width

#define K_ScreenHeight  [UIScreen mainScreen].bounds.size.height


#define K_DJWeatherHeaderHeight  0.75* K_ScreenHeight
#define K_DJWeatherCellHeight    0.5* K_ScreenHeight

#define DJRgba(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255 blue:b/255. alpha:a]
#endif /* DJDefines_h */
