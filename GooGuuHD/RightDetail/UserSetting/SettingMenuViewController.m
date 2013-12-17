//
//  SettingMenuViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "SettingMenuViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "ClientLoginViewController.h"
#import "Cell1.h"
#import "Cell2.h"
#import "SettingCell2.h"
#import "SettingCell.h"
#import "FeedBackViewController.h"
#import "DisclaimersViewController.h"
#import "AboutUsViewController.h"
#import "VerticalTabBarViewController.h"

@implementation SettingMenuViewController

-(void)viewDidAppear:(BOOL)animated {
    [self.cusTable reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sections = @[@"登录/注册",@"清除缓存",@"意见反馈",@"新版本检测",@"使用说明",@"免责声明",@"关于我们"];
    
    UITableView *teT=[[[UITableView alloc] initWithFrame:CGRectMake(0,60,200,568)] autorelease];
    self.cusTable=teT;
    self.cusTable.backgroundColor = [Utiles colorWithHexString:@"#23120c"];
    self.cusTable.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.cusTable.delegate = self;
    self.cusTable.dataSource = self;
    self.cusTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cusTable.opaque = NO;
    self.cusTable.backgroundColor = [UIColor blackColor];
    
    UIImageView *tableBack = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,200,768)] autorelease];
    [tableBack setImage:[UIImage imageNamed:@"settingTableBack"]];
    [self.view addSubview:tableBack];
    
    self.cusTable.sectionFooterHeight = 0;
    self.cusTable.sectionHeaderHeight = 0;
    self.isOpen = NO;
    [self.view addSubview:self.cusTable];
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [Utiles colorWithHexString:@"#351C13"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen) {
        if (self.selectIndex.section == section) {
            return 2;
        }
    }
    return 1;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //展开的二级cell配置，对“新版本检测”使用单独配置
    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
        
        if (indexPath.section == 3) {
            static NSString *Grade2CellIdentifier = @"Grade2CellIdentifier";
            SettingCell *cell = (SettingCell *)[tableView dequeueReusableCellWithIdentifier:Grade2CellIdentifier];
            
            if (!cell) {
                cell = [[[SettingCell alloc] initWithReuseIdentifier:@"SettingCellIdentifier" cellName:self.sections[indexPath.section]] autorelease];
            }
            return cell;
        } else {
            return Nil;
        }

    }else{
        //一级cell配置
        static NSString *MainCellIdentifier = @"MainCellIdentifier";
        
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:MainCellIdentifier];
        
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MainCellIdentifier] autorelease];
        }
        if (indexPath.section == 0 && indexPath.row == 0) {
            
            if ([Utiles isLogin]) {
                cell.textLabel.text = @"注销";
            } else {
                cell.textLabel.text = self.sections[indexPath.section];
            }
            
        } else {
            cell.textLabel.text = self.sections[indexPath.section];
        }
        return cell;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = indexPath.section;
    
    UINavigationController *navigationController = (UINavigationController *)self.frostedViewController.contentViewController;
    if (section == 0) {
        if ([Utiles isLogin]) {
            [ComFun userLogoutcallBack:^(id obj) {
                if ([[obj objectForKey:@"status"] isEqualToString:@"1"]){
                    [Utiles ToastNotification:@"注销成功" andView:self.view andLoading:NO andIsBottom:NO andIsHide:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogOut" object:nil];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserToken"];
                    [tableView reloadData];
                    AppDelegate *delegate = GooGuuDelegate;
                    VerticalTabBarViewController *tabbar = delegate.verTabBar;
                    [tabbar configureLoginBt];
                } else if([[obj objectForKey:@"status"] isEqualToString:@"0"]) {
                    NSLog(@"logout failed:%@",[obj objectForKey:@"msg"]);
                }
            }];
        } else {
            ClientLoginViewController *homeViewController = [[[ClientLoginViewController alloc] init] autorelease];
            homeViewController.sourceType=SettingMenu;
            [navigationController pushViewController:homeViewController animated:YES];
            [self.frostedViewController hideMenuViewController];
        }
    } else if (section == 1) {
        [Utiles showToastView:self.view withTitle:nil andContent:@"清除成功" duration:1.0];
    } else if (section == 2) {
        FeedBackViewController *feedBack = [[[FeedBackViewController alloc] init] autorelease];
        feedBack.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:feedBack animated:YES completion:nil];
    } else if (section == 3) {
        if ([indexPath isEqual:self.selectIndex]) {
            self.isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            self.selectIndex = nil;
        }else{
            if (!self.selectIndex) {
                self.selectIndex = indexPath;
                [self didSelectCellRowFirstDo:YES nextDo:NO];
            }else{
                //[self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
    } else if (section == 4) {
        DisclaimersViewController *dis = [[[DisclaimersViewController alloc] init] autorelease];
        dis.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:dis animated:YES completion:nil];
    } else if (section == 5) {
        DisclaimersViewController *dis = [[[DisclaimersViewController alloc] init] autorelease];
        dis.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:dis animated:YES completion:nil];
    } else if (section == 6) {
        AboutUsViewController *about = [[[AboutUsViewController alloc] init] autorelease];
        about.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:about animated:YES completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    [self.cusTable beginUpdates];
    
    int section = self.selectIndex.section;
    int contentCount = 1;
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (firstDoInsert){
        [self.cusTable insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }else{
        [self.cusTable deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
	[rowToInsert release];
	
	[self.cusTable endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [self.cusTable indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [self.cusTable scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
