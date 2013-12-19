//
//  TouristViewController.m
//  googuuhd
//
//  Created by Xcode on 13-12-16.
//  Copyright (c) 2013年 Xcode. All rights reserved.
//

#import "TouristViewController.h"

@interface TouristViewController ()

@end

@implementation TouristViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDisMiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [bt setTitle:@"确定" forState:UIControlStateNormal];
    [bt setFrame:CGRectMake(20,8,60,30)];
    bt.titleLabel.textAlignment = NSTextAlignmentLeft;
    bt.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:16.0];
    [bt addTarget:self action:@selector(viewDisMiss) forControlEvents:UIControlEventTouchUpInside];
    bt.backgroundColor = [UIColor carrotColor];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:bt];
	
    UIWebView *web = [[[UIWebView alloc] initWithFrame:CGRectMake(0,45,770,725)] autorelease];
    web.scrollView.showsVerticalScrollIndicator = NO;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iPadHelp" ofType:@"htm"];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
    [self.view addSubview:web];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
