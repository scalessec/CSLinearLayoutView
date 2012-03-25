//
//  CSHorizontalViewController.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/25/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSHorizontalViewController.h"
#import "CSLinearLayoutItem.h"
#import "UIColor+RandomColor.h"

@interface CSHorizontalViewController()

- (CSLinearLayoutItem *)newItem;

@end

@implementation CSHorizontalViewController

@synthesize linearLayoutView = _linearLayoutView;


#pragma mark - Factories

- (CSLinearLayoutItem *)newItem {
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 300.0)] autorelease];
    view.backgroundColor = [UIColor randomColor];
    
    UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRemoveView:)] autorelease];
    [view addGestureRecognizer:tap];
    
    CSLinearLayoutItem *item = [[[CSLinearLayoutItem alloc] initWithView:view] autorelease];
    item.padding = CSLinearLayoutMakePadding(10.0, 10.0, 10.0, 0.0);
    item.verticalAlignment = CSLinearLayoutItemVerticalAlignmentTop;
    item.fillMode = CSLinearLayoutItemFillModeStretch;

    return item;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setup the linear layout
    self.linearLayoutView = [[[CSLinearLayoutView alloc] initWithFrame:self.view.bounds] autorelease];
    _linearLayoutView.orientation = CSLinearLayoutViewOrientationHorizontal;
    _linearLayoutView.scrollEnabled = YES;
    _linearLayoutView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _linearLayoutView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_linearLayoutView];
    
    // add a description label
    UILabel *descriptionLabel = [[[UILabel alloc] init] autorelease];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    descriptionLabel.font = [UIFont systemFontOfSize:14.0];
    descriptionLabel.text = @"Horizontal orientation. Tap the button to add a new view. Tap a colored view to remove. Fill mode is set to stretch.";
    descriptionLabel.frame = CGRectMake(0.0, 0.0, 70.0, 100.0);
    
    CSLinearLayoutItem *labelItem = [[[CSLinearLayoutItem alloc] initWithView:descriptionLabel] autorelease];
    labelItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    labelItem.fillMode = CSLinearLayoutItemFillModeStretch;
    [_linearLayoutView addItem:labelItem];
    
    // add three random views
    for (int i=0; i<3; i++) {
        CSLinearLayoutItem *item = [self newItem];
        [_linearLayoutView addItem:item];
    }
    
    // button to add more views
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(0.0, 0.0, 50.0, 300.0);
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(handleAddView) forControlEvents:UIControlEventTouchUpInside];
    
    CSLinearLayoutItem *buttonItem = [[[CSLinearLayoutItem alloc] initWithView:addButton] autorelease];
    buttonItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 10.0, 20.0);
    buttonItem.verticalAlignment = CSLinearLayoutItemVerticalAlignmentTop;
    buttonItem.fillMode = CSLinearLayoutItemFillModeStretch;
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
    CGFloat contentWidth = MAX(_linearLayoutView.frame.size.width, [_linearLayoutView contentDelta]);
    _linearLayoutView.contentSize = CGSizeMake(contentWidth, _linearLayoutView.frame.size.height);
    
    // scroll to the right
    CGPoint rightOffset = CGPointMake(_linearLayoutView.contentSize.width - _linearLayoutView.bounds.size.width, 0);
    [_linearLayoutView setContentOffset:rightOffset animated:YES];
}

- (void)handleRemoveView:(UITapGestureRecognizer*)recognizer {
    for(CSLinearLayoutItem *item in _linearLayoutView.items) {
        if(item.view == recognizer.view) {
            [_linearLayoutView removeItem:item];
            break;
        }
    }
}

@end
