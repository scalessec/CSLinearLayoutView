//
//  UIColor+RandomColor.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/25/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+ (UIColor *)randomColor {
    CGFloat r = ((CGFloat)(arc4random() % 255))/255.0;
    CGFloat g = ((CGFloat)(arc4random() % 255))/255.0;
    CGFloat b = ((CGFloat)(arc4random() % 255))/255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

@end
