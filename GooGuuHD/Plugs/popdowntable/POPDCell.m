//
//  POPDCell.m
//  popdowntable
//
//  Created by Alex Di Mango on 15/09/2013.
//  Copyright (c) 2013 Alex Di Mango. All rights reserved.
//

#import "POPDCell.h"

@implementation POPDCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
