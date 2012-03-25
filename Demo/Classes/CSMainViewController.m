//
//  CSMainViewController.m
//  CSLinearLayoutViewDemo
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSMainViewController.h"
#import "CSLinearLayoutItem.h"
#import "CSVerticalViewController.h"
#import "CSHorizontalViewController.h"
#import "CSOrientationSwitchViewController.h"

@implementation CSMainViewController

#pragma mark - Factories

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"CSLinearLayoutView";
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - UITableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *viewController = nil;
    
    switch (indexPath.row) {
        case 0: {
            
            break;
        }
            
        case 1: {
            viewController = [[[CSVerticalViewController alloc] init] autorelease];
            break;
        }
            
        case 2: {
            viewController = [[[CSHorizontalViewController alloc] init] autorelease];
            break;
        }
            
        case 3: {
            viewController = [[[CSOrientationSwitchViewController alloc] init] autorelease];
            break;
        }
            
        case 4: {
            
            break;
        }
            
        case 5: {
            
            break;
        }
            
    }
    
    if (viewController != nil) {
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (indexPath.row) {
        case 0: 
            cell.textLabel.text = @"Real World Example"; 
            break;
            
        case 1: 
            cell.textLabel.text = @"Vertical Layout"; 
            break;
            
        case 2: 
            cell.textLabel.text = @"Horizontal Layout"; 
            break;
            
        case 3:
            cell.textLabel.text = @"Switching Orientations";
            break;
            
        case 4: 
            cell.textLabel.text = @"Alignment"; 
            break;
            
        case 5: 
            cell.textLabel.text = @"Fill Modes"; 
            break;
            
    }
    
    return cell;
}


#pragma mark - Memory Management

- (void)dealloc {
    [super release];
}

@end
