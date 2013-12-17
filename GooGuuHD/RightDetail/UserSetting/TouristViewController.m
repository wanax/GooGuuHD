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

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIWebView *web = [[[UIWebView alloc] initWithFrame:CGRectMake(0,0 , 768,600)] autorelease];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HELP" ofType:@"html"];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
    [self.view addSubview:web];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
