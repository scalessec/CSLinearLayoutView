//
//  CSOrientationSwitchViewController.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/25/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSOrientationSwitchViewController.h"
#import "CSLinearLayoutView.h"
#import "UIColor+RandomColor.h"

@implementation CSOrientationSwitchViewController

@synthesize linearLayoutView = _linearLayoutView;

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setup the linear layout
    _linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    _linearLayoutView.scrollEnabled = YES;
    
    // add ten views
    for (int i=0; i<10; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 40.0)];
        view.backgroundColor = [UIColor randomColor];
        
        CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:view];
        item.padding = CSLinearLayoutMakePadding(10.0, 10.0, 10.0, 10.0);
        item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
        item.verticalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
        [_linearLayoutView addItem:item];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.linearLayoutView = nil;
}

#pragma mark - Events

- (IBAction)handleSwitchOrientations {
    // the setter is being overridden to force a redraw
    if (_linearLayoutView.orientation == CSLinearLayoutViewOrientationHorizontal) {
        self.linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    } else {
        self.linearLayoutView.orientation = CSLinearLayoutViewOrientationHorizontal;
    }
}

@end
