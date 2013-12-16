//
//  CSAlignmentViewController.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/25/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSAlignmentViewController.h"
#import "CSLinearLayoutView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CSAlignmentViewController

@synthesize verticalLayoutView = _verticalLayoutView;
@synthesize horizontalLayoutView = _horizontalLayoutView;

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _verticalLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    _verticalLayoutView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    _verticalLayoutView.clipsToBounds = YES;
    _verticalLayoutView.layer.borderColor = [UIColor blackColor].CGColor;
    _verticalLayoutView.layer.borderWidth = 1.0f;
    
    _horizontalLayoutView.orientation = CSLinearLayoutViewOrientationHorizontal;
    _horizontalLayoutView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    _horizontalLayoutView.clipsToBounds = YES;    
    _horizontalLayoutView.layer.borderColor = [UIColor blackColor].CGColor;
    _horizontalLayoutView.layer.borderWidth = 1.0f;
    
    // title
    UILabel *verticalTitleLabel = [[UILabel alloc] init];
    verticalTitleLabel.backgroundColor = [UIColor clearColor];
    verticalTitleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    verticalTitleLabel.text = @"Vertical Layout";
    [verticalTitleLabel sizeToFit];
    
    CSLinearLayoutItem *verticalTitleItem = [CSLinearLayoutItem layoutItemForView:verticalTitleLabel];
    verticalTitleItem.padding = CSLinearLayoutMakePadding(5.0, 0.0, 15.0, 0.0);
    verticalTitleItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [_verticalLayoutView addItem:verticalTitleItem];
    
    // left
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.backgroundColor = [UIColor blueColor];
    leftLabel.text = @"Horizontal Left";
    [leftLabel sizeToFit];
    
    CSLinearLayoutItem *leftItem = [CSLinearLayoutItem layoutItemForView:leftLabel];
    leftItem.padding = CSLinearLayoutMakePadding(15.0, 10.0, 15.0, 10.0);
    leftItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentLeft;
    [_verticalLayoutView addItem:leftItem];
    
    // horizontal center
    UILabel *horizontalCenterLabel = [[UILabel alloc] init];
    horizontalCenterLabel.backgroundColor = [UIColor yellowColor];
    horizontalCenterLabel.text = @"Horizontal Center";
    [horizontalCenterLabel sizeToFit];
    
    CSLinearLayoutItem *horizontalCenterItem = [CSLinearLayoutItem layoutItemForView:horizontalCenterLabel];
    horizontalCenterItem.padding = CSLinearLayoutMakePadding(15.0, 10.0, 15.0, 10.0);
    horizontalCenterItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [_verticalLayoutView addItem:horizontalCenterItem];
    
    // right
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.backgroundColor = [UIColor redColor];
    rightLabel.text = @"Horizontal Right";
    [rightLabel sizeToFit];
    
    CSLinearLayoutItem *rightItem = [CSLinearLayoutItem layoutItemForView:rightLabel];
    rightItem.padding = CSLinearLayoutMakePadding(15.0, 10.0, 0.0, 10.0);
    rightItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentRight;
    [_verticalLayoutView addItem:rightItem];
    
    
    // title
    UILabel *horizontalTitleLabel = [[UILabel alloc] init];
    horizontalTitleLabel.backgroundColor = [UIColor clearColor];
    horizontalTitleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    horizontalTitleLabel.text = @"Horizontal Layout";
    [horizontalTitleLabel sizeToFit];
    
    CSLinearLayoutItem *horizontalTitleItem = [CSLinearLayoutItem layoutItemForView:horizontalTitleLabel];
    horizontalTitleItem.padding = CSLinearLayoutMakePadding(5.0, 10.0, 15.0, 0.0);
    horizontalTitleItem.verticalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
    [_horizontalLayoutView addItem:horizontalTitleItem];
    
    // top
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.backgroundColor = [UIColor greenColor];
    topLabel.text = @"Vertical Top";
    [topLabel sizeToFit];
    
    CSLinearLayoutItem *topItem = [CSLinearLayoutItem layoutItemForView:topLabel];
    topItem.padding = CSLinearLayoutMakePadding(15.0, 10.0, 15.0, 10.0);
    topItem.verticalAlignment = CSLinearLayoutItemVerticalAlignmentTop;
    [_horizontalLayoutView addItem:topItem];
    
    // vertical center
    UILabel *verticalCenterLabel = [[UILabel alloc] init];
    verticalCenterLabel.backgroundColor = [UIColor orangeColor];
    verticalCenterLabel.text = @"Vertical Center";
    [verticalCenterLabel sizeToFit];
    
    CSLinearLayoutItem *verticalCenterItem = [CSLinearLayoutItem layoutItemForView:verticalCenterLabel];
    verticalCenterItem.padding = CSLinearLayoutMakePadding(15.0, 10.0, 15.0, 10.0);
    verticalCenterItem.verticalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
    [_horizontalLayoutView addItem:verticalCenterItem];
    
    // bottom
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.backgroundColor = [UIColor purpleColor];
    bottomLabel.text = @"Vertical Bottom";
    [bottomLabel sizeToFit];
    
    CSLinearLayoutItem *bottomItem = [CSLinearLayoutItem layoutItemForView:bottomLabel];
    bottomItem.padding = CSLinearLayoutMakePadding(15.0, 10.0, 0.0, 10.0);
    bottomItem.verticalAlignment = CSLinearLayoutItemVerticalAlignmentBottom;
    [_horizontalLayoutView addItem:bottomItem];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.verticalLayoutView = nil;
    self.horizontalLayoutView = nil;
}

@end
