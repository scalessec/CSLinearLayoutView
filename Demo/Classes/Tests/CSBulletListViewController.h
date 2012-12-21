//
//  CSBulletListViewController.h
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 4/29/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

@class CSBulletListView;

@interface CSBulletListViewController : UIViewController

@property (nonatomic, retain) IBOutlet CSBulletListView *bulletView;

- (void)reload;

@end
