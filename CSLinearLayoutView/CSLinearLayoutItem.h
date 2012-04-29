//
//  CSLinearLayoutItem.h
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CSLinearLayoutItemFillModeNormal, 
    CSLinearLayoutItemFillModeStretch   
} CSLinearLayoutItemFillMode;

typedef enum {
    CSLinearLayoutItemHorizontalAlignmentLeft,      
    CSLinearLayoutItemHorizontalAlignmentRight,   
    CSLinearLayoutItemHorizontalAlignmentCenter
} CSLinearLayoutItemHorizontalAlignment;

typedef enum {
    CSLinearLayoutItemVerticalAlignmentTop,      
    CSLinearLayoutItemVerticalAlignmentBottom,   
    CSLinearLayoutItemVerticalAlignmentCenter
} CSLinearLayoutItemVerticalAlignment;

typedef struct {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
} CSLinearLayoutItemPadding;

@interface CSLinearLayoutItem : NSObject

@property (nonatomic, retain) UIView *view;
@property (nonatomic, assign) CSLinearLayoutItemFillMode fillMode;
@property (nonatomic, assign) CSLinearLayoutItemHorizontalAlignment horizontalAlignment;
@property (nonatomic, assign) CSLinearLayoutItemVerticalAlignment verticalAlignment;
@property (nonatomic, assign) CSLinearLayoutItemPadding padding;
@property (nonatomic, assign) NSDictionary *userInfo;
@property (nonatomic, assign) NSInteger tag;

- (id)initWithView:(UIView *)aView;
+ (CSLinearLayoutItem *)layoutItemForView:(UIView *)aView;

CSLinearLayoutItemPadding CSLinearLayoutMakePadding(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

@end
