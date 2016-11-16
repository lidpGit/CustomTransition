//
//  NavigationTransition.m
//  CustomTransition
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import "NavigationTransition.h"
#import "PushViewController.h"
#import "PopViewController.h"

static CGFloat const animationDuration = 0.5;

@implementation NavigationTransition{
    NavigationTransitionType    _type;
}

+ (NavigationTransition *)transtionType:(NavigationTransitionType)type{
    return [[NavigationTransition alloc] initWithTranstionType:type];
}

- (instancetype)initWithTranstionType:(NavigationTransitionType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return animationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    (_type == NavigationTransitionTypePush ? [self pushAnimateTransition:transitionContext] : [self popAnimateTransition:transitionContext]);
}

- (void)pushAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    
    PushViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.imageView.hidden = YES;
    
    PopViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.imageView.hidden = YES;
    toVC.view.backgroundColor = [UIColor clearColor];
    [containerView addSubview:toVC.view];
    
    UIImageView *fromImageView = [[UIImageView alloc] initWithImage:fromVC.imageView.image];
    fromImageView.frame = [fromVC.imageView convertRect:fromVC.imageView.bounds toView:containerView];
    [containerView addSubview:fromImageView];
    
    [UIView animateWithDuration:animationDuration animations:^{
        fromImageView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        toVC.view.backgroundColor = [UIColor orangeColor];
    } completion:^(BOOL finished) {
        [fromImageView removeFromSuperview];
        toVC.imageView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
}

- (void)popAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    
    PushViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [containerView addSubview:toVC.view];
    
    PopViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.imageView.hidden = YES;
    [containerView addSubview:fromVC.view];
    
    UIImageView *fromImageView = [[UIImageView alloc] initWithImage:fromVC.imageView.image];
    fromImageView.frame = [fromVC.imageView convertRect:fromVC.imageView.bounds toView:containerView];
    [containerView addSubview:fromImageView];
    
    [UIView animateWithDuration:animationDuration animations:^{
        fromImageView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        fromVC.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            fromVC.imageView.hidden = NO;
            fromVC.view.backgroundColor = [UIColor orangeColor];
        }else{
            [fromImageView removeFromSuperview];
            toVC.imageView.hidden = NO;
            [transitionContext completeTransition:YES];
        }
    }];
}

@end
