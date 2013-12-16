//
//  CSOrientationSwitchViewController.h
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/25/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSLinearLayoutView;

@interface CSOrientationSwitchViewController : UIViewController

@property (nonatomic, strong) IBOutlet CSLinearLayoutView *linearLayoutView;

- (IBAction)handleSwitchOrientations;

@end
