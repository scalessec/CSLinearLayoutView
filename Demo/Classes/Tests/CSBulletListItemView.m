//
//  CSBulletListItemView.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 4/29/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSBulletListItemView.h"

@interface CSBulletListItemView()

@property (nonatomic, strong) IBOutlet UILabel *itemLabel;

@end

@implementation CSBulletListItemView

@synthesize itemText = _itemText;
@synthesize itemLabel = _itemLabel;

- (void)awakeFromNib {
    _itemLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)setItemText:(NSString *)itemText {
    _itemText = itemText;
    
    _itemLabel.text = _itemText;
    CGSize textSize = [_itemLabel.text sizeWithFont:_itemLabel.font constrainedToSize:CGSizeMake(_itemLabel.bounds.size.width, NSIntegerMax) lineBreakMode:NSLineBreakByWordWrapping];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, textSize.height);
}

@end
