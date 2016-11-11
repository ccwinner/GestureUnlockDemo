//
//  CXImageLoader.m
//  gestureUnlock
//
//  Created by Alex Chan on 2016/10/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "CXImageLoader.h"

@implementation CXImageLoader

+ (UIImage *)loadImage:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:self];
    NSString *bundlePath = [bundle pathForResource:@"resources" ofType:@"bundle"];
    return [UIImage imageNamed:[bundlePath stringByAppendingPathComponent:name]];
}

+ (UIImage *)resizeImage:(UIImage *)originImg frame:(CGRect)frame {
  UIGraphicsBeginImageContext(frame.size);
  [originImg drawInRect:frame];
  UIImage *resImg = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return resImg;
}
@end
