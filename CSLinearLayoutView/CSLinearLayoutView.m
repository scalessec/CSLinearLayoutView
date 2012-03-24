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


#pragma mark - Factories

- (id)init {
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        self.orientation = CSLinearLayoutViewOrientationVertical;
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        self.orientation = CSLinearLayoutViewOrientationVertical;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        self.orientation = CSLinearLayoutViewOrientationVertical;
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
            /*if (item.gravity == CSLinearLayoutItemGravityLeft) {
                
            } else {
                
            }*/
        } else {
            startPadding = item.padding.top;
            endPadding = item.padding.bottom;
            absolutePosition = item.padding.left;
        }
        
        relativePosition += startPadding;
        
        CGFloat itemSize = 0.0;
        if (self.orientation == CSLinearLayoutViewOrientationHorizontal) {
            itemSize = item.view.frame.size.width;
            item.view.frame = CGRectMake(relativePosition, absolutePosition, itemSize, item.view.frame.size.height);
        } else {
            itemSize = item.view.frame.size.height;
            item.view.frame = CGRectMake(absolutePosition, relativePosition, item.view.frame.size.width, itemSize);
        }
        
        relativePosition += itemSize + endPadding;
        
    }
    
}


#pragma mark - Overrides

- (void)setOrientation:(CSLinearLayoutViewOrientation)anOrientation {
    _orientation = anOrientation;
    [self setNeedsLayout];
}


#pragma mark - Add, Remove, Insert, & Move

- (void)addItem:(CSLinearLayoutItem *)linearLayoutItem {
    // sanity
    if (linearLayoutItem == nil || [_items containsObject:linearLayoutItem]) {
        return;
    }
    [_items addObject:linearLayoutItem];
    
    [self addSubview:linearLayoutItem.view];
}

- (void)removeItem:(CSLinearLayoutItem *)linearLayoutItem {
    
}

- (void)insertItem:(CSLinearLayoutItem *)newItem beforeItem:(CSLinearLayoutItem *)existingItem {
    
}

- (void)insertItem:(CSLinearLayoutItem *)newItem afterItem:(CSLinearLayoutItem *)existingItem {
    
}

- (void)insertItem:(CSLinearLayoutItem *)newItem atIndex:(NSInteger)index {
    
}

- (void)moveItem:(CSLinearLayoutItem *)movingItem beforeItem:(CSLinearLayoutItem *)existingItem {
    
}

- (void)moveItem:(CSLinearLayoutItem *)movingItem afterItem:(CSLinearLayoutItem *)existingItem {
    
}

- (void)moveItem:(CSLinearLayoutItem *)movingItem toIndex:(NSInteger)index {
    
}


@end
