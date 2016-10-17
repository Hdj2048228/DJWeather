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
#import "UIImage+ImageEffects.h"
#import "UIImageView+LBBlurredImage.h"
#import "DJDefines.h"
#import "HYBNetworking.h"
#import "TQTWeather.h"
//static CGFloat DJWeatherCelllWith = 320./2.;
static NSString *K_DJWeatherCell = @"DJWeatherCell";
static NSString *K_DJWeatherTableViewBgImageName = @"leiyu_bg.jpg";

@interface DJWeatherController()<UIScrollViewDelegate>
{
    UIImage *_backImage;
}

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)CGPoint originOffest;
@property (nonatomic,strong)UIImageView *tableBgView;

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
- (void)xmlrequset{
     NSString *urlStr = @"http://forecast.sina.cn/app/update.php?device=iPhone&lang=zh-Hans&pv=5.159&ts=1476340757.127181&sv=9.330&device_id=b14651ac998f9f0fadcab1839505c987016b2cd6&weibo_aid=01AouStxR4NvMqzM0sLoAD6JItzl_v1MS7Z3MnzyNXYBCuEOQ.&city=CHXX0008&resolution=750%2A1334&conn=1&tqt_userid=164294148&sign=3c3e3098e9fa86783702444e62240d07&uid=3f89595eeaa2b060e0295489b118cf757a2a4dd9&carrier=0&timezone=GMT%2B8&pid=free&api_key=517276d5c1d3c&pt=3010&pd=tq&idfa=5A998AE0-3394-4CF8-87C1-CC1D857ED034";
    NSURL *url = [NSURL URLWithString:urlStr];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *xmlString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
       NSDictionary *dic = [NSDictionary  dictionaryWithXMLString:xmlString];
        NSLog(@"dic %@",dic);
        TQTWeather *weather = [TQTWeather mj_objectWithKeyValues:dic];
        NSLog(@"%@",weather.mj_keyValues);
    });
//    [HYBNetworking configRequestType:kHYBRequestTypeJSON responseType:kHYBResponseTypeData shouldAutoEncodeUrl:YES callbackOnCancelRequest:NO];
//   
//   ;
//    [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
//        NSError *error = nil;
//      GDataXMLDocument *docment =  [[GDataXMLDocument alloc]initWithData:response options:0 error:&error];
//        id obj = [docment rootElement];
//        
//        NSLog(@"%@",obj);
//    } fail:^(NSError *error) {
//        NSLog(@"error %@",error.description);
//    }];
   
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self xmlrequset];
    [self.tableView registerClass:[DJWeatherCell class] forCellReuseIdentifier:K_DJWeatherCell];
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.rowHeight = K_ScreenWidth/2;
    _backImage  = [UIImage imageNamed:K_DJWeatherTableViewBgImageName];
    UIImageView *backView = [[UIImageView alloc]initWithImage:_backImage];
//    self.tableView.backgroundColor = [UIColor clearColor];
    [backView setImageToBlur:_backImage blurRadius:0 completionBlock:^{
    }];
    self.tableBgView = backView;
    
    [self.tableView setBackgroundView:backView];
    
    
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
    cell.backgroundColor = [UIColor clearColor];
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

    if (offset_y > _originOffest.y) {// 上移
        NSLog(@"%f 上移",offset_y - _originOffest.y);
        if (min_offest > offset_y) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
         [self.tableBgView setImageToBlur:[UIImage imageNamed:K_DJWeatherTableViewBgImageName] blurRadius:30 completionBlock:^{
             
            }];

        }else{
            [self.tableBgView setImageToBlur:[UIImage imageNamed:K_DJWeatherTableViewBgImageName] blurRadius:30 completionBlock:^{
            }];

        }

    }else{ // 下移
        if (min_offest> offset_y) {
          [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [self.tableBgView setImageToBlur:[UIImage imageNamed:K_DJWeatherTableViewBgImageName] blurRadius:0. completionBlock:^{
               
            }];
        }else{
            [self.tableBgView setImageToBlur:[UIImage imageNamed:K_DJWeatherTableViewBgImageName] blurRadius:30. completionBlock:^{
              
            }];
        }
        NSLog(@"%f 下移",offset_y - _originOffest.y);


    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
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

@end
