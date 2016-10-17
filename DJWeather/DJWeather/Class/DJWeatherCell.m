//
//  DJWeatherCell.m
//  DJSmallChat
//
//  Created by hdj on 16/9/27.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import "DJWeatherCell.h"
#import "DJWeatherCollectionCell.h"

CGFloat DJLineChatHeight = 120.;
static NSString *K_DJWeatherCollectionCell = @"DJWeatherCollectionCell";

@interface DJWeatherCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UILabel *_weekLabel;
    UIImageView *_weathetImageView;
    UICollectionView *_collectionView;
}
@end

@implementation DJWeatherCell

- (void)setModel:(DJLineChatListModel *)model{
    _model = model;
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:model.y_valueArray];
    [_collectionView reloadData];
    [_collectionView setNeedsLayout];
    [_collectionView setNeedsDisplay];
}
- (void)setTqtModel:(TQTWeather *)tqtModel{
    _tqtModel = tqtModel;
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:tqtModel.forecasts.lowTmpArray];
    [_collectionView reloadData];
    [_collectionView setNeedsLayout];
    [_collectionView setNeedsDisplay];

}
- (NSInteger)visibleCount{
    return  (_visibleCount = ((_visibleCount == 0)?2:7));
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:@""];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setup];
    }
    return self;
}
- (void)setWidth_cell:(CGFloat)width_cell{
    _width_cell = width_cell;
    [_collectionView reloadData];
    [_collectionView setNeedsLayout];
    [_collectionView setNeedsDisplay];
}
- (void)setup{
    _dataSource = [NSMutableArray array];
   
    [self loadCollectionView];
}
- (void)loadCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //配置item的边距 坑爹的必须后面带小数点，不然默认间距
    layout.minimumLineSpacing = 0.0f;
    layout.sectionInset = UIEdgeInsetsMake(0., 0., 0., 0.);

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[DJWeatherCollectionCell class] forCellWithReuseIdentifier:K_DJWeatherCollectionCell];
    [self.contentView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
}
#pragma mark UICollectionView delegate && dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
//配置每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%f",K_ScreenWidth/self.visibleCount);
    return CGSizeMake(self.width_cell==0? K_ScreenWidth/self.visibleCount:self.width_cell, self.contentView.frame.size.height);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DJWeatherCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:K_DJWeatherCollectionCell forIndexPath:indexPath];
    cell.indexPath = indexPath;
    if (self.model) {
         cell.model = _model;
    }
    if(self.tqtModel){
        cell.tqtModel = _tqtModel;
    }
        
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
//配置section数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


@end
