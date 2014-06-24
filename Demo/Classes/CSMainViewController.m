//
//  CSMainViewController.m
//  CSLinearLayoutViewDemo
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSMainViewController.h"
#import "CSVerticalViewController.h"
#import "CSHorizontalViewController.h"
#import "CSOrientationSwitchViewController.h"
#import "CSAlignmentViewController.h"
#import "CSBulletListViewController.h"
#import "CSShortcutTestViewController.h"

@implementation CSMainViewController

#pragma mark - Factories

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"CSLinearLayoutView";
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    }
    return self;
}


#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - UITableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *viewController = nil;
    
    switch (indexPath.row) {
            
        case 0: {
            viewController = [[CSVerticalViewController alloc] init];
            break;
        }
            
        case 1: {
            viewController = [[CSHorizontalViewController alloc] init];
            break;
        }
            
        case 2: {
            viewController = [[CSOrientationSwitchViewController alloc] init];
            break;
        }
            
        case 3: {
            viewController = [[CSAlignmentViewController alloc] init];
            break;
        }
            
        case 4: {
            viewController = [[CSBulletListViewController alloc] init];
            break;
        }
            
        case 5: {
            viewController = [[[CSShortcutTestViewController alloc] init] autorelease];
            break;
        }
            
    }
    
    if (viewController != nil) {
        viewController.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}


#pragma mark - UITableView Data Source Methods 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CSLinearLayoutMainTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (indexPath.row) {
        case 0: 
            cell.textLabel.text = @"Vertical Layout"; 
            break;
            
        case 1: 
            cell.textLabel.text = @"Horizontal Layout"; 
            break;
            
        case 2:
            cell.textLabel.text = @"Switching Orientations";
            break;
            
        case 3: 
            cell.textLabel.text = @"Alignment"; 
            break;
            
        case 4:
            cell.textLabel.text = @"Sample Bullet List";
            break;
            
        case 5:
            cell.textLabel.text = @"Adding Shortcuts";
            break;
    }
    
    return cell;
}

@end
