//
//  CSBulletListViewController.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 4/29/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSBulletListViewController.h"
#import "CSBulletListView.h"
#import "NSString+LoremIpsum.h"

@implementation CSBulletListViewController

@synthesize bulletView = _bulletView;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *reloadButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStyleBordered target:self action:@selector(reload)];
    self.navigationItem.rightBarButtonItem = reloadButtonItem;
    
    [self reload];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.bulletView = nil;
}

#pragma mark - Events

- (void)reload {
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:3];
    
    NSInteger numberOfBullets = (arc4random() % 15) + 5;
    
    for (uint i=0; i < numberOfBullets; i++) {
        NSInteger numberOfSentences = (arc4random() % 5) + 1;
        NSString *text = [NSString loremIpsumSentences:numberOfSentences];
        [list addObject:text];
    }
    
    _bulletView.list = list;
}

@end
