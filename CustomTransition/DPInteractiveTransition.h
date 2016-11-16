//
//  DPInteractiveTransition.h
//  CustomTransition
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, DPInteractiveTransitionType) {
    DPInteractiveTransitionTypePresent = 0,
    DPInteractiveTransitionTypeDismiss,
    DPInteractiveTransitionTypePush,
    DPInteractiveTransitionTypePop
};

typedef NS_ENUM(NSInteger, DPInteractiveTransitionDirection) {
    DPInteractiveTransitionDirectionLeft = 0,
    DPInteractiveTransitionDirectionRight,
    DPInteractiveTransitionDirectionTop,
    DPInteractiveTransitionDirectionDown
};

@interface DPInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (copy, nonatomic  ) void (^startPresentCallback)();
@property (copy, nonatomic  ) void (^startPushCallback)();
@property (assign, nonatomic) BOOL beganInteration;

+ (DPInteractiveTransition *)interactiveTransitionType:(DPInteractiveTransitionType)type
                                             direction:(DPInteractiveTransitionDirection)direction;

- (instancetype)initWithInteractiveTransitionType:(DPInteractiveTransitionType)type
                                        direction:(DPInteractiveTransitionDirection)direction;

- (void)addPanGestureFromViewController:(UIViewController *)viewController;

@end
