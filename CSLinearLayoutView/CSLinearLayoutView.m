//
//  CSLinearLayoutView.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2013 Charles Scalesse. All rights reserved.
//

#import "CSLinearLayoutView.h"

@interface CSLinearLayoutView()
@property (nonatomic, strong) NSMutableArray *items; // private setter for items
@property (nonatomic, readonly) CGSize innerFrameSize; // available space for content without insets
@property (nonatomic) BOOL contentsDidChange; // saves, if relayout is needed
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
    self.items = [[NSMutableArray alloc] init];
    self.orientation = CSLinearLayoutViewOrientationVertical;
    self.autoAdjustFrameSize = NO;
    self.autoAdjustContentSize = YES;
    self.autoresizesSubviews = NO;
    
    [self restoreDefaultFormats];
}

- (void)restoreDefaultFormats {
    // adding shortcut settings
    self.textColor = [UIColor blackColor];
	self.defaultFont  = [UIFont systemFontOfSize: 14];
	self.subtitleFont = [UIFont boldSystemFontOfSize: 14];
	self.titleFont    = [UIFont boldSystemFontOfSize: 18];
	self.defaultMargin  = 6;
	self.subtitleMargin = 20;
	self.titleMargin    = 15;
}


#pragma mark - Layout

- (void)setFrame:(CGRect)frame;
{
    [super setFrame: frame];
    self.contentsDidChange = YES;
}

- (void)setNeedsLayout;
{
    [super setNeedsLayout];
    self.contentsDidChange = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // only relayout if explicitly needed
    // (because layout subviews is called on every contentOffset change)
    if (!self.contentsDidChange) {
        return;
    }
    self.contentsDidChange = NO;
    
    CGFloat relativePosition = 0.0;
    CGFloat absolutePosition = 0.0;
    
    for (CSLinearLayoutItem *item in self.items) {
        
        CGFloat startPadding = 0.0;
        CGFloat endPadding = 0.0;
        
        if (self.orientation == CSLinearLayoutViewOrientationHorizontal) {
            
            startPadding = item.padding.left;
            endPadding = item.padding.right;
            
            if (item.verticalAlignment == CSLinearLayoutItemVerticalAlignmentTop || item.fillMode == CSLinearLayoutItemFillModeStretch) {
                absolutePosition = item.padding.top;
            } else if (item.verticalAlignment == CSLinearLayoutItemVerticalAlignmentBottom) {
                absolutePosition = self.innerFrameSize.height - item.view.frame.size.height - item.padding.bottom;
            } else { // CSLinearLayoutItemVerticalCenter
                absolutePosition = (self.innerFrameSize.height / 2) - ((item.view.frame.size.height + (item.padding.bottom - item.padding.top)) / 2);
            }
            
        } else {
            
            startPadding = item.padding.top;
            endPadding = item.padding.bottom;
            
            if (item.horizontalAlignment == CSLinearLayoutItemHorizontalAlignmentLeft || item.fillMode == CSLinearLayoutItemFillModeStretch) {
                absolutePosition = item.padding.left;
            } else if (item.horizontalAlignment == CSLinearLayoutItemHorizontalAlignmentRight) {
                absolutePosition = self.innerFrameSize.width - item.view.frame.size.width - item.padding.right;
            } else { // CSLinearLayoutItemHorizontalCenter
                absolutePosition = (self.innerFrameSize.width / 2) - ((item.view.frame.size.width + (item.padding.right - item.padding.left)) / 2);
            }
            
        }
        
        relativePosition += startPadding;
        
        CGFloat currentOffset = 0.0;
        if (self.orientation == CSLinearLayoutViewOrientationHorizontal) {
            
            CGFloat height = item.view.frame.size.height;
            if (item.fillMode == CSLinearLayoutItemFillModeStretch) {
                height = self.innerFrameSize.height - (item.padding.top + item.padding.bottom);
            }
            
            item.view.frame = CGRectMake(relativePosition, absolutePosition, item.view.frame.size.width, height);
            currentOffset = item.view.frame.size.width;
            
        } else {
            
            CGFloat width = item.view.frame.size.width;
            if (item.fillMode == CSLinearLayoutItemFillModeStretch) {
                width = self.innerFrameSize.width - (item.padding.left + item.padding.right);
            }
            
            item.view.frame = CGRectMake(absolutePosition, relativePosition, width, item.view.frame.size.height);
            currentOffset = item.view.frame.size.height;
            
        }
        
        relativePosition += currentOffset + endPadding;
        
    }
    
    if (self.autoAdjustFrameSize == YES) {
        [self adjustFrameSize];
    }
    
    if (self.autoAdjustContentSize == YES) {
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
        CGFloat contentWidth = MAX(self.innerFrameSize.width, self.layoutOffset);
        self.contentSize = CGSizeMake(contentWidth, self.innerFrameSize.height);
    } else {
        CGFloat contentHeight = MAX(self.innerFrameSize.height, self.layoutOffset);
        self.contentSize = CGSizeMake(self.innerFrameSize.width, contentHeight);
    }
}

- (CGSize)innerFrameSize {
    return CGSizeMake(self.frame.size.width - self.contentInset.left - self.contentInset.right,
                      self.frame.size.height - self.contentInset.top - self.contentInset.bottom);
}

- (CGFloat)layoutOffset {
    CGFloat currentOffset = 0.0;
    
    for (CSLinearLayoutItem *item in self.items) {
        if (self.orientation == CSLinearLayoutViewOrientationHorizontal) {
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
    
    if (self.autoAdjustFrameSize == YES) {
        [self adjustFrameSize];
    }
    
    if (self.autoAdjustContentSize == YES) {
        [self adjustContentSize];
    }
    
    self.contentsDidChange = YES;
}


#pragma mark - Add, Remove, Insert, & Move

- (void)addItem:(CSLinearLayoutItem *)linearLayoutItem {
    if (linearLayoutItem == nil || [self.items containsObject:linearLayoutItem] == YES || linearLayoutItem.view == nil) {
        return;
    }
    
    [self.items addObject:linearLayoutItem];
    [self addSubview:linearLayoutItem.view];
}

- (void)removeItem:(CSLinearLayoutItem *)linearLayoutItem {
    if (linearLayoutItem == nil || [self.items containsObject:linearLayoutItem] == NO) {
        return;
    }
    
    [linearLayoutItem.view removeFromSuperview];
    [self.items removeObject:linearLayoutItem];
    self.contentsDidChange = YES;
}

- (void)removeAllItems {
    // only remove actual items, not scrollbars
    for (CSLinearLayoutItem *item in self.items) {
        [item.view removeFromSuperview];
    }
    [self.items removeAllObjects];
    self.contentsDidChange = YES;
}

- (void)insertItem:(CSLinearLayoutItem *)newItem beforeItem:(CSLinearLayoutItem *)existingItem {
    if (newItem == nil || [self.items containsObject:newItem] == YES || existingItem == nil ||  [self.items containsObject:existingItem] == NO) {
        return;
    }
    
    NSUInteger index = [self.items indexOfObject:existingItem];
    [self.items insertObject:newItem atIndex:index];
    [self addSubview:newItem.view];
}

- (void)insertItem:(CSLinearLayoutItem *)newItem afterItem:(CSLinearLayoutItem *)existingItem {
    if (newItem == nil || [self.items containsObject:newItem] == YES || existingItem == nil || [self.items containsObject:existingItem] == NO) {
        return;
    }
    
    if (existingItem == [self.items lastObject]) {
        [self.items addObject:newItem];
    } else {
        NSUInteger index = [self.items indexOfObject:existingItem];
        [self.items insertObject:newItem atIndex:++index];
    }
    
    [self addSubview:newItem.view];
}

- (void)insertItem:(CSLinearLayoutItem *)newItem atIndex:(NSUInteger)index {
    if (newItem == nil || [self.items containsObject:newItem] == YES || index >= [self.items count]) {
        return;
    }
    
    [self.items insertObject:newItem atIndex:index];
    [self addSubview:newItem.view];
}

- (void)moveItem:(CSLinearLayoutItem *)movingItem beforeItem:(CSLinearLayoutItem *)existingItem {
    if (movingItem == nil || [self.items containsObject:movingItem] == NO || existingItem == nil || [self.items containsObject:existingItem] == NO || movingItem == existingItem) {
        return;
    }
    
    [self.items removeObject:movingItem];
    
    NSUInteger existingItemIndex = [self.items indexOfObject:existingItem];
    [self.items insertObject:movingItem atIndex:existingItemIndex];
    
    [self setNeedsLayout];
}

- (void)moveItem:(CSLinearLayoutItem *)movingItem afterItem:(CSLinearLayoutItem *)existingItem {
    if (movingItem == nil || [self.items containsObject:movingItem] == NO || existingItem == nil || [self.items containsObject:existingItem] == NO || movingItem == existingItem) {
        return;
    }
    
    [self.items removeObject:movingItem];
    
    if (existingItem == [self.items lastObject]) {
        [self.items addObject:movingItem];
    } else {
        NSUInteger existingItemIndex = [self.items indexOfObject:existingItem];
        [self.items insertObject:movingItem atIndex:++existingItemIndex];
    }
    
    [self setNeedsLayout];
}

- (void)moveItem:(CSLinearLayoutItem *)movingItem toIndex:(NSUInteger)index {
    if (movingItem == nil || [self.items containsObject:movingItem] == NO || index >= [self.items count] || [self.items indexOfObject:movingItem] == index) {
        return;
    }
    
    [self.items removeObject:movingItem];
    
    if (index == ([self.items count] - 1)) {
        [self.items addObject:movingItem];
    } else {
        [self.items insertObject:movingItem atIndex:index];
    }
    
    [self setNeedsLayout];
}

- (void)swapItem:(CSLinearLayoutItem *)firstItem withItem:(CSLinearLayoutItem *)secondItem {
    if (firstItem == nil || [self.items containsObject:firstItem] == NO || secondItem == nil || [self.items containsObject:secondItem] == NO || firstItem == secondItem) {
        return;
    }
    
    NSUInteger firstItemIndex = [self.items indexOfObject:firstItem];
    NSUInteger secondItemIndex = [self.items indexOfObject:secondItem];
    [self.items exchangeObjectAtIndex:firstItemIndex withObjectAtIndex:secondItemIndex];
    
    [self setNeedsLayout];
}

#pragma mark Content Shortcuts

- (CSLinearLayoutItem*)addImageNamed:(NSString*)imageName;
{
    UIImage* image = [UIImage imageNamed:imageName];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    
    if (image && imageView) {
        // create layout item
        CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:imageView];
        item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
        item.verticalAlignment   = CSLinearLayoutItemVerticalAlignmentCenter;
        [self addItem:item];
        return item;
    }
    
    return nil;
}

- (CSLinearLayoutItem*)addText:(NSString*)text;
{
    return [self addText:text font:self.defaultFont];
}

- (CSLinearLayoutItem*)addText:(NSString*)text font:(UIFont*)font;
{
    return [self addText:text font:font frontMargin:self.defaultMargin];
}

- (CSLinearLayoutItem*)addText:(NSString*)text frontMargin:(CGFloat)frontMargin;
{
    return [self addText:text font:self.defaultFont frontMargin:frontMargin];
}

- (CSLinearLayoutItem*)addText:(NSString*)text font:(UIFont*)font frontMargin:(CGFloat)frontMargin;
{
    BOOL isVertical = (self.orientation == CSLinearLayoutViewOrientationVertical);
    CGFloat maxSize = self.frame.size.width - self.contentInset.left - self.contentInset.right;
    if (!isVertical) {
        maxSize = self.frame.size.height - self.contentInset.top - self.contentInset.bottom;
    }
	
    // create label
    CGRect frame = CGRectMake(0, 0, isVertical ? maxSize : CGFLOAT_MAX,
                              !isVertical ? maxSize : CGFLOAT_MAX);
	UILabel* label = [[UILabel alloc] initWithFrame:frame];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = self.textColor;
	label.font = font;
	label.text = text;
	label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeWordWrap;
	[label sizeToFit];
    
    // create layout item
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:label];
    item.padding = CSLinearLayoutMakePadding(isVertical ? frontMargin : 0,
                                             !isVertical ? frontMargin : 0,
                                             0, 0);
    item.verticalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
    item.fillMode = CSLinearLayoutItemFillModeStretch;
    [self addItem:item];
    
    return item;
}

- (CSLinearLayoutItem*)addTitle:(NSString*)text;
{
    CGFloat margin = (self.items.count > 0) ? self.titleMargin : 0;
	return [self addText:text font:self.titleFont frontMargin:margin];
}

- (CSLinearLayoutItem*)addSubtitle:(NSString*)text;
{
    CGFloat margin = (self.items.count > 0) ? self.subtitleMargin : 0;
	return [self addText:text font:self.subtitleFont frontMargin:margin];
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



