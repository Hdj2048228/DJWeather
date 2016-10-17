//
//  DJWeatherCollectionCell.m
//  DJSmallChat
//
//  Created by hdj on 16/9/27.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import "DJWeatherCollectionCell.h"
#import "DJDefines.h"
static CGFloat windHeight = 40;
static CGFloat labelFont = 12.;
static CGFloat coircle_radius = 3;
@interface DJWeatherCollectionCell ()
{
    UILabel *_weekLabel;//周几
    UILabel *_dateLabel;//日期
    UIImageView *_topWeatherImageView;//  顶部天气情况(阴晴的图片)
    UILabel *_topTemperatureLabel;   //  顶部温度文字
    UIImageView *_bottomWeatherImageView;//  底部天气情况(阴晴的图片)
    UILabel *_bottomTemperatureLabel;   //  底部温度文字
    UILabel *_bottomWindLabel;   // 风力文字（微风《2级）
    CGFloat _views_alpha;
    
}
@property (nonatomic,copy)NSMutableArray *cicleLayersArray;
//Array[CAShapeLayer]
@property (nonatomic,copy)NSMutableArray *LineLayersArray;
//Array[UIBerizer]
@property (nonatomic,copy)NSMutableArray *topHiddenViewsArray;
@property (nonatomic,copy)NSMutableArray *bottomHiddeViewsArray;

@property (nonatomic,copy)NSMutableArray *pathsArray;
@property (nonatomic,copy)NSMutableArray *pointsArray;
@property (nonatomic,copy)NSMutableArray *startAndEndPointsArray;

@end

@implementation DJWeatherCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setupViewsAlpha{
    for (UIView *view in _topHiddenViewsArray) {
        view.alpha = _views_alpha;
    }
    for (UIView *view in _bottomHiddeViewsArray) {
        view.alpha = _views_alpha;
    }
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.model) {
        [self computePointByYValuesArray:_model.y_valueArray];
        [self computePointByYValuesArray:_model.y_valueArray_2];
    }
    
}
- (void)computePointByYValuesArray:(NSArray *)dataSource{
    CGFloat  y =  [[dataSource objectAtIndex:self.indexPath.row] floatValue];
    CGPoint currentPoint = CGPointMake(self.frame.size.width/2, y+self.frame.size.height/2);
    if (self.indexPath.row!=0) {
        CGFloat  pre_y =  [[dataSource objectAtIndex:self.indexPath.row - 1] floatValue];
        CGPoint startPoint = CGPointMake(0, (pre_y+y)/2 +self.frame.size.height/2);
        [self drawLine:startPoint endPoint:currentPoint];
    }
    
    if ((self.indexPath.row < dataSource.count-1)) {
        CGFloat  next_y =  [[dataSource objectAtIndex:self.indexPath.row + 1] floatValue];
        CGPoint nextLinePoint = CGPointMake(self.frame.size.width, (next_y+y)/2 +self.frame.size.height/2);
        [self drawLine:currentPoint endPoint:nextLinePoint];
    }
}
- (void)setModel:(DJLineChatListModel *)model{
    _model = model;
    [self emptyLayers]; // 清空layers
    [self setNeedsLayout];
    [self setNeedsDisplay];
}
- (void)drawLine{
    CGFloat  y =  [[self.model.y_valueArray objectAtIndex:self.indexPath.row] floatValue];
    CGPoint currentPoint = CGPointMake(self.frame.size.width/2, y+self.frame.size.height/2);
    [self drawCirclePoint:currentPoint];
    
    CGFloat  y2 =  [[self.model.y_valueArray_2 objectAtIndex:self.indexPath.row] floatValue];
    CGPoint currentPoint2 = CGPointMake(self.frame.size.width/2, y2+self.frame.size.height/2);
    [self drawCirclePoint:currentPoint2];
 }

- (void)layoutSubviews{
    [super layoutSubviews];
    [self drawLine];
    CGFloat maxWidth = K_ScreenWidth/2;
    CGFloat minWidth = K_ScreenWidth/7;
    _views_alpha = (self.frame.size.width- minWidth)/(maxWidth - minWidth);
    [self setupViewsAlpha];
}
//画两点之间的线
- (void)drawLine:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0;
    path.lineCapStyle = kCGLineCapSquare; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound;
   
    CGFloat radio = 1.;
    ((endPoint.y - startPoint.y)>=0)?(radio):(radio=-radio);
    CGPoint  controlPoint = CGPointMake(endPoint.x, endPoint.y+radio);
    [path moveToPoint:startPoint];
    UIColor *color = DJRgba(255, 0, 0, (1-_views_alpha));

    [color set];
    
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    [path addLineToPoint:endPoint];
    [path stroke];
    [self.pathsArray addObject:path];
    [_startAndEndPointsArray addObject:[NSValue valueWithCGPoint:startPoint]];
    [_startAndEndPointsArray addObject:[NSValue valueWithCGPoint:endPoint]];
}
/**
 *  画点所定义的圆
 */
- (void)drawCirclePoint:(CGPoint)originPoint{
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    UIBezierPath *ciclePath = [UIBezierPath bezierPathWithArcCenter:originPoint radius:coircle_radius
                                                         startAngle:0 endAngle:M_PI*2 clockwise:YES];
    layer.path = ciclePath.CGPath;
    layer.fillColor = [UIColor greenColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:layer];
    [self.cicleLayersArray addObject:layer];
    [self.pointsArray addObject:[NSValue valueWithCGPoint:originPoint]];

}
-(void)emptyLayers{
    for (CAShapeLayer *layer in _cicleLayersArray) {
        [layer removeFromSuperlayer];
    }
    [_cicleLayersArray removeAllObjects];
    [_pathsArray removeAllObjects];
    [_pointsArray removeAllObjects];
    [_startAndEndPointsArray removeAllObjects];

}
- (void)setup{
    _cicleLayersArray = [NSMutableArray array];
    _LineLayersArray = [NSMutableArray array];
    _pathsArray = [NSMutableArray array];
    _pointsArray = [NSMutableArray array];
    _startAndEndPointsArray = [NSMutableArray array];
    _weekLabel = [[UILabel alloc]init];
    _weekLabel.text = @"周一";
    _weekLabel.textColor = [UIColor whiteColor];
    _weekLabel.font = [UIFont systemFontOfSize:labelFont];
    
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.text = @"9/29";
    _dateLabel.textColor = [UIColor whiteColor];
    _dateLabel.font = [UIFont systemFontOfSize:labelFont];

    _topWeatherImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"add_friend_icon_offical"]];
    
    _bottomWeatherImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"add_friend_icon_offical"]];
    _topTemperatureLabel = [[UILabel alloc]init];
    _topTemperatureLabel.text = @"19";
    _topTemperatureLabel.textColor = [UIColor whiteColor];
    _topTemperatureLabel.font = [UIFont systemFontOfSize:labelFont];


    _bottomTemperatureLabel = [[UILabel alloc]init];
    _bottomTemperatureLabel.text = @"19";
    _bottomTemperatureLabel.textColor = [UIColor whiteColor];
    _bottomTemperatureLabel.font = [UIFont systemFontOfSize:labelFont];

    _bottomWindLabel = [[UILabel alloc]init];
    _bottomWindLabel.text = @"微风\n<2级";
    _bottomWindLabel.textColor = [UIColor whiteColor];
//    _bottomWindLabel.textAlignment = NSTextAlignmentLeft;
    _bottomWindLabel.font = [UIFont systemFontOfSize:labelFont];
    _bottomWindLabel.numberOfLines = 2;
    
    _topHiddenViewsArray =[NSMutableArray arrayWithObjects:_topWeatherImageView,_dateLabel,nil];
    _bottomHiddeViewsArray = [NSMutableArray arrayWithObjects:_bottomWeatherImageView,_bottomTemperatureLabel,nil];
//    [self.contentView dj_addSubviews:@[_weekLabel,_dateLabel,_topWeatherImageView,_topTemperatureLabel,_bottomWeatherImageView,_bottomTemperatureLabel,_bottomWindLabel]];
    NSArray *subViews = @[_weekLabel,_dateLabel,_topWeatherImageView,_topTemperatureLabel,_bottomWeatherImageView,_bottomTemperatureLabel,_bottomWindLabel];
    [subViews enumerateObjectsUsingBlock:^(UIView  *view, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:view];
    }];
    UIView *contentView = self.contentView;
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(5);
        make.left.equalTo(contentView).offset(5);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weekLabel.mas_bottom).offset(2);
        make.centerX.equalTo(_weekLabel);
    }];
    [_topWeatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(5);
        make.right.equalTo(contentView).offset(-5);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [_topTemperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topWeatherImageView.mas_bottom).offset(2);
        make.centerX.equalTo(_topWeatherImageView);
    }];
    [_bottomWindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentView).offset(0.);
        make.left.equalTo(contentView).offset(15.*(375 /K_ScreenWidth));
    }];
    [_bottomWeatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bottomWindLabel.mas_top).offset(-5);
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [_bottomTemperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bottomWeatherImageView.mas_top);
        make.centerX.equalTo(_bottomWeatherImageView);
    }];
}
#pragma  mark touch
- (void)touchWithPoint:(CGPoint)touchPoint{
    for (int i = 0; i < (int) _pointsArray.count - 1; i ++) {
        CGPoint p1 = [_pointsArray[i] CGPointValue];
        CGPoint p2 = [_pointsArray[i + 1] CGPointValue];
        
        float distanceToP1 = fabs(hypot(touchPoint.x - p1.x, touchPoint.y - p1.y));
        float distanceToP2 = hypot(touchPoint.x - p2.x, touchPoint.y - p2.y);
        
        float distance = MIN(distanceToP1, distanceToP2);
        
        if (distance <= coircle_radius * 2) {
            NSLog(@"point ");
        }
    }

}
- (void)touchWithLinePoint:(CGPoint)touchPoint{
    NSArray *linePointsArray = _startAndEndPointsArray;
    for (int i = 0; i < (int) linePointsArray.count - 1; i += 2) {
        CGPoint p1 = [linePointsArray[i] CGPointValue];
        CGPoint p2 = [linePointsArray[i + 1] CGPointValue];
        
        // Closest distance from point to line
        float distance = fabs(((p2.x - p1.x) * (touchPoint.y - p1.y)) - ((p1.x - touchPoint.x) * (p1.y - p2.y)));
        distance /= hypot(p2.x - p1.x, p1.y - p2.y);
        
        if (distance <= 5.0) {
            // Conform to delegate parameters, figure out what bezier path this CGPoint belongs to.
            for (UIBezierPath *path in _pathsArray) {
                BOOL pointContainsPath = CGPathContainsPoint(path.CGPath, NULL, p1, NO);
                
                if (pointContainsPath) {
                    NSLog(@"Line pointContainsPath");
                }
            }
        }
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    [self touchWithPoint:touchPoint];
    [self touchWithLinePoint:touchPoint];
}

@end
