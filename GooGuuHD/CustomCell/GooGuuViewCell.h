//
//  GooGuuViewCell.h
//  MathMonsters
//
//  Created by Xcode on 13-11-14.
//  Copyright (c) 2013年 Xcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GooGuuViewCell : UITableViewCell

@property (nonatomic,retain) IBOutlet UIImageView *titleImgView;
@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UILabel *updateTimeLabel;
@property (nonatomic,retain) IBOutlet UILabel *backLabel;
@property (nonatomic,retain) IBOutlet UIWebView *conciseWebView;


@end
