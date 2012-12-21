//
//  CSBulletListItemView.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 4/29/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSBulletListItemView.h"

@interface CSBulletListItemView()

@property (nonatomic, retain) IBOutlet UILabel *itemLabel;

@end

@implementation CSBulletListItemView

@synthesize itemText = _itemText;
@synthesize itemLabel = _itemLabel;

- (void)awakeFromNib {
    _itemLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)setItemText:(NSString *)theItemText {
    if (_itemText != theItemText) {
        [_itemText release];
        _itemText = [theItemText retain];
    }
    
    _itemLabel.text = _itemText;
    CGSize textSize = [_itemLabel.text sizeWithFont:_itemLabel.font constrainedToSize:CGSizeMake(_itemLabel.bounds.size.width, NSIntegerMax) lineBreakMode:UILineBreakModeWordWrap];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, textSize.height);
}

- (void)dealloc {
    self.itemText = nil;
    self.itemLabel = nil;
    [super dealloc];
}

@end
