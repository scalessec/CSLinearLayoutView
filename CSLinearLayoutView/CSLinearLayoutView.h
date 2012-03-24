//
//  CSLinearLayoutView.h
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLinearLayoutItem.h"

typedef enum {
    CSLinearLayoutViewOrientationVertical,
    CSLinearLayoutViewOrientationHorizontal
} CSLinearLayoutViewOrientation;

@interface CSLinearLayoutView : UIView

@property (nonatomic, readonly) NSMutableArray *items;
@property (nonatomic, assign) CSLinearLayoutViewOrientation orientation;
@property (nonatomic, assign) UIEdgeInsets *padding;

- (void)addItem:(CSLinearLayoutItem *)linearLayoutItem;
- (void)removeItem:(CSLinearLayoutItem *)linearLayoutItem;

- (void)insertItem:(CSLinearLayoutItem *)newItem beforeItem:(CSLinearLayoutItem *)existingItem;
- (void)insertItem:(CSLinearLayoutItem *)newItem afterItem:(CSLinearLayoutItem *)existingItem;

- (void)moveItem:(CSLinearLayoutItem *)movingItem beforeItem:(CSLinearLayoutItem *)existingItem;
- (void)moveItem:(CSLinearLayoutItem *)movingItem afterItem:(CSLinearLayoutItem *)existingItem;

@end
