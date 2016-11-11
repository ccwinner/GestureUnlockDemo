//
//  GestureUnclockManager.m
//  gestureUnlock
//
//  Created by Alex Chan on 2016/10/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RNGestureViewManager.h"
#import "RCTBridge.h"
#import "RNGestureView.h"
#import "UIView+React.h"

@interface RNGestureViewManager ()<RNGestureViewDelegate>

@property (nonatomic, strong) RNGestureView *innerView;

@end

@implementation RNGestureViewManager

//export modules methods and properties
RCT_EXPORT_MODULE() //default name is RNGesutreView

RCT_EXPORT_VIEW_PROPERTY(onComplete, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(nodeScale, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(colCount, int)
RCT_EXPORT_VIEW_PROPERTY(backgroundImgName, NSString)
RCT_EXPORT_METHOD(setupNodeUI:(NSDictionary *)params) {
  NSString *nodeNormalImg = params[@"nodeNormal"];
  NSString *nodeErrorImg = params[@"nodeError"];
  NSString *nodeSelectImg = params[@"nodeSelect"];
  self.innerView.nodeErrorImgName = nodeErrorImg;
  self.innerView.nodeNormalImgName = nodeNormalImg;
  self.innerView.nodeSelectedImgName = nodeSelectImg;
}

- (UIView *)view {
  RNGestureView *gestureV = self.innerView;
  gestureV.delegate = self;
  return gestureV;
}

#pragma mark - CXGestureViewDelegate
- (void)gestureView:(RNGestureView *)view finished:(NSString *)result {
  if (!view.onComplete) {
    return;
  }
  view.onComplete(@{
                    @"completion" : result
                    });
}

#pragma mark - getter
- (RNGestureView *)innerView {
  if (!_innerView) {
    _innerView = [RNGestureView new];
  }
  return _innerView;
}
@end
