//
//  FinanPicCollectCell.h
//  MathMonsters
//
//  Created by Xcode on 13-10-30.
//  Copyright (c) 2013年 Xcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinanPicCollectCell : UICollectionViewCell

-(void)setImage:(UIImage *)image;

@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic,retain) IBOutlet UILabel *sourceLabel;

@end