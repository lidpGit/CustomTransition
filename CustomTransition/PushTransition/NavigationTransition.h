//
//  NavigationTransition.h
//  CustomTransition
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NavigationTransitionType) {
    NavigationTransitionTypePush,
    NavigationTransitionTypePop
};

@interface NavigationTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (NavigationTransition *)transtionType:(NavigationTransitionType)type;

- (instancetype)initWithTranstionType:(NavigationTransitionType)type;

@end
