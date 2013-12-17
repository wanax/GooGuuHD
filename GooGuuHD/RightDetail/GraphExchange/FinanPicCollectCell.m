//
//  FinanPicCollectCell.m
//  MathMonsters
//
//  Created by Xcode on 13-10-30.
//  Copyright (c) 2013年 Xcode. All rights reserved.
//

#import "FinanPicCollectCell.h"
#import "CustomCellBackground.h"



@implementation FinanPicCollectCell


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        CustomCellBackground *backgroundView = [[CustomCellBackground alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = backgroundView;
        self.backgroundColor=[Utiles colorWithHexString:@"#FDFAEE"];
        self.sourceLabel.backgroundColor=[Utiles colorWithHexString:@"#FDFAEE"];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    CustomCellBackground *backgroundView = [[CustomCellBackground alloc] initWithFrame:CGRectZero];
    self.selectedBackgroundView = backgroundView;
    
    return self;
}

-(void)prepareForReuse
{
    [self setImage:nil];
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

@end
