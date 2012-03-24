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
    _linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    _linearLayoutView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_linearLayoutView];
    
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [topButton setTitle:@"Top Button" forState:UIControlStateNormal];
    topButton.frame = CGRectMake(10.0, 10.0, 200.0, 40.0);
    
    CSLinearLayoutItem *topButtonItem = [[[CSLinearLayoutItem alloc] initWithView:topButton] autorelease];
    topButtonItem.gravity = CSLinearLayoutItemGravityTop;
    [_linearLayoutView addItem:topButtonItem];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    self.linearLayoutView = nil;
    
    [super release];
}

@end
