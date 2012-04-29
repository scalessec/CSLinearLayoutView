//
//  CSBulletListView.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 4/29/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSBulletListView.h"
#import "CSBulletListitemView.h"
#import "UIView+LoadFromNib.h"

@implementation CSBulletListView

@synthesize list = _list;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = YES;
    }
    return self;
}

- (void)setList:(NSMutableArray *)theList {
    if (_list != theList) {
        [_list release];
        _list = [theList retain];
    }

    [self removeAllItems];
    
    if (_list == nil) {
        return;
    }
    
    for (NSString *string in _list) {
        CSBulletListItemView *bulletItem = (CSBulletListItemView *)[UIView loadFromNib:@"CSBulletListItemView" owner:self];
        bulletItem.itemText = string;
        CSLinearLayoutItem *layoutItem = [CSLinearLayoutItem layoutItemForView:bulletItem];
        layoutItem.padding = CSLinearLayoutMakePadding(5.0, 0.0, 5.0, 0.0);
        [self addItem:layoutItem];
    }
}

- (void)dealloc {
    self.list = nil;
    [super dealloc];
}

@end
