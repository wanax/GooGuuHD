//
//  GraphExchangeViewController.m
//  MathMonsters
//
//  Created by Xcode on 13-9-26.
//  Copyright (c) 2013年 Xcode. All rights reserved.
//

#import "GraphExchangeViewController.h"
#import "FinancePicViewController.h"
#import "FlatUIKit.h"

@interface GraphExchangeViewController ()

@end

@implementation GraphExchangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[Utiles colorWithHexString:@"#5b4d41"];
    [self initComponents];
}

-(void)initComponents{
    
    [self addLabel:@"金融图汇" frame:CGRectMake(45,15,80,30) size:20.0 color:@"#e6cbc0"];
    [self addLabel:@"是不是看腻了大把的文字描述？来\"金融图汇放松一下，这里汇聚了各大媒体对金融数据和现象的图解解读，金融图谱虽简，洞悉经济生活。\"" frame:CGRectMake(45,55,600,50) size:18.0 color:@"#ffffff"];
    [self addLabel:@"热门标签" frame:CGRectMake(65,115,80,30) size:14.0 color:@"#e6cbc0"];
    UIImageView *tagImg=[[[UIImageView alloc] initWithFrame:CGRectMake(45,122,15,15)] autorelease];
    [tagImg setImage:[UIImage imageNamed:@"littleTag"]];
    [self.view addSubview:tagImg];
    
    UISearchBar *bar=[[[UISearchBar alloc] initWithFrame:CGRectMake(700,10,200,44)] autorelease];
    bar.delegate=self;
    bar.placeholder=@"搜图";
    bar.backgroundColor=[UIColor clearColor];
    bar.barTintColor=[UIColor clearColor];
    [self.view addSubview:bar];
    
    [self getTopTag];
    
    FinancePicViewController *picVC=[[[FinancePicViewController alloc] init] autorelease];
    [picVC.view setFrame:CGRectMake(30,150,725,865)];
    [self.view addSubview:picVC.view];
    [self addChildViewController:picVC];
    self.delegate=picVC;
    
}

-(void)getTopTag {
    
    [Utiles getNetInfoWithPath:@"GetTopTag" andParams:nil besidesBlock:^(id obj) {
        
        int n = 130,m=0;
        for (id tag in obj) {
            if ((m++) > 8) {
                break;
            }
            [self addButtons:tag[@"keyword"] fun:@selector(tagBtClicked:) frame:CGRectMake(n,115,70,30)];
            n += 80;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark -
#pragma Search Bar Methods Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.delegate keyWordChanged:searchBar.text];
    [self.searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark Button Action

-(void)tagBtClicked:(FUIButton *)bt{
    
    [self.delegate keyWordChanged:bt.titleLabel.text];
    
}


#pragma mark -
#pragma mark Button && Label

-(UILabel *)addLabel:(NSString *)name frame:(CGRect)frame size:(float)size color:(NSString *)color{
    UILabel *label=[[[UILabel alloc] initWithFrame:frame] autorelease];
    [label setText:name];
    [label setFont:[UIFont fontWithName:@"Heiti SC" size:size]];
    [label setTextColor:[Utiles colorWithHexString:color]];
    [label setTextAlignment:NSTextAlignmentLeft];
    label.lineBreakMode=NSLineBreakByCharWrapping;
    label.numberOfLines=2;
    [self.view addSubview:label];
    return  label;
}

-(void)addButtons:(NSString *)title fun:(SEL)fun frame:(CGRect)rect{
    
    FUIButton *bt=[FUIButton buttonWithType:UIButtonTypeCustom];
    [bt.titleLabel setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setFrame:rect];
    bt.buttonColor = [Utiles colorWithHexString:@"#E1B58D"];
    [bt setSelected:YES];
    bt.shadowHeight = 2.0f;
    bt.cornerRadius = 0.0f;
    [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bt addTarget:self action:fun forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}

- (BOOL)shouldAutorotate{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
