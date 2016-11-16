//
//  ModelTransitionAnimate.m
//  CustomTransition
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import "ModalTransition.h"

static CGFloat const animationDuration = 0.3;

@implementation ModalTransition{
    ModalTransitionType _type;
}

+ (ModalTransition *)transitionType:(ModalTransitionType)type{
    return [[ModalTransition alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(ModalTransitionType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return animationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    (_type == ModalTransitionTypePresent ? [self presentAnimateTransition:transitionContext] : [self dismissAnimateTransition:transitionContext]);
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *snapshotView = [[UIImageView alloc] initWithImage:[self imageFromView:fromView]];
    snapshotView.frame = fromView.frame;
    snapshotView.tag = 101;
    [containerView addSubview:snapshotView];
    fromView.hidden = YES;
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    __block CGRect frame = toView.frame;
    frame.origin.y = containerView.frame.size.height;
    frame.size.height = 400;
    toView.frame = frame;
    
    [UIView animateWithDuration:animationDuration animations:^{
        snapshotView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        
        frame.origin.y = containerView.frame.size.height - frame.size.height;
        toView.frame = frame;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            fromView.hidden = NO;
            [snapshotView removeFromSuperview];
        }else{
            [transitionContext completeTransition:YES];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        }
    }];
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [containerView addSubview:fromView];
    
    UIView *snapshotView = [containerView viewWithTag:101];
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect frame = fromView.frame;
        frame.origin.y = containerView.frame.size.height;
        fromView.frame = frame;
        
        snapshotView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
            [transitionContext completeTransition:YES];
            toView.hidden = NO;
            [snapshotView removeFromSuperview];
        }
    }];
}

- (UIImage *)imageFromView:(UIView *)snapView {
    UIGraphicsBeginImageContextWithOptions(snapView.frame.size, YES, 0.0);
    [snapView drawViewHierarchyInRect:CGRectMake(0, 0, snapView.frame.size.width, snapView.frame.size.height) afterScreenUpdates:NO];
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}

@end
