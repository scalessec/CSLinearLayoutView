//
//  CSBulletListViewController.h
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 4/29/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSBulletListView.h"

@interface CSBulletListViewController : UIViewController

@property (nonatomic, retain) IBOutlet CSBulletListView *bulletView;

- (void)reload;

@end
