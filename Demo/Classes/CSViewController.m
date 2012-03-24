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
    self.linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    _linearLayoutView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_linearLayoutView];
    
    UIView *redView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 40.0)] autorelease];
    redView.backgroundColor = [UIColor redColor];
    CSLinearLayoutItem *redItem = [[[CSLinearLayoutItem alloc] initWithView:redView] autorelease];
    redItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 0.0);
    [_linearLayoutView addItem:redItem];
    
    UIView *yellowView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 40.0)] autorelease];
    yellowView.backgroundColor = [UIColor yellowColor];
    CSLinearLayoutItem *yellowItem = [[[CSLinearLayoutItem alloc] initWithView:yellowView] autorelease];
    yellowItem.padding = CSLinearLayoutMakePadding(10.0, 50.0, 0.0, 0.0);
    [_linearLayoutView addItem:yellowItem];
    
    UIView *blueView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 40.0)] autorelease];
    blueView.backgroundColor = [UIColor blueColor];
    CSLinearLayoutItem *blueItem = [[[CSLinearLayoutItem alloc] initWithView:blueView] autorelease];
    blueItem.padding = CSLinearLayoutMakePadding(5.0, 20.0, 0.0, 0.0);
    [_linearLayoutView addItem:blueItem];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    self.linearLayoutView = nil;
    
    [super release];
}

@end
