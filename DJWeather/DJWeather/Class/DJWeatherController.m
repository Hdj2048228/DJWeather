//
//  DJWeatherController.m
//  DJSmallChat
//
//  Created by hdj on 16/9/27.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import "DJWeatherController.h"
#import "DJWeatherCell.h"
#import "DJLineChatListModel.h"
//static CGFloat DJWeatherCelllWith = 320./2.;
static NSString *K_DJWeatherCell = @"DJWeatherCell";

@interface DJWeatherController()<UIScrollViewDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)CGPoint originOffest;

@end

@implementation DJWeatherController
-(instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
    }
    return self;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        for (int i =0 ; i<10; i++) {
            [_dataSource insertObject:[NSString stringWithFormat:@"%d",i] atIndex:0];
        }
    }
    return _dataSource;
}

- (void)viewDidLoad{
    [super viewDidLoad];

    [self.tableView registerClass:[DJWeatherCell class] forCellReuseIdentifier:K_DJWeatherCell];
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.rowHeight = K_ScreenWidth/2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if(indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:K_DJWeatherCell];
        DJWeatherCell *weatherCell =  (DJWeatherCell *)cell;
        weatherCell.model = [[DJLineChatListModel alloc]init];
    }else{
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DJUITableViewCell"];
        cell.textLabel.text = @"UITableViewCell";
    }
   return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return  K_DJWeatherHeaderHeight;
    }
    return K_DJWeatherCellHeight;
}
// 获取滚动前的Offest
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _originOffest = scrollView.contentOffset;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset_y = scrollView.contentOffset.y;
    [self dealWithOffset:offset_y];
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self scrollOffest:scrollView.contentOffset.y scrollView:scrollView];
}
//根据偏移量滚动到相应的位置
- (void)scrollOffest:(CGFloat)offset_y scrollView:(UIScrollView *)scrollView{
    
    CGFloat min_offest = K_DJWeatherHeaderHeight + K_DJWeatherCellHeight - K_ScreenHeight;
    NSLog(@"%f",offset_y - _originOffest.y);

    if (offset_y > _originOffest.y) {// 上移
        NSLog(@"%f 上移",offset_y - _originOffest.y);
        if (min_offest> offset_y) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }

    }else{ // 下移
        if (min_offest> offset_y) {
          [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        NSLog(@"%f 下移",offset_y - _originOffest.y);


    }
//    if (offset_y > 0 && offset_y < (K_ScreenHeight/2 - 64)) {
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }else if((K_ScreenHeight/2 - 64)<offset_y && offset_y > K_ScreenHeight*0.75 - 64){
//   //    }

}
- (void)dealWithOffset:(CGFloat)offset_y{
//    NSLog(@"scrollView.contentOffset.y %f",scrollView.contentOffset.y);
    CGFloat max_cellWidth = K_ScreenWidth/2.;
    CGFloat min_cellWidth = K_ScreenWidth/7.;
    CGFloat width = max_cellWidth - offset_y;
    if (offset_y == 0) {
        width =  max_cellWidth;
    }
    else if ((min_cellWidth<= width) &&  (width<= max_cellWidth)) {
        width = width;
    }
    else if (min_cellWidth > width) {
        width = min_cellWidth;
    }
    else if (max_cellWidth < width) {
        width = max_cellWidth;
    }
    
    [self reloadCollectionView:width];

}
- (void)reloadCollectionView:(CGFloat)width{
    DJWeatherCell *cell = (DJWeatherCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.width_cell = width;
}
#pragma mark 曲线列表的代理
- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}

@end
