//
//  ModelTransitionAnimate.h
//  CustomTransition
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ModalTransitionType) {
    ModalTransitionTypePresent,
    ModalTransitionTypeDismiss
};

@interface ModalTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (ModalTransition *)transitionType:(ModalTransitionType)type;

- (instancetype)initWithTransitionType:(ModalTransitionType)type;

@end
