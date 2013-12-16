//
//  CSVerticalViewController.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/25/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSVerticalViewController.h"
#import "CSLinearLayoutView.h"
#import "UIColor+RandomColor.h"

@interface CSVerticalViewController()

- (CSLinearLayoutItem *)newItem;

@end

@implementation CSVerticalViewController

@synthesize linearLayoutView = _linearLayoutView;


#pragma mark - Factories

- (CSLinearLayoutItem *)newItem {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 260.0, 40.0)];
    view.backgroundColor = [UIColor randomColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRemoveView:)];
    [view addGestureRecognizer:tap];
    
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:view];
    item.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    
    return item;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setup the linear layout
    self.linearLayoutView = [[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    _linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    _linearLayoutView.scrollEnabled = YES;
    _linearLayoutView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _linearLayoutView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_linearLayoutView];
    
    // add a description label
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    descriptionLabel.font = [UIFont systemFontOfSize:14.0];
    descriptionLabel.text = @"Vertical orientation. Tap the button to add a new view. Tap a colored view to remove. Fill mode is set to respect original sizes.";
    CGSize descriptionSize = [descriptionLabel.text sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(260.0, CGFLOAT_MAX)];
    descriptionLabel.frame = CGRectMake(0.0, 0.0, 260.0, descriptionSize.height);
    
    CSLinearLayoutItem *labelItem = [CSLinearLayoutItem layoutItemForView:descriptionLabel];
    labelItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    labelItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [_linearLayoutView addItem:labelItem];
    
    // add three views
    for (int i=0; i<3; i++) {
        CSLinearLayoutItem *item = [self newItem];
        [_linearLayoutView addItem:item];
    }
    
    // button to add more views
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(0.0, 0.0, 260.0, 40.0);
    [addButton setTitle:@"Add Another View" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(handleAddView) forControlEvents:UIControlEventTouchUpInside];
    
    CSLinearLayoutItem *buttonItem = [CSLinearLayoutItem layoutItemForView:addButton];
    buttonItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 20.0, 10.0);
    buttonItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [_linearLayoutView addItem:buttonItem];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.linearLayoutView = nil;
}

#pragma mark - Events

- (void)handleAddView {
    // create the item
     CSLinearLayoutItem *item = [self newItem];
    
    // insert above the add button
    NSUInteger index = [_linearLayoutView.items count] - 1;
    [_linearLayoutView insertItem:item atIndex:index];
    
    // scroll to the bottom, if necessary
    if (_linearLayoutView.frame.size.height < _linearLayoutView.layoutOffset) {
        CGPoint bottomOffset = CGPointMake(0, _linearLayoutView.layoutOffset - _linearLayoutView.frame.size.height);
        [_linearLayoutView setContentOffset:bottomOffset animated:YES];
    }
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
