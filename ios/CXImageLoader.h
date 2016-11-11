//
//  CXImageLoader.h
//  gestureUnlock
//
//  Created by Alex Chan on 2016/10/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXImageLoader : NSObject

+ (UIImage *)loadImage:(NSString *)name;
+ (UIImage *)resizeImage:(UIImage *)originImg frame:(CGRect)frame;

@end
