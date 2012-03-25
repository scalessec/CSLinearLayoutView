//
//  CSAlignmentViewController.h
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 3/25/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLinearLayoutView.h"

@interface CSAlignmentViewController : UIViewController

@property (nonatomic, retain) IBOutlet CSLinearLayoutView *verticalLayoutView;
@property (nonatomic, retain) IBOutlet CSLinearLayoutView *horizontalLayoutView;

@end
