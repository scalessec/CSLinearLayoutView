//
//  CSLinearLayoutView.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSLinearLayoutView.h"

@implementation CSLinearLayoutView

@synthesize items = _items;
@synthesize orientation = _orientation;
@synthesize autoAdjustContentSize = _autoAdjustContentSize;

#pragma mark - Factories

- (id)init {
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _orientation = CSLinearLayoutViewOrientationVertical;
        _autoAdjustContentSize = YES;
        self.autoresizesSubviews = NO;
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _orientation = CSLinearLayoutViewOrientationVertical;
        _autoAdjustContentSize = YES;
        self.autoresizesSubviews = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _orientation = CSLinearLayoutViewOrientationVertical;
        _autoAdjustContentSize = YES;
        self.autoresizesSubviews = NO;
    }
    return self;
}


#pragma mark - Lifecycle

- (void)dealloc {
    [_items release], _items = nil;
    
    [super dealloc];
}


#pragma mark - Layout

- (void)layoutSubviews {
    
    CGFloat relativePosition = 0.0;
    CGFloat absolutePosition = 0.0;
    
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
        
        relativePosition += startPadding;
        
        CGFloat delta = 0.0;
        if (self.orientation == CSLinearLayoutViewOrientationHorizontal) {
            
            CGFloat height = item.view.frame.size.height;
            if (item.fillMode == CSLinearLayoutItemFillModeStretch) {
                height = self.frame.size.height - (item.padding.top + item.padding.bottom);
            }
            
            item.view.frame = CGRectMake(relativePosition, absolutePosition, item.view.frame.size.width, height);
            delta = item.view.frame.size.width;
            
        } else {
            
            CGFloat width = item.view.frame.size.width;
            if (item.fillMode == CSLinearLayoutItemFillModeStretch) {
                width = self.frame.size.width - (item.padding.left + item.padding.right);
            }
            
            item.view.frame = CGRectMake(absolutePosition, relativePosition, width, item.view.frame.size.height);
            delta = item.view.frame.size.height;
            
        }
        
        relativePosition += delta + endPadding;
        
    }
    
    if (_autoAdjustContentSize == YES) {
        if (self.orientation == CSLinearLayoutViewOrientationHorizontal) {
            CGFloat contentWidth = MAX(self.frame.size.width, self.contentDelta);
            self.contentSize = CGSizeMake(contentWidth, self.frame.size.height);
        } else {
            CGFloat contentHeight = MAX(self.frame.size.height, self.contentDelta);
            self.contentSize = CGSizeMake(self.frame.size.width, contentHeight);
        }
    }
}


#pragma mark - Overrides

- (void)setOrientation:(CSLinearLayoutViewOrientation)anOrientation {
    _orientation = anOrientation;
    [self setNeedsLayout];
}

- (CGFloat)contentDelta {
    CGFloat delta = 0.0;
    
    for (CSLinearLayoutItem *item in _items) {
        if (_orientation == CSLinearLayoutViewOrientationHorizontal) {
            delta += item.padding.left + item.view.frame.size.width + item.padding.right;
        } else {
            delta += item.padding.top + item.view.frame.size.height + item.padding.bottom;
        }
    }
    
    return delta;
}


#pragma mark - Add, Remove, Insert, & Move

- (void)addItem:(CSLinearLayoutItem *)linearLayoutItem {
    if (linearLayoutItem == nil || [_items containsObject:linearLayoutItem] == YES) {
        return;
    }
    
    [_items addObject:linearLayoutItem];
    [self addSubview:linearLayoutItem.view];
}

- (void)removeItem:(CSLinearLayoutItem *)linearLayoutItem {
    if (linearLayoutItem == nil || [_items containsObject:linearLayoutItem] == NO) {
        return;
    }
    
    [linearLayoutItem retain];
    
    [_items removeObject:linearLayoutItem];
    [linearLayoutItem.view removeFromSuperview];
    
    [linearLayoutItem release];
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
    
    [movingItem retain];
    [_items removeObject:movingItem];
    
    NSUInteger existingItemIndex = [_items indexOfObject:existingItem];
    [_items insertObject:movingItem atIndex:existingItemIndex];
    [movingItem release];
    
    [self setNeedsLayout];
}

- (void)moveItem:(CSLinearLayoutItem *)movingItem afterItem:(CSLinearLayoutItem *)existingItem {
    if (movingItem == nil || [_items containsObject:movingItem] == NO || existingItem == nil || [_items containsObject:existingItem] == NO || movingItem == existingItem) {
        return;
    }
    
    [movingItem retain];
    [_items removeObject:movingItem];
    
    if (existingItem == [_items lastObject]) {
        [_items addObject:movingItem];
    } else {
        NSUInteger existingItemIndex = [_items indexOfObject:existingItem];
        [_items insertObject:movingItem atIndex:++existingItemIndex];
    }
    [movingItem release];
    
    [self setNeedsLayout];
}

- (void)moveItem:(CSLinearLayoutItem *)movingItem toIndex:(NSUInteger)index {
    if (movingItem == nil || [_items containsObject:movingItem] == NO || index >= [_items count] || [_items indexOfObject:movingItem] == index) {
        return;
    }
    
    [movingItem retain];
    [_items removeObject:movingItem];
    
    if (index == ([_items count] - 1)) {
        [_items addObject:movingItem];
    } else {
        [_items insertObject:movingItem atIndex:index];
    }
    [movingItem release];
    
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
