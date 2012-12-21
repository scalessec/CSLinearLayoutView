//
//  UIView+LoadFromNib.h
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 2/10/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LoadFromNib)

+ (UIView *)loadFromNib:(NSString *)nibName owner:(id)owner;
+ (UIView *)loadFromNib:(NSString *)nibName owner:(id)owner options:(NSDictionary *)options;

@end
