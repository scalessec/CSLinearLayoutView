//
//  CSLinearLayoutView.h
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

/*
 *      Example Usage:
 *
 *      // create the linear layout view
 *      CSLinearLayoutView *linearLayoutView = [[[CSLinearLayoutView alloc] initWithFrame:self.view.bounds] autorelease];
 *      linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
 *      [self.view addSubview:linearLayoutView];
 *
 *      // create a layout item for the view you want to display
 *      CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:someView];
 *      item.padding = CSLinearLayoutMakePadding(5.0, 10.0, 5.0, 10.0);
 *      item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
 *      item.fillMode = CSLinearLayoutItemFillModeNormal;
 *
 *      // add the layout item to the linear layout view
 *      [linearLayoutView addItem:item];
 *
 */

#import <UIKit/UIKit.h>

@class CSLinearLayoutItem;

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


typedef enum {
    CSLinearLayoutItemFillModeNormal,   // Respects the view's frame size
    CSLinearLayoutItemFillModeStretch   // Adjusts the frame to fill the linear layout view
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
@property (nonatomic, assign) CSLinearLayoutItemHorizontalAlignment horizontalAlignment;    // Use horizontalAlignment when the layout view is set to VERTICAL orientation
@property (nonatomic, assign) CSLinearLayoutItemVerticalAlignment verticalAlignment;        // Use verticalAlignment when the layout view is set to HORIZONTAL orientation
@property (nonatomic, assign) CSLinearLayoutItemPadding padding;
@property (nonatomic, assign) NSDictionary *userInfo;
@property (nonatomic, assign) NSInteger tag;

- (id)initWithView:(UIView *)aView;
+ (CSLinearLayoutItem *)layoutItemForView:(UIView *)aView;

CSLinearLayoutItemPadding CSLinearLayoutMakePadding(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

@end