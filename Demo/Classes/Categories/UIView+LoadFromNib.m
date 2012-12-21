//
//  UIView+LoadFromNib.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 2/10/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "UIView+LoadFromNib.h"

@implementation UIView (LoadFromNib)

+ (UIView *)loadFromNib:(NSString *)nibName owner:(id)owner {
    return [UIView loadFromNib:nibName owner:owner options:nil];
}

+ (UIView *)loadFromNib:(NSString *)nibName owner:(id)owner options:(NSDictionary *)options {
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
	NSArray *nibArray = [nib instantiateWithOwner:owner options:nil];
    UIView *view = nil;
    if(nibArray && nibArray.count > 0) {
        view = [nibArray objectAtIndex:0];
    }
	return view;
}

@end
