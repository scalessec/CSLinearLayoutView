//
//  CSLinearLayoutItem.h
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CSLinearLayoutItemContentModeNormal, 
    CSLinearLayoutItemContentModeFill    
} CSLinearLayoutItemContentMode;

typedef enum {
    CSLinearLayoutItemGravityLeft,      
    CSLinearLayoutItemGravityRight,   
    CSLinearLayoutItemGravityCenterVertical,
    CSLinearLayoutItemGravityCenterHorizontal,
    CSLinearLayoutItemGravityTop,
    CSLinearLayoutItemGravityBottom
} CSLinearLayoutItemGravity;

@interface CSLinearLayoutItem : NSObject

@property (nonatomic, retain) UIView *view;
@property (nonatomic, assign) CSLinearLayoutItemContentMode contentMode;
@property (nonatomic, assign) CSLinearLayoutItemGravity gravity;
@property (nonatomic, assign) CGFloat weight;
@property (nonatomic, assign) UIEdgeInsets padding;
@property (nonatomic, assign) NSDictionary *userInfo;
@property (nonatomic, assign) NSInteger tag;

- (id)initWithView:(UIView *)aView;

@end
