//
//  PopViewController.m
//  CustomTransition
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import "PopViewController.h"
#import "NavigationTransition.h"
#import "DPInteractiveTransition.h"

@interface PopViewController ()

@property (strong, nonatomic) DPInteractiveTransition *interactivePop;

@end

@implementation PopViewController

- (void)dealloc{
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"右滑可返回";
    
    UIImage *image = [UIImage imageNamed:@"test"];
    
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.frame = CGRectMake(0, 0, image.size.width / 1.2, image.size.height / 1.2);
    _imageView.center = self.view.center;
    [self.view addSubview:_imageView];
    
    _interactivePop = [DPInteractiveTransition interactiveTransitionType:DPInteractiveTransitionTypePop direction:DPInteractiveTransitionDirectionRight];
    [_interactivePop addPanGestureFromViewController:self.navigationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ---------------------- delegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC{
    return [NavigationTransition transtionType:operation == UINavigationControllerOperationPush ? NavigationTransitionTypePush : NavigationTransitionTypePop];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return _interactivePop.beganInteration ? _interactivePop : nil;
}

@end
