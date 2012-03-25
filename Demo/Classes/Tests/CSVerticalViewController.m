//
//  CSVerticalViewController.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/25/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSVerticalViewController.h"
#import "CSLinearLayoutItem.h"
#import "UIColor+RandomColor.h"

@interface CSVerticalViewController()

- (CSLinearLayoutItem *)newItem;

@end

@implementation CSVerticalViewController

@synthesize linearLayoutView = _linearLayoutView;


#pragma mark - Factories

- (CSLinearLayoutItem *)newItem {
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 260.0, 40.0)] autorelease];
    view.backgroundColor = [UIColor randomColor];
    
    CSLinearLayoutItem *item = [[[CSLinearLayoutItem alloc] initWithView:view] autorelease];
    item.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    
    return item;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setup the linear layout
    self.linearLayoutView = [[[CSLinearLayoutView alloc] initWithFrame:self.view.bounds] autorelease];
    _linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    _linearLayoutView.scrollEnabled = YES;
    _linearLayoutView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _linearLayoutView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_linearLayoutView];
    
    // add three items
    for (int i=0; i<3; i++) {
        CSLinearLayoutItem *item = [self newItem];
        [_linearLayoutView addItem:item];
    }
    
    // add a button to add more views
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(0.0, 0.0, 260.0, 40.0);
    [addButton setTitle:@"Add Another View" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(handleAddView) forControlEvents:UIControlEventTouchUpInside];
    
    CSLinearLayoutItem *buttonItem = [[[CSLinearLayoutItem alloc] initWithView:addButton] autorelease];
    buttonItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 20.0, 10.0);
    buttonItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [_linearLayoutView addItem:buttonItem];
    
}

- (void)viewDidUnload {
    self.linearLayoutView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    self.linearLayoutView = nil;
}


#pragma mark - Events

- (void)handleAddView {
    // create the item
     CSLinearLayoutItem *item = [self newItem];
    
    // insert above the add button
    NSUInteger index = [_linearLayoutView.items count] - 1;
    [_linearLayoutView insertItem:item atIndex:index];
    
    // adjust the content size
    CGFloat contentHeight = MAX(_linearLayoutView.frame.size.height, [_linearLayoutView contentDelta]);
    _linearLayoutView.contentSize = CGSizeMake(_linearLayoutView.frame.size.width, contentHeight);
    
    // scroll to the bottom
    CGPoint bottomOffset = CGPointMake(0, _linearLayoutView.contentSize.height - _linearLayoutView.bounds.size.height);
    [_linearLayoutView setContentOffset:bottomOffset animated:YES];
}

@end
