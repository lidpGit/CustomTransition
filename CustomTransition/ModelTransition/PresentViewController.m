//
//  PresentViewController.m
//  CustomTransition
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import "PresentViewController.h"
#import "DismissViewController.h"
#import "ModalTransition.h"
#import "DPInteractiveTransition.h"

@interface PresentViewController ()<UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) DPInteractiveTransition *interactivePresent;
@property (strong, nonatomic) DPInteractiveTransition *interactiveDismiss;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"present" style:UIBarButtonItemStylePlain target:self action:@selector(presentAction)];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.text = @"向上拖动开始转场";
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
    
    _interactivePresent = [DPInteractiveTransition interactiveTransitionType:DPInteractiveTransitionTypePresent direction:DPInteractiveTransitionDirectionTop];
    [_interactivePresent addPanGestureFromViewController:self.navigationController];
    __weak typeof(self) weakSelf = self;
    _interactivePresent.startPresentCallback = ^() {
        [weakSelf presentAction];
    };
}

- (DPInteractiveTransition *)interactiveDismiss{
    if (!_interactiveDismiss) {
        _interactiveDismiss = [DPInteractiveTransition interactiveTransitionType:DPInteractiveTransitionTypeDismiss direction:DPInteractiveTransitionDirectionDown];
    }
    return _interactiveDismiss;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)presentAction{
    DismissViewController *dismissVC = [[DismissViewController alloc] init];
    dismissVC.transitioningDelegate = self;
    [self.interactiveDismiss addPanGestureFromViewController:dismissVC];
    [self presentViewController:dismissVC animated:YES completion:nil];
}

#pragma mark - ---------------------- delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [ModalTransition transitionType:ModalTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [ModalTransition transitionType:ModalTransitionTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactivePresent.beganInteration ? self.interactivePresent : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveDismiss.beganInteration ? _interactiveDismiss : nil;
}

@end
