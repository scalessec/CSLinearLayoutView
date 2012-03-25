//
//  CSViewController.m
//  CSLinearLayoutViewDemo
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSViewController.h"
#import "CSLinearLayoutItem.h"

@implementation CSViewController

@synthesize linearLayoutView = _linearLayoutView;


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.linearLayoutView = [[[CSLinearLayoutView alloc] initWithFrame:self.view.bounds] autorelease];
    // setOriention is being overidden to force a redraw, so be sure to use self if changing layout orientation
    self.linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    _linearLayoutView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _linearLayoutView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_linearLayoutView];
    
    UIView *redView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 40.0)] autorelease];
    redView.backgroundColor = [UIColor redColor];
    CSLinearLayoutItem *redItem = [[[CSLinearLayoutItem alloc] initWithView:redView] autorelease];
    redItem.padding = CSLinearLayoutMakePadding(20.0, 0.0, 50.0, 0.0);
    redItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [_linearLayoutView addItem:redItem];
    
    UIView *yellowView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 40.0)] autorelease];
    yellowView.backgroundColor = [UIColor yellowColor];
    CSLinearLayoutItem *yellowItem = [[[CSLinearLayoutItem alloc] initWithView:yellowView] autorelease];
    yellowItem.padding = CSLinearLayoutMakePadding(10.0, 5.0, 0.0, 25.0);
    yellowItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentRight;
    yellowItem.fillMode = CSLinearLayoutItemFillModeStretch;
    [_linearLayoutView addItem:yellowItem];
    
    UIView *blueView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 40.0)] autorelease];
    blueView.backgroundColor = [UIColor blueColor];
    CSLinearLayoutItem *blueItem = [[[CSLinearLayoutItem alloc] initWithView:blueView] autorelease];
    blueItem.padding = CSLinearLayoutMakePadding(10.0, 20.0, 0.0, 10.0);
    blueItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentRight;
    [_linearLayoutView addItem:blueItem];
    
    UIView *greenView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 40.0)] autorelease];
    greenView.backgroundColor = [UIColor greenColor];
    CSLinearLayoutItem *greenItem = [[[CSLinearLayoutItem alloc] initWithView:greenView] autorelease];
    greenItem.padding = CSLinearLayoutMakePadding(0.0, 10.0, 0.0, 5.0);
    greenItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    greenItem.fillMode = CSLinearLayoutItemFillModeStretch;
    [_linearLayoutView insertItem:greenItem atIndex:0];


}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    self.linearLayoutView = nil;
    
    [super release];
}

@end
