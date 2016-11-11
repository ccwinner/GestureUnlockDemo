//
//  GestureView.m
//  gestureUnlock
//
//  Created by Alex Chan on 2016/10/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RNGestureView.h"
#import "CXImageLoader.h"

#define kButtonCount 9
const CGFloat kNodeScale = 74.f;
const int kColCount = 3;

@interface RNGestureView ()

@property (nonatomic, strong) NSMutableArray* btns;
@property (nonatomic, strong) NSMutableArray* lineBtns;
@property (nonatomic, assign) CGPoint currentPoint;
//params from js

@end

@implementation RNGestureView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _nodeSelectedImgName = @"gesture_node_highlighted";
    _nodeErrorImgName = @"gesture_node_error";
    _nodeNormalImgName = @"gesture_node_normal";
  }
  return self;
}

- (NSMutableArray*)lineBtns
{
  if (!_lineBtns) {
    _lineBtns = [NSMutableArray array];
  }
  return _lineBtns;
}

- (NSMutableArray*)btns
{
  if (!_btns) {
    _btns = [NSMutableArray array];
    
    for (int i = 0; i < kButtonCount; ++i) {
      UIButton* btn = [[UIButton alloc] init];
      btn.tag = i;
      [btn setUserInteractionEnabled:NO];
      [btn setBackgroundImage:[CXImageLoader loadImage:_nodeNormalImgName] forState:UIControlStateNormal];
      [btn setBackgroundImage:[CXImageLoader loadImage:_nodeSelectedImgName] forState:UIControlStateSelected];
      [btn setBackgroundImage:[CXImageLoader loadImage:_nodeErrorImgName] forState:UIControlStateDisabled];
      [self addSubview:btn];
      [self.btns addObject:btn];
    }
  }
  return _btns;
}

#pragma mark - setter
- (void)setNodeErrorImgName:(NSString *)nodeErrorImgName {
  _nodeErrorImgName = nodeErrorImgName ? nodeErrorImgName : @"gesture_node_error";
}

- (void)setNodeSelectedImgName:(NSString *)nodeSelectedImgName {
     _nodeSelectedImgName = nodeSelectedImgName ? nodeSelectedImgName : @"gesture_node_highlighted";
}

- (void)setNodeNormalImgName:(NSString *)nodeNormalImgName {
     _nodeNormalImgName = nodeNormalImgName ? nodeNormalImgName : @"gesture_node_normal";
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
  
  UITouch* t = touches.anyObject;
  CGPoint p = [t locationInView:t.view];
  
  for (int i = 0; i < self.btns.count; ++i) {
    UIButton* btn = self.btns[i];
    if (CGRectContainsPoint(btn.frame, p)) {
      btn.selected = YES;
      [self.lineBtns addObject:btn];
    }
  }
}

- (void)touchesMoved:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
  
  UITouch* t = touches.anyObject;
  CGPoint p = [t locationInView:t.view];
  
  self.currentPoint = p;
  for (int i = 0; i < self.btns.count; ++i) {
    
    UIButton* btn = self.btns[i];
    if (CGRectContainsPoint(btn.frame, p)) {
      btn.selected = YES;
      if (![self.lineBtns containsObject:btn]) {
        [self.lineBtns addObject:btn];
      }
    }
  }
  
  [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
  self.currentPoint = [[self.lineBtns lastObject] center];
  [self setNeedsDisplay];
  
  for (int i = 0; i < self.lineBtns.count; ++i) {
    
    UIButton* btn = self.lineBtns[i];
    btn.selected = NO;
    btn.enabled = NO;
  }
  
  
  NSString* password = @"";
  for (int i = 0; i < self.lineBtns.count; ++i) {
    
    UIButton* btn = self.lineBtns[i];
    password = [password stringByAppendingString:[NSString stringWithFormat:@"%ld", btn.tag]];
  }
  if ([self.delegate respondsToSelector:@selector(gestureView:finished:)]) {
    [self.delegate gestureView:self finished:password];
  }
  
  [self setUserInteractionEnabled:NO];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),   dispatch_get_main_queue(), ^{
    [self setUserInteractionEnabled:YES];
    [self clear];
  });
}

- (void)clear {
  for (int i = 0; i < self.btns.count; ++i) {
    UIButton* btn = self.btns[i];
    btn.selected = NO;
    btn.enabled = YES;
  }
  
  [self.lineBtns removeAllObjects];
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
  
  if (!self.lineBtns.count) {
    return;
  }
  
  UIBezierPath* path = [UIBezierPath bezierPath];
  
  for (int i = 0; i < self.lineBtns.count; ++i) {
    UIButton* btn = self.lineBtns[i];
    if (i == 0) {
      [path moveToPoint:btn.center];
    }
    else {
      [path addLineToPoint:btn.center];
    }
  }
  [path addLineToPoint:self.currentPoint];
  [[UIColor whiteColor] set];
  
  [path setLineWidth:10];
  [path setLineJoinStyle:kCGLineJoinRound];
  [path setLineCapStyle:kCGLineCapRound];
  [path stroke];
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  CGFloat w = _nodeScale == 0 ? kNodeScale : _nodeScale;
  CGFloat h = w;
  int colCount = _colCount == 0 ? kColCount : _colCount;
  CGFloat marginX = (self.frame.size.width - colCount * w) / (colCount + 1);
  CGFloat marginY = (self.frame.size.height - colCount * h) / (colCount + 1);
  for (int i = 0; i < self.btns.count; i++) {
    CGFloat x = (i % colCount) * (marginX + w) + marginX;
    CGFloat y = (i / colCount) * (marginY + w) + marginY;
    [self.btns[i] setFrame:CGRectMake(x, y, w, h)];
  }
  self.backgroundColor = [UIColor colorWithPatternImage:[CXImageLoader loadImage:_backgroundImgName]];
}

@end
