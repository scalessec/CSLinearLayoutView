//
//  CSLinearLayoutItem.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSLinearLayoutItem.h"

@implementation CSLinearLayoutItem

@synthesize view = _view;
@synthesize contentMode = _contentMode;
@synthesize gravity = _gravity;
@synthesize weight = _weight;
@synthesize padding = _padding;
@synthesize tag = _tag;
@synthesize userInfo = _userInfo;

#pragma mark - Factories

- (id)init {
    self = [super init];
    if (self) {
        self.weight = 1.0;
    }
    return self;
}

- (id)initWithView:(UIView *)aView {
    self = [super init];
    if (self) {
        self.view = aView;
        self.weight = 1.0;
    }
    return self;
}


#pragma mark - Memory Management

- (void)dealloc {
    self.view = nil;
    self.userInfo = nil;
    
    [super dealloc];
}

@end
