//
//  DismissViewController.m
//  CustomTransition
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import "DismissViewController.h"

@interface DismissViewController ()

@end

@implementation DismissViewController

- (void)dealloc{
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBtn.frame = CGRectMake(0, 0, 100, 50);
    dismissBtn.center = self.view.center;
    [dismissBtn setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismissBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dismissAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
