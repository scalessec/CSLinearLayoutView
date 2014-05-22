//
//  CSLinearLayoutView.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2013 Charles Scalesse. All rights reserved.
//

#import "CSLinearLayoutView.h"

@interface CSLinearLayoutView()
- (void)setup;
- (void)adjustFrameSize;
- (void)adjustContentSize;
@end

@implementation CSLinearLayoutView

#pragma mark - Factories

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _items = [[NSMutableArray alloc] init];
    _orientation = CSLinearLayoutViewOrientationVertical;
    _autoAdjustFrameSize = NO;
    _autoAdjustContentSize = YES;
    _equallySpaceItems = NO;
    self.autoresizesSubviews = NO;
}


#pragma mark - Layout

- (void)layoutSubviews {
    
    CGFloat relativePosition = 0.0;
    CGFloat absolutePosition = 0.0;
    
    CGFloat equalSpace = 0.0;
    if( _equallySpaceItems ) {
        CGFloat totalSize = 0.0;
        for (CSLinearLayoutItem *item in _items) {
            if( self.orientation == CSLinearLayoutViewOrientationHorizontal )
                totalSize += item.view.frame.size.width;
            else
                totalSize += item.view.frame.size.height;
        }
        
        if( self.orientation == CSLinearLayoutViewOrientationHorizontal && totalSize < self.bounds.size.width )
        {
            equalSpace = (self.bounds.size.width - totalSize) / (_items.count + 1);
        }
        else if( self.orientation == CSLinearLayoutViewOrientationVertical && totalSize < self.bounds.size.height )
        {
            equalSpace = (self.bounds.size.height - totalSize) / (_items.count + 1);
        }
    }
    
    for (CSLinearLayoutItem *item in _items) {
        
        CGFloat startPadding = 0.0;
        CGFloat endPadding = 0.0;
        
        if (self.orientation == CSLinearLayoutViewOrientationHorizontal) {
            
            startPadding = item.padding.left;
            endPadding = item.padding.right;
            
            if (item.verticalAlignment == CSLinearLayoutItemVerticalAlignmentTop || item.fillMode == CSLinearLayoutItemFillModeStretch) {
                absolutePosition = item.padding.top;
            } else if (item.verticalAlignment == CSLinearLayoutItemVerticalAlignmentBottom) {
                absolutePosition = self.frame.size.height - item.view.frame.size.height - item.padding.bottom;
            } else { // CSLinearLayoutItemVerticalCenter
                absolutePosition = (self.frame.size.height / 2) - ((item.view.frame.size.height + (item.padding.bottom - item.padding.top)) / 2);
            }
            
        } else {
            
            startPadding = item.padding.top;
            endPadding = item.padding.bottom;
            
            if (item.horizontalAlignment == CSLinearLayoutItemHorizontalAlignmentLeft || item.fillMode == CSLinearLayoutItemFillModeStretch) {
                absolutePosition = item.padding.left;
            } else if (item.horizontalAlignment == CSLinearLayoutItemHorizontalAlignmentRight) {
                absolutePosition = self.frame.size.width - item.view.frame.size.width - item.padding.right;
            } else { // CSLinearLayoutItemHorizontalCenter
                absolutePosition = (self.frame.size.width / 2) - ((item.view.frame.size.width + (item.padding.right - item.padding.left)) / 2);
            }
            
        }
        
        if( _equallySpaceItems && equalSpace > 0.0 )
            relativePosition += equalSpace;
        else
            relativePosition += startPadding;
        
        CGFloat currentOffset = 0.0;
        if (self.orientation == CSLinearLayoutViewOrientationHorizontal) {
            
            CGFloat height = item.view.frame.size.height;
            if (item.fillMode == CSLinearLayoutItemFillModeStretch) {
                height = self.frame.size.height - (item.padding.top + item.padding.bottom);
            }
            
            item.view.frame = CGRectIntegral(CGRectMake(relativePosition, absolutePosition, item.view.frame.size.width, height));
            currentOffset = item.view.frame.size.width;
            
        } else {
            
            CGFloat width = item.view.frame.size.width;
            if (item.fillMode == CSLinearLayoutItemFillModeStretch) {
                width = self.frame.size.width - (item.padding.left + item.padding.right);
            }
            
            item.view.frame = CGRectIntegral(CGRectMake(absolutePosition, relativePosition, width, item.view.frame.size.height));
            currentOffset = item.view.frame.size.height;
            
        }
        
        relativePosition += currentOffset;
        if( !_equallySpaceItems || equalSpace <= 0.0 )
            relativePosition += endPadding;
        
    }
    
    if (_autoAdjustFrameSize == YES) {
        [self adjustFrameSize];
    }
    
    if (_autoAdjustContentSize == YES) {
        [self adjustContentSize];
    }
}

- (void)adjustFrameSize {
    if (self.orientation == CSLinearLayoutViewOrientationHorizontal) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.layoutOffset, self.frame.size.height);
    } else {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.layoutOffset);
    }
}

- (void)adjustContentSize {
    if (self.orientation == CSLinearLayoutViewOrientationHorizontal) {
        CGFloat contentWidth = MAX(self.frame.size.width, self.layoutOffset);
        self.contentSize = CGSizeMake(contentWidth, self.frame.size.height);
    } else {
        CGFloat contentHeight = MAX(self.frame.size.height, self.layoutOffset);
        self.contentSize = CGSizeMake(self.frame.size.width, contentHeight);
    }
}

- (CGFloat)layoutOffset {
    CGFloat currentOffset = 0.0;
    
    for (CSLinearLayoutItem *item in _items) {
        if (_orientation == CSLinearLayoutViewOrientationHorizontal) {
            currentOffset += item.padding.left + item.view.frame.size.width + item.padding.right;
        } else {
            currentOffset += item.padding.top + item.view.frame.size.height + item.padding.bottom;
        }
    }
    
    return currentOffset;
}

- (void)setOrientation:(CSLinearLayoutViewOrientation)anOrientation {
    _orientation = anOrientation;
    [self setNeedsLayout];
}

- (void)addSubview:(UIView *)view {
    [super addSubview:view];
    
    if (_autoAdjustFrameSize == YES) {
        [self adjustFrameSize];
    }
    
    if (_autoAdjustContentSize == YES) {
        [self adjustContentSize];
    }
}


#pragma mark - Add, Remove, Insert, & Move

- (void)addItem:(CSLinearLayoutItem *)linearLayoutItem {
    if (linearLayoutItem == nil || [_items containsObject:linearLayoutItem] == YES || linearLayoutItem.view == nil) {
        return;
    }
    
    [_items addObject:linearLayoutItem];
    [self addSubview:linearLayoutItem.view];
}

- (void)removeItem:(CSLinearLayoutItem *)linearLayoutItem {
    if (linearLayoutItem == nil || [_items containsObject:linearLayoutItem] == NO) {
        return;
    }
    
    [linearLayoutItem.view removeFromSuperview];
    [_items removeObject:linearLayoutItem];
}

- (void)removeAllItems {
    // only remove actual items, not scrollbars
    for (CSLinearLayoutItem *item in self.items) {
        [item.view removeFromSuperview];
    }
    [self.items removeAllObjects];
}

- (void)insertItem:(CSLinearLayoutItem *)newItem beforeItem:(CSLinearLayoutItem *)existingItem {
    if (newItem == nil || [_items containsObject:newItem] == YES || existingItem == nil ||  [_items containsObject:existingItem] == NO) {
        return;
    }
    
    NSUInteger index = [_items indexOfObject:existingItem];
    [_items insertObject:newItem atIndex:index];
    [self addSubview:newItem.view];
}

- (void)insertItem:(CSLinearLayoutItem *)newItem afterItem:(CSLinearLayoutItem *)existingItem {
    if (newItem == nil || [_items containsObject:newItem] == YES || existingItem == nil || [_items containsObject:existingItem] == NO) {
        return;
    }
    
    if (existingItem == [_items lastObject]) {
        [_items addObject:newItem];
    } else {
        NSUInteger index = [_items indexOfObject:existingItem];
        [_items insertObject:newItem atIndex:++index];
    }
    
    [self addSubview:newItem.view];
}

- (void)insertItem:(CSLinearLayoutItem *)newItem atIndex:(NSUInteger)index {
    if (newItem == nil || [_items containsObject:newItem] == YES || index >= [_items count]) {
        return;
    }
    
    [_items insertObject:newItem atIndex:index];
    [self addSubview:newItem.view];
}

- (void)moveItem:(CSLinearLayoutItem *)movingItem beforeItem:(CSLinearLayoutItem *)existingItem {
    if (movingItem == nil || [_items containsObject:movingItem] == NO || existingItem == nil || [_items containsObject:existingItem] == NO || movingItem == existingItem) {
        return;
    }
    
    [_items removeObject:movingItem];
    
    NSUInteger existingItemIndex = [_items indexOfObject:existingItem];
    [_items insertObject:movingItem atIndex:existingItemIndex];
    
    [self setNeedsLayout];
}

- (void)moveItem:(CSLinearLayoutItem *)movingItem afterItem:(CSLinearLayoutItem *)existingItem {
    if (movingItem == nil || [_items containsObject:movingItem] == NO || existingItem == nil || [_items containsObject:existingItem] == NO || movingItem == existingItem) {
        return;
    }
    
    [_items removeObject:movingItem];
    
    if (existingItem == [_items lastObject]) {
        [_items addObject:movingItem];
    } else {
        NSUInteger existingItemIndex = [_items indexOfObject:existingItem];
        [_items insertObject:movingItem atIndex:++existingItemIndex];
    }
    
    [self setNeedsLayout];
}

- (void)moveItem:(CSLinearLayoutItem *)movingItem toIndex:(NSUInteger)index {
    if (movingItem == nil || [_items containsObject:movingItem] == NO || index >= [_items count] || [_items indexOfObject:movingItem] == index) {
        return;
    }
    
    [_items removeObject:movingItem];
    
    if (index == ([_items count] - 1)) {
        [_items addObject:movingItem];
    } else {
        [_items insertObject:movingItem atIndex:index];
    }
    
    [self setNeedsLayout];
}

- (void)swapItem:(CSLinearLayoutItem *)firstItem withItem:(CSLinearLayoutItem *)secondItem {
    if (firstItem == nil || [_items containsObject:firstItem] == NO || secondItem == nil || [_items containsObject:secondItem] == NO || firstItem == secondItem) {
        return;
    }
    
    NSUInteger firstItemIndex = [_items indexOfObject:firstItem];
    NSUInteger secondItemIndex = [_items indexOfObject:secondItem];
    [_items exchangeObjectAtIndex:firstItemIndex withObjectAtIndex:secondItemIndex];
    
    [self setNeedsLayout];
}

@end

#pragma mark -

@implementation CSLinearLayoutItem

#pragma mark - Factories

- (id)init {
    self = [super init];
    if (self) {
        self.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentLeft;
        self.verticalAlignment = CSLinearLayoutItemVerticalAlignmentTop;
        self.fillMode = CSLinearLayoutItemFillModeNormal;
    }
    return self;
}

- (id)initWithView:(UIView *)aView {
    self = [super init];
    if (self) {
        self.view = aView;
        self.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentLeft;
        self.verticalAlignment = CSLinearLayoutItemVerticalAlignmentTop;
        self.fillMode = CSLinearLayoutItemFillModeNormal;
    }
    return self;
}

+ (CSLinearLayoutItem *)layoutItemForView:(UIView *)aView {
    CSLinearLayoutItem *item = [[CSLinearLayoutItem alloc] initWithView:aView];
    return item;
}


#pragma mark - Helpers

CSLinearLayoutItemPadding CSLinearLayoutMakePadding(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    CSLinearLayoutItemPadding padding;
    padding.top = top;
    padding.left = left;
    padding.bottom = bottom;
    padding.right = right;
    
    return padding;
}

@end



