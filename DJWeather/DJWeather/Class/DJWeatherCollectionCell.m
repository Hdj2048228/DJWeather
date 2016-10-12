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

@end

@implementation DJWeatherCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setupViewsAlpha{
    NSLog(@"alpha %f",_views_alpha);
    for (UIView *view in _topHiddenViewsArray) {
        view.alpha = _views_alpha;
    }
    for (UIView *view in _bottomHiddeViewsArray) {
        view.alpha = _views_alpha;
    }
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGFloat  y =  [[self.dataSource objectAtIndex:self.indexPath.row] floatValue];
    CGPoint currentPoint = CGPointMake(self.frame.size.width/2, y+self.frame.size.height/2);
    if (self.indexPath.row!=0) {
        CGFloat  pre_y =  [[self.dataSource objectAtIndex:self.indexPath.row - 1] floatValue];
        CGPoint startPoint = CGPointMake(0, (pre_y+y)/2 +self.frame.size.height/2);
        [self drawLine:startPoint endPoint:currentPoint];
    }
    
    if ((self.indexPath.row < self.dataSource.count-1)) {
        CGFloat  next_y =  [[self.dataSource objectAtIndex:self.indexPath.row + 1] floatValue];
        CGPoint nextLinePoint = CGPointMake(self.frame.size.width, (next_y+y)/2 +self.frame.size.height/2);
        [self drawLine:currentPoint endPoint:nextLinePoint];
    }
}
- (void)drawLine{
    CGFloat  y =  [[self.dataSource objectAtIndex:self.indexPath.row] floatValue];
    CGPoint currentPoint = CGPointMake(self.frame.size.width/2, y+self.frame.size.height/2);
    [self emptyLayers];
    [self drawCirclePoint:currentPoint];
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
- (void)drawLine:(CGPoint)startPoint endPoint:(CGPoint)endtPoint{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0;
    path.lineCapStyle = kCGLineCapSquare; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound;
    
//    CGPoint nextPoint = [[self.model.pointsArray objectAtIndex:i+1] CGPointValue];
    CGFloat radio = 1.;
    ((endtPoint.y - startPoint.y)>=0)?(radio):(radio=-radio);
    CGPoint  controlPoint = CGPointMake(endtPoint.x, endtPoint.y+radio);
    [path moveToPoint:startPoint];
    UIColor *color = [UIColor redColor];
    [color set];
    
    [path addQuadCurveToPoint:endtPoint controlPoint:controlPoint];
    
    [path addLineToPoint:endtPoint];
    [path stroke];
}
/**
 *  画点所定义的圆
 */
- (void)drawCirclePoint:(CGPoint)originPoint{
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    
    
    UIBezierPath *ciclePath = [UIBezierPath bezierPathWithArcCenter:originPoint radius:2
                                                         startAngle:0 endAngle:M_PI*2 clockwise:YES];
    layer.path = ciclePath.CGPath;
    layer.fillColor = [UIColor greenColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:layer];
    [self.cicleLayersArray addObject:layer];

}
-(void)emptyLayers{
    for (CAShapeLayer *layer in _cicleLayersArray) {
        [layer removeFromSuperlayer];
    }
}
- (void)setup{
    _cicleLayersArray = [NSMutableArray array];
    _LineLayersArray = [NSMutableArray array];
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
@end
