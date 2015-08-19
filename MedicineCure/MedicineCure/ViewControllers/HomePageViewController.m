//
//  HomePageViewController.m
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "HomePageViewController.h"

#import "MedicineArticleVC.h"
#import "SearcherVC.h"
#import "SearchIllnessVC.h"
#import "SearchMedicineVC.h"
#import "UserLoginVC.h"
#import "BaseNavigationController.h"
#import "EditCalendarVC.h"

#import "SelectVersionsView.h"
#import "HomeTableHeaderView.h"
#import "IllnessNormalCell.h"
#import "HomeCureItemCell.h"
#import "HomeArticleCell.h"
#import "EditMedicineView.h"
#import "HomeSearchCell.h"

#import "IllnessEntity.h"
#import "ArticleEntity.h"
#import "CureItemEntity.h"

#import "CommonDataControl.h"

#define kCureTableTag   1000
#define kHomeTableTag   1001
#define kSearchTableTag 1002

@interface HomePageViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    UIScrollView *_backScrollView;
    
    UITableView  *_cureTable;
    UITableView  *_homeTable;
    UITableView  *_searchTable;
    
    UIButton     *_goTopBtn;
    
    CGFloat       scrollOffSetX;
    
    HomeTableHeaderView *_homeHeader;
    
    CommonDataControl *_commonControl;
}

@property(nonatomic, strong) NSMutableArray *cureItemList;
@property(nonatomic, strong) NSMutableArray *homeNoticeList;
@property(nonatomic, strong) NSMutableArray *homeArticalList;
@property(nonatomic, strong) NSArray        *searchTempList;
@property(nonatomic, strong) NSMutableArray *searcheThinList;

@property(nonatomic, strong) NSMutableArray *medicineList;

@property(nonatomic, copy) void (^selectTitleBlock)(NSInteger index);
@property(nonatomic, assign) NSInteger    selectedIndex;

@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _cureItemList = [NSMutableArray array];
        _homeNoticeList = [NSMutableArray array];
        _homeArticalList = [NSMutableArray array];
        _searcheThinList = [NSMutableArray array];
        _medicineList    = [NSMutableArray array];
        
        _searchTempList  = @[ @{@"icon" : @"", @"title" : @"输入关键词，药名，治疗名"}, @{@"icon" : @"search_illness", @"title" : @"疾病"}, @{@"icon" : @"search_medicine", @"title" : @"药品"}, @{@"icon" : @"search_cure", @"title" : @"关怀"} ];
        
        _commonControl   = [CommonDataControl new];
#if DEBUG
        NSDictionary *dic = @{ @"dayTime" : @"9月26日", @"imageUrl" : @"icon_main_chinese-meal", @"content" : @"住院日", @"detailContent" : @"圣玛利亚大医院", @"doneThins" : @"住院一共20天" };
        for (int i = 0; i < 6; i ++) {
            IllnessEntity *entity = [[IllnessEntity alloc] initWithDict:dic];
            if (entity) {
                entity.isTouday = NO;
                entity.imageType = i;
                if (i == 1) {
                    entity.isTouday = YES;
                }
                
                [_cureItemList addObject:entity];
            }
        }
        
//        [_homeNoticeList addObjectsFromArray:@[ @"癌症", @"癌症", @"癌症", @"癌症" ]];
//        [_homeArticalList addObjectsFromArray:@[ @"癌症", @"癌症", @"癌症", @"癌症", @"癌症", @"癌症" ]];
        [_searcheThinList addObjectsFromArray:@[ @"癌症", @"癌症", @"癌症", @"癌症", @"癌症", @"癌症", @"癌症", @"癌症", @"癌症", @"癌症", @"癌症", @"癌症" ]];
#endif
    }
    return self;
}

- (void)dealloc
{
    _selectTitleBlock = nil;
    [kNotificationCenter removeObserver:self];
    
    [_commonControl cancelOperation];
    _commonControl = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViewSubs];
    
    [kNotificationCenter addObserver:self selector:@selector(showUserLoginView:) name:kShowUserLoginView object:nil];
    [kNotificationCenter addObserver:self selector:@selector(getHomeInit) name:kRefreashHomeInit object:nil];
    if ([UserDefaultControl shareInstance].cacheLoginedUserEntity)
    {
        [self getHomeInit];
//        [self getMedicineList];
    }
}

#pragma mark - ViewSubs
- (void)addViewSubs
{
    [self addViewNaviBars];
    
    _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kKeyWindow.width, kKeyWindow.height - 64)];
    _backScrollView.delegate = self;
    _backScrollView.backgroundColor = kAppBgColor;
    _backScrollView.pagingEnabled = YES;
    [self.view addSubview:_backScrollView];
    _backScrollView.contentSize = CGSizeMake(kKeyWindow.width * 3, 0);
    _backScrollView.showsHorizontalScrollIndicator = NO;
    
    [self addCureTalbes];
    
    _homeTable = [[UITableView alloc] initWithFrame:CGRectMake(kKeyWindow.width, 0, kKeyWindow.width, _backScrollView.height) style:UITableViewStylePlain];
    _homeTable.backgroundColor = [UIColor lightGrayColor];
    _homeTable.dataSource = self;
    _homeTable.delegate   = self;
    _homeTable.tag = kHomeTableTag;
    _homeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_backScrollView addSubview:_homeTable];
    
    [self createHomeHeader];
    
    _goTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _goTopBtn.frame = CGRectMake(kKeyWindow.width*2 - 50, _backScrollView.height - 65, 35, 35);
    _goTopBtn.backgroundColor = [UIColor lightGrayColor];
    [_goTopBtn addTarget:self action:@selector(clickGetTopView:) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:_goTopBtn];
    _goTopBtn.hidden = YES;
    
    _searchTable = [[UITableView alloc] initWithFrame:CGRectMake(kKeyWindow.width*2, 0, kKeyWindow.width, _backScrollView.height) style:UITableViewStylePlain];
    _searchTable.backgroundColor = [UIColor whiteColor];
    _searchTable.dataSource = self;
    _searchTable.delegate   = self;
    _searchTable.tag = kSearchTableTag;
    _searchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_backScrollView addSubview:_searchTable];
    
    [_backScrollView setContentOffset:CGPointMake(kKeyWindow.width, 0) animated:YES];
}

- (void) addCureTalbes
{
    UIImageView *backImage = [UIImageView new];
    backImage.frame = CGRectMake(0, 0, kKeyWindow.width, _backScrollView.height);
    backImage.backgroundColor = kLightGreenBtnColor;
    [_backScrollView addSubview:backImage];
    
    UIView *lineView = [UIView new];
    lineView.frame = CGRectMake(kKeyWindow.width/3.0, 0, 1, _backScrollView.height);
    lineView.backgroundColor = kRedColor;
    [_backScrollView addSubview:lineView];
    
    _cureTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kKeyWindow.width, _backScrollView.height - 35) style:UITableViewStylePlain];
    _cureTable.backgroundColor = [UIColor clearColor];
    _cureTable.dataSource = self;
    _cureTable.delegate   = self;
    _cureTable.tag = kCureTableTag;
    _cureTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_backScrollView addSubview:_cureTable];
    
    UIButton *cureBotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cureBotBtn.frame               = CGRectMake(0, _backScrollView.height - 35, kKeyWindow.width, 35);
    cureBotBtn.backgroundColor = kRedColor;
    [cureBotBtn setTitle:@"提示：一键添加你的健康状态" forState:UIControlStateNormal];
    [cureBotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cureBotBtn.titleLabel.font = gFontSystemSize(15);
    [cureBotBtn addTarget:self action:@selector(clickCureBotBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:cureBotBtn];
}

- (void)createHomeHeader
{
    if (!_homeHeader) {
        HomeTableHeaderView *header = [[HomeTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kKeyWindow.width, 305)];
        __weak typeof(self) _wself = self;
        header.getSearcherVCBlock = ^(){
            SearcherVC *search = [SearcherVC new];
            [_wself.navigationController pushViewController:search animated:YES];
        };
        header.addMedicineBlock = ^(){
            EditMedicineView *temp = [[EditMedicineView alloc] initWithFrame:self.view.bounds];
            
            [_wself.view addSubview:temp];
            [temp beginViewAnimation];
            
            temp.medicineSuccessBlock = ^(){
                [_wself getHomeInit];
            };
        };
        _homeHeader = header;
    }
    
    _homeHeader.medicineList = _medicineList;
    
    _homeTable.tableHeaderView = _homeHeader;
}

- (void)addViewNaviBars
{
    UIButton *backBtn           = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame               = CGRectMake(0, 20, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"icon_homeUser"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftBtn = backBtn;
    
    UIButton *rightBtn           = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame               = CGRectMake(self.navView.width - 44, 20, 44, 44);
    rightBtn.backgroundColor     = [UIColor clearColor];
    [rightBtn setImage:[UIImage imageNamed:@"icon_hometx"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightNaviBar:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightBtn];
    
        /// 介绍title
    UIButton *cureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cureBtn.frame = CGRectMake(kKeyWindow.width/2 - 65, 24, 35, 35);
    cureBtn.backgroundColor = [UIColor clearColor];
    [cureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cureBtn setImage:[UIImage imageNamed:@"icon_homefolder"] forState:UIControlStateNormal];
    [cureBtn setImage:[UIImage imageNamed:@"icon_homefolder_selected"] forState:UIControlStateSelected];
    cureBtn.tag = 0;
    [self.navView addSubview:cureBtn];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(kKeyWindow.width/2 - 17.5, 24, 35, 35);
    homeBtn.backgroundColor = [UIColor clearColor];
    [homeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [homeBtn setImage:[UIImage imageNamed:@"icon_homeall"] forState:UIControlStateNormal];
    [homeBtn setImage:[UIImage imageNamed:@"icon_homeall_selected"] forState:UIControlStateSelected];
    homeBtn.tag = 1;
    [self.navView addSubview:homeBtn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(kKeyWindow.width/2 + 30, 24, 35, 35);
    searchBtn.backgroundColor = [UIColor clearColor];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"icon_homebk"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"icon_homebk_selected"] forState:UIControlStateSelected];
    searchBtn.tag = 2;
    [self.navView addSubview:searchBtn];
    
    __weak typeof(cureBtn) _wcure = cureBtn;
    __weak typeof(homeBtn) _whome = homeBtn;
    __weak typeof(searchBtn) _wsearch = searchBtn;
    __weak typeof(self) _wself = self;
    
    _selectTitleBlock = ^(NSInteger index){
        switch (_wself.selectedIndex) {
            case 0:
                _wcure.selected = NO;
                break;
            case 1:
                _whome.selected = NO;
                break;
            case 2:
                _wsearch.selected = NO;
                break;
                
            default:
                break;
        }
        switch (index) {
            case 0:
                _wcure.selected = YES;
                break;
            case 1:
                _whome.selected = YES;
                break;
            case 2:
                _wsearch.selected = YES;
                break;
                
            default:
                break;
        }
    };
    
    [cureBtn addTarget:self action:@selector(clickNaviTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [homeBtn addTarget:self action:@selector(clickNaviTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn addTarget:self action:@selector(clickNaviTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - HTTP Requests
- (void)getHomeInit
{
    __weak typeof(self) _wself = self;
    [_commonControl homeInit:@{ @"userId" : @([UserDefaultControl shareInstance].cacheLoginedUserEntity.userId) } withCompleteBlock:^(BOOL isSuccess, NSArray *items, NSArray *ummList,NSArray *utmList, NSError *error) {
        if (isSuccess)
        {
            [_wself.homeArticalList addObjectsFromArray:items];
            [_wself.homeNoticeList addObjectsFromArray:utmList];
            [_wself homeReload];
            
            [_wself.medicineList removeAllObjects];
            [_wself.medicineList addObjectsFromArray:ummList];
            [_wself createHomeHeader];
        }
        else
        {
            mAlertView(@"提示", error.errMsg);
        }
    }];
}

- (void)getMedicineList
{
    __weak typeof(self) _wself = self;
    [_commonControl getMedicineList:@{ @"userId" : @([UserDefaultControl shareInstance].cacheLoginedUserEntity.userId), @"toPage":@"1",@"pageRows":@"10" } withCompleteBlock:^(BOOL isSuccess, NSArray *medicineList, NSError *error) {
        if (isSuccess)
        {
            
        }
        else
        {
            mAlertView(@"提示", error.errMsg);
        }
    }];
}

- (void)homeReload
{
    [_homeTable reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == kHomeTableTag || tableView.tag == kSearchTableTag) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == kCureTableTag) {
        return _cureItemList.count;
    }
    if (tableView.tag == kHomeTableTag) {
        return section == 0 ? _homeNoticeList.count + 1 : _homeArticalList.count;
    }
    if (tableView.tag == kSearchTableTag) {
        return section == 0 ? _searchTempList.count : _searcheThinList.count;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == kCureTableTag) {
        IllnessEntity *illEntiy = [_cureItemList objectAtIndexSafe:indexPath.row];
        if (illEntiy && illEntiy.isTouday) {
            static NSString *illCellstr = @"com.home.ill.today";
            IllnessTodayCell *cell = [tableView dequeueReusableCellWithIdentifier:illCellstr];
            if (!cell) {
                cell = [[IllnessTodayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:illCellstr];
            }
            cell.illEntity = illEntiy;
            return cell;
            
        } else if (illEntiy && !illEntiy.isTouday) {
            static NSString *illCellstr = @"com.home.ill.normal";
            IllnessNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:illCellstr];
            if (!cell) {
                cell = [[IllnessNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:illCellstr];
                
                __weak typeof(self) _wself = self;
                cell.tapImageBlock = ^(IllnessEntity *entity){
                    
                    EditCalendarVC *calendar = [EditCalendarVC new];
                    calendar.illEntity = entity;
                    [_wself.navigationController pushViewController:calendar animated:YES];
                };
            }
            
            cell.illEntity = illEntiy;
            return cell;
        }
    }
    
    if (tableView.tag == kHomeTableTag) {
        if (indexPath.section == 0) {
            if (indexPath.row == _homeNoticeList.count) {
                static NSString *cellIdentify = @"com.home.temp.edit.cell";
                
                HomeEditItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
                if (!cell) {
                    cell = [[HomeEditItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
                }
                
                return cell;
            }
            static NSString *identity = @"com.home.cure.cell";
            HomeCureItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
            if (!cell) {
                cell = [[HomeCureItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            }
            
            cell.topLine.hidden = indexPath.row == 0 ? NO : YES;
            return cell;
        } else {
            static NSString *identity = @"com.home.article.cell";
            HomeArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
            if (!cell) {
                cell = [[HomeArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            }
            
            cell.entity = [_homeArticalList objectAtIndexSafe:indexPath.row];
            
            return cell;
        }
    }
    if (tableView.tag == kSearchTableTag) {
        if (indexPath.section == 0) {
            static NSString *cellIdentify = @"com.home.search.cell";
            
            HomeSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            if (!cell) {
                cell = [[HomeSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            }
            
            cell.cellImage.image = UIImageByName([[_searchTempList objectAtIndexSafe:indexPath.row] safeBindStringValue:@"icon"]);
            cell.searchLable.text  = [[_searchTempList objectAtIndexSafe:indexPath.row] safeBindStringValue:@"title"];
            cell.accessoryType   = UITableViewCellAccessoryNone;
            if (indexPath.row > 0) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            cell.searchLable.font = gFontSystemSize(15);
            cell.searchLable.textColor = kBBlackColor;
            if (indexPath.row == 0) {
                cell.searchLable.font = gFontSystemSize(13);
                cell.searchLable.textColor = kLLBBlackColor;
            }
            
            return cell;
        }
        if (indexPath.section == 1) {
            static NSString *cellIdentify = @"com.search.allLike.cell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
                cell.textLabel.font = gFontSystemSize(15);
                cell.textLabel.textColor = kLLBBlackColor;
            }
            cell.textLabel.text = [_searcheThinList objectAtIndexSafe:indexPath.row];
            return cell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == kHomeTableTag) {
        if (indexPath.section == 1)
        {
            MedicineArticleVC *article = [MedicineArticleVC new];
            if (indexPath.row == 0) {
                article.articleEntity = [_homeArticalList objectAtIndexSafe:indexPath.row];
            }
            [self.navigationController pushViewController:article animated:YES];
        } else {
            if (indexPath.row == _homeNoticeList.count) {
                SelectVersionsView *versions = [[SelectVersionsView alloc] initWithFrame:CGRectMake(0, 0, kKeyWindow.width *2, kKeyWindow.height)];
                [self.view addSubview:versions];
                [versions beginViewAnimation];
            }
        }
        
    }
    if (tableView.tag == kSearchTableTag) {
        if (indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 2)) {
            if (indexPath.row == 1) {
                SearchIllnessVC *illness = [SearchIllnessVC new];
                [self.navigationController pushViewController:illness animated:YES];
            } else {
                SearchMedicineVC *medicine = [SearchMedicineVC new];
                [self.navigationController pushViewController:medicine animated:YES];
            }
        } else {
            SearcherVC *search = [SearcherVC new];
            [self.navigationController pushViewController:search animated:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == kCureTableTag) {
        IllnessEntity *entity = [_cureItemList objectAtIndexSafe:indexPath.row];
        return entity && entity.isTouday ? [IllnessTodayCell drawCellHeight] : [IllnessNormalCell drawCellHeight];
    }
    if (tableView.tag == kHomeTableTag) {
        return indexPath.section == 0 ? [HomeCureItemCell drawCellHeight] : [HomeArticleCell drawCellHeight];
    }
    if (tableView.tag == kSearchTableTag) {
        return indexPath.section == 0 ? [HomeSearchCell drawCellHeight] : 45;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == kSearchTableTag && section == 1) {
        return 25;
    }
    if (tableView.tag == kHomeTableTag && section == 1) {
        return 25;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == kSearchTableTag && section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kKeyWindow.width, 25)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 250, 25)];
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = kYMLightRedColor;
        title.font      = gFontSystemSize(16);
        title.text      = @"大家都在搜";
        [view addSubview:title];

        return view;
    }
    if (tableView.tag == kHomeTableTag && section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kKeyWindow.width, 25)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 250, 25)];
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = kIconsYellowColor;
        title.font      = gFontSystemSize(16);
        title.text      = @"大家都在看";
        [view addSubview:title];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, 24.5, kKeyWindow.width - 6, 0.5)];
        line.backgroundColor = kLineGrayColor;
        [view addSubview:line];
        
        return view;
    }
    return nil;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _backScrollView) {
        CGFloat x = scrollView.contentOffset.x;
        NSInteger index;
        if (x < kKeyWindow.width) {
            index = 0;
        } else if (x < kKeyWindow.width*2) {
            index = 1;
        } else {
            index = 2;
        }
        if (_selectTitleBlock) {
            _selectTitleBlock(index);
            _selectedIndex = index;
        }
    }
    if (scrollView == _homeTable) {
        CGFloat y = scrollView.contentOffset.y;
        CGFloat height = scrollView.contentSize.height;
        
        _goTopBtn.hidden = y > height/3 + 50 ? NO : YES;
    }
}

#pragma mark - UIButton Actions
- (void)backBtnClick:(id)sender
{
    if (_drawer.drawerState == ICSDrawerControllerStateClosed) {
        [_drawer open];
    } else if (_drawer.drawerState == ICSDrawerControllerStateOpen) {
        [_drawer close];
    }
}

- (void)clickRightNaviBar:(id)sender
{
    
}

- (void)clickCureBotBtn:(id)sender
{
    [self.navigationController pushViewController:[EditCalendarVC new] animated:YES];
}

- (void)clickGetTopView:(id)sender
{
    [_homeTable setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)clickNaviTitleBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [_backScrollView setContentOffset:CGPointMake(kKeyWindow.width*btn.tag, 0) animated:YES];
}

#pragma mark - Notice
- (void)showUserLoginView:(NSNotification *)notice
{
    [_drawer presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[UserLoginVC new]] animated:YES completion:nil];
}

@end
