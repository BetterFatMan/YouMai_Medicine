//
//  SearchMedicineVC.m
//  MedicineCure
//
//  Created by line0 on 15/8/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "SearchMedicineVC.h"

@interface SearchMedicineVC ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITextField *_searchText;
    
    UITableView *_searchTable;
    
    NSMutableArray *_tableSectionList;
}

@end

@implementation SearchMedicineVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _tableSectionList = [NSMutableArray array];
        
        [_tableSectionList addObjectsFromArray:@[ @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z" ]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self addViewSubs];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchText resignFirstResponder];
}

#pragma mark - SubViews
- (void)addViewSubs
{
    [self addNaviBars];
    
    _searchTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kKeyWindow.width, kKeyWindow.height - 64) style:UITableViewStylePlain];
    _searchTable.backgroundColor = [UIColor clearColor];
    _searchTable.delegate   = self;
    _searchTable.dataSource = self;
    _searchTable.rowHeight  = 45;
    _searchTable.sectionHeaderHeight = 25;
    [self.view addSubview:_searchTable];
}

- (void)addNaviBars
{
    _searchText = [[UITextField alloc] initWithFrame:CGRectMake(70, 32, kKeyWindow.width - 135, 20)];
    _searchText.delegate = self;
    _searchText.backgroundColor = [UIColor clearColor];
    _searchText.textColor = kLBBlackColor;
    _searchText.textAlignment = NSTextAlignmentLeft;
    _searchText.font = gFontSystemSize(16);
    _searchText.placeholder = @"输入关键词，药名，治疗名";
    [self.navView addSubview:_searchText];
    
    UIButton *rightBtn        = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame            = CGRectMake(kKeyWindow.width - 44, 20, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"main_icon_search_gray"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightBtn];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVCViewGesture:)]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _tableSectionList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"com.left.cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    cell.textLabel.text = @"药品";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_tableSectionList objectAtIndexSafe:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _tableSectionList;
}

#pragma mark - UIButton Actions
- (void)clickRightBtn:(id)sender
{
    
}

- (void)tapVCViewGesture:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

@end
