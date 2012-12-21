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

@interface CSLinearLayoutView : UIScrollView

@property (nonatomic, readonly) NSMutableArray *items;
@property (nonatomic, assign) CSLinearLayoutViewOrientation orientation;
@property (nonatomic, readonly) CGFloat layoutOffset;       // Iterates through the existing layout items and returns the current offset.
@property (nonatomic, assign) BOOL autoAdjustFrameSize;     // Updates the frame size as items are added/removed. Default is NO.
@property (nonatomic, assign) BOOL autoAdjustContentSize;   // Updates the contentView as items are added/removed. Default is YES.

- (void)addItem:(CSLinearLayoutItem *)linearLayoutItem;
- (void)removeItem:(CSLinearLayoutItem *)linearLayoutItem;
- (void)removeAllItems;

- (void)insertItem:(CSLinearLayoutItem *)newItem beforeItem:(CSLinearLayoutItem *)existingItem;
- (void)insertItem:(CSLinearLayoutItem *)newItem afterItem:(CSLinearLayoutItem *)existingItem;
- (void)insertItem:(CSLinearLayoutItem *)newItem atIndex:(NSUInteger)index;

- (void)moveItem:(CSLinearLayoutItem *)movingItem beforeItem:(CSLinearLayoutItem *)existingItem;
- (void)moveItem:(CSLinearLayoutItem *)movingItem afterItem:(CSLinearLayoutItem *)existingItem;
- (void)moveItem:(CSLinearLayoutItem *)movingItem toIndex:(NSUInteger)index;

- (void)swapItem:(CSLinearLayoutItem *)firstItem withItem:(CSLinearLayoutItem *)secondItem;

@end
