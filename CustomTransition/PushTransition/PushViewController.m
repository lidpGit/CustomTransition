//
//  PushViewController.m
//  CustomTransition
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import "PushViewController.h"
#import "PopViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"test"];
    
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.frame = CGRectMake(20, 80, image.size.width / 1.5, image.size.height / 1.5);
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)]];
    [self.view addSubview:_imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tapImageView{
    PopViewController *popVC = [[PopViewController alloc] init];
    self.navigationController.delegate = popVC;
    [self.navigationController pushViewController:popVC animated:YES];
}

@end
