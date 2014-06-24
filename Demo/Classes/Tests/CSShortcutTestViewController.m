//
//  CSShortcutTestViewController.m
//  CSLinearLayoutView
//
//  Created by Markus Emrich on 12.02.13.
//  Copyright (c) 2013 Charles Scalesse. All rights reserved.
//

#import "CSLinearLayoutView.h"

#import "CSShortcutTestViewController.h"


@interface CSShortcutTestViewController ()
@property (nonatomic, readonly) CSLinearLayoutView* view;
@end

@implementation CSShortcutTestViewController


- (void)loadView;
{
    self.view = [[CSLinearLayoutView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.view.textColor = [UIColor whiteColor];
    self.view.shadowColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.view.shadowOffset = CGSizeMake(-1, -1);
    self.view.titleMargin = 30;
    
    [self.view addImageNamed:@"github-logo"];
    [self.view addTitle:self.title];
    [self.view addSubtitle:@"Easily add text and images with only one line of code."];
    [self.view addText:@"The following code is all you need, to create the contents, of this view. The most important methods are addText: and addImageNamed:."];
    [self.view addTitle:@"Code"];
    
    self.view.defaultMargin = -8;
    [self addTextInCourier:@"CSLinearLayoutView *csView;"];
    [self addTextInCourier:@"csView = [CSLinearLayoutView new];"];
    [self addTextInCourier:@"[csView addImageNamed:@\"github-logo\"];"];
    [self addTextInCourier:@"[csView addTitle:titleText1];"];
    [self addTextInCourier:@"[csView addSubtitle:subtitleText];"];
    [self addTextInCourier:@"[csView addText:descriptionText];"];
    [self addTextInCourier:@"[csView addTitle:titleText2];"];
}

- (CSLinearLayoutView*)view;
{
    return (CSLinearLayoutView*)[super view];
}

- (void)addTextInCourier:(NSString*)text;
{
    UILabel *label = (UILabel*)[self.view addText:text].view;
    label.font = [UIFont fontWithName:@"Courier" size:12];
    [label sizeToFit];
}

@end
