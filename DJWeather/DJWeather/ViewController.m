//
//  ViewController.m
//  DJWeather
//
//  Created by hdj on 16/10/12.
//  Copyright © 2016年 DJ_H. All rights reserved.
//

#import "ViewController.h"
#import "DJWeatherController.h"
@interface ViewController ()

- (IBAction)pushToweather:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pushToweather:(id)sender {
    [self.navigationController pushViewController:[DJWeatherController new] animated:YES];
}
@end
