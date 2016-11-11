//
//  RNGestureView.h
//  RNGestureView
//
//  Created by Alex Chan on 2016/10/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTComponent.h"

@class RNGestureView;

@protocol RNGestureViewDelegate <NSObject>

- (void)gestureView:(RNGestureView *)view finished:(NSString *)result;

@end


@interface RNGestureView : UIView

@property (nonatomic, weak) id<RNGestureViewDelegate> delegate;
//params from js
@property (nonatomic, copy) RCTBubblingEventBlock onComplete;

@property (nonatomic, assign) CGFloat nodeScale;
@property (nonatomic, assign) int colCount;
@property (nonatomic, copy) NSString *backgroundImgName;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, copy) NSString *nodeNormalImgName;
@property (nonatomic, copy) NSString *nodeSelectedImgName;
@property (nonatomic, copy) NSString *nodeErrorImgName;

//TODO: 样式图片可配置
@end
