//
//  DPInteracriveTransition.m
//  CustomTransition
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import "DPInteractiveTransition.h"

@implementation DPInteractiveTransition{
    __weak UIViewController                             *_viewController;
    __weak id<UIViewControllerContextTransitioning>     _transitionContext;
    
    DPInteractiveTransitionType         _type;
    DPInteractiveTransitionDirection    _direction;
}

+ (DPInteractiveTransition *)interactiveTransitionType:(DPInteractiveTransitionType)type direction:(DPInteractiveTransitionDirection)direction{
    return [[DPInteractiveTransition alloc] initWithInteractiveTransitionType:type direction:direction];
}

- (instancetype)initWithInteractiveTransitionType:(DPInteractiveTransitionType)type direction:(DPInteractiveTransitionDirection)direction{
    if (self = [super init]) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPanGestureFromViewController:(UIViewController *)viewController{
    _viewController = viewController;
    [_viewController.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)]];
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    [super startInteractiveTransition:transitionContext];
    _transitionContext = transitionContext;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)sender{
    CGFloat percent = 0;
    switch (_direction) {
        case DPInteractiveTransitionDirectionLeft:
        {
            CGFloat translationY = -[sender translationInView:sender.view].x;
            percent = translationY / sender.view.frame.size.width;
        }
            break;
        case DPInteractiveTransitionDirectionRight:
        {
            CGFloat translationY = [sender translationInView:sender.view].x;
            percent = translationY / sender.view.frame.size.width;
        }
            break;
        case DPInteractiveTransitionDirectionTop:
        {
            UIView *toView = [_transitionContext viewForKey:UITransitionContextToViewKey];
            CGFloat translationY = -[sender translationInView:sender.view].y;
            percent = translationY / toView.frame.size.height;
        }
            break;
        case DPInteractiveTransitionDirectionDown:
        {
            CGFloat translationY = [sender translationInView:sender.view].y;
            percent = translationY / sender.view.frame.size.height;
        }
            break;
        default:
            break;
    }
    
    //大于等于1时，置为0.99，避免完成过渡会回弹一次
    percent = percent >= 1 ? 0.99 : percent;
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _beganInteration = YES;
            [self startTranslition:percent];
            break;
        case UIGestureRecognizerStateChanged:
            if (percent > 0) {
                [self updateInteractiveTransition:percent];
            }
            break;
        case UIGestureRecognizerStateEnded:
            _beganInteration = NO;
            if (percent >= 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        case UIGestureRecognizerStateCancelled:
            _beganInteration = NO;
            [self cancelInteractiveTransition];
            break;
        default:
            break;
    }
}

- (void)startTranslition:(CGFloat)percent{
    if (percent <= 0) {
        return;
    }
    switch (_type) {
        case DPInteractiveTransitionTypePresent:
            !_startPresentCallback ?: _startPresentCallback();
            break;
        case DPInteractiveTransitionTypeDismiss:
            [_viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        case DPInteractiveTransitionTypePush:
            !_startPushCallback ?: _startPushCallback();
            break;
        case DPInteractiveTransitionTypePop:
            if ([_viewController isKindOfClass:[UINavigationController class]]) {
                [(UINavigationController *)_viewController popViewControllerAnimated:YES];
            }else{
                [_viewController.navigationController popViewControllerAnimated:YES];
            }
            break;
        default:
            break;
    }
}

@end
