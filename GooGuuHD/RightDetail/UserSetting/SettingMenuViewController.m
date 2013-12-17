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

@implementation SettingMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sections = @[@"登录/注册",@"清除缓存",@"意见反馈",@"新版本检测",@"使用说明",@"免责声明",@"关于我们"];
    
    UITableView *teT=[[[UITableView alloc] initWithFrame:CGRectMake(0,60,300,568)] autorelease];
    self.cusTable=teT;
    self.cusTable.backgroundColor = [Utiles colorWithHexString:@"#170D0A"];
    self.cusTable.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.cusTable.delegate = self;
    self.cusTable.dataSource = self;
    self.cusTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cusTable.opaque = NO;
    self.cusTable.backgroundColor = [UIColor blackColor];
    
    UIImageView *tableBack = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,300,768)] autorelease];
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
    /*cell.backgroundColor = [Utiles colorWithHexString:@"#170D0A"];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;*/
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
    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
        
        if (indexPath.section == 3) {
            
            static NSString *CellIdentifier = @"SettingCellIdentifier";
            SettingCell *cell = (SettingCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (!cell) {
                cell = [[[SettingCell alloc] initWithReuseIdentifier:CellIdentifier cellName:self.sections[indexPath.section]] autorelease];
            }

            return cell;
            
        } else {
            static NSString *CellIdentifier = @"Cell2";
            UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (!cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            }
            cell.textLabel.text = @"subtitle";
            return cell;
        }

    }else{
        static NSString *SettingCell2Identifier = @"SettingCell2Identifier";
        
        SettingCell2 *cell = (SettingCell2 *)[tableView dequeueReusableCellWithIdentifier:SettingCell2Identifier];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingCell2" owner:self options:nil] objectAtIndex:0];
        }
        [cell.itemBt setTitle:self.sections[indexPath.section] forState:UIControlStateNormal];
        cell.itemBt.tag = indexPath.section;
        [cell.itemBt addTarget:self action:@selector(itemBtClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

#pragma mark - Table view delegate

-(void)itemBtClicked:(UIButton *)bt {
    
    int section = bt.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    
    UINavigationController *navigationController = (UINavigationController *)self.frostedViewController.contentViewController;
    if (section == 0) {
        
        ClientLoginViewController *homeViewController = [[[ClientLoginViewController alloc] init] autorelease];
        homeViewController.sourceType=SettingMenu;
        [navigationController pushViewController:homeViewController animated:YES];
        [self.frostedViewController hideMenuViewController];
        
    } else if (section == 1) {
        sleep(1);
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
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
