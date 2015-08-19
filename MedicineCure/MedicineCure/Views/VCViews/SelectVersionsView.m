//
//  SelectVersionsView.m
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "SelectVersionsView.h"
#import "PickDayView.h"
#import "EditTreatmentView.h"

@interface SelectVersionsView ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView      *_backView;
    
    UITableView *_itemTable;
    
    UIButton    *_firstBtn;
    UIButton    *_secondBtn;
    UIButton    *_bottomBtn;
    
    NSArray     *_itemsList;
}
@end

@implementation SelectVersionsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kKeyWindow.width, CGRectGetHeight(frame))];
        _backView.backgroundColor = UICOLOR_RGBA(1, 1, 1, 0.6);
        [self addSubview:_backView];
        
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame = CGRectMake((kKeyWindow.width - 50)/2, kKeyWindow.height - 70, 50, 50);
        [_bottomBtn setImage:UIImageByName(@"large_x") forState:UIControlStateNormal];
        [self addSubview:_bottomBtn];
        [_bottomBtn addTarget:self action:@selector(endViewAnimation) forControlEvents:UIControlEventTouchUpInside];
        
        _secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _secondBtn.frame = CGRectMake(30, _bottomBtn.top - 56, kKeyWindow.width - 60, 45);
        _secondBtn.backgroundColor = UICOLOR_RGB(20, 50, 200);
        _secondBtn.titleLabel.font = gFontSystemSize(16);
        [_secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_secondBtn setTitle:@"未开始治疗" forState:UIControlStateNormal];
        [self addSubview:_secondBtn];
        [_secondBtn addTarget:self action:@selector(clickSecondBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _firstBtn.frame = CGRectMake(30, _secondBtn.top - 56, kKeyWindow.width - 60, 45);
        _firstBtn.backgroundColor = UICOLOR_RGB(20, 50, 200);
        _firstBtn.titleLabel.font = gFontSystemSize(16);
        [_firstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_firstBtn setTitle:@"我已康复" forState:UIControlStateNormal];
        [self addSubview:_firstBtn];
        [_firstBtn addTarget:self action:@selector(clickFirstBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _itemsList = @[ @"手术", @"化疗", @"放疗", @"靶向" ];
        
        _itemTable = [[UITableView alloc] initWithFrame:CGRectMake(25, _firstBtn.top - (45*4 + 15), kKeyWindow.width - 50, 45*4) style:UITableViewStylePlain];
        _itemTable.rowHeight  = 45;
        _itemTable.dataSource = self;
        _itemTable.delegate   = self;
        _itemTable.scrollEnabled = NO;
        [self addSubview:_itemTable];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"com.SelectVersions.cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font          = gFontSystemSize(17);
        cell.textLabel.textColor     = kLightBlueColor;
    }
    
    cell.textLabel.text = [_itemsList objectAtIndexSafe:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditTreatmentView *temp = [[EditTreatmentView alloc] initWithFrame:self.bounds];
    temp.left = kKeyWindow.width;
    temp.treatmentId = indexPath.row+1;
    temp.ttitle = [_itemsList objectAtIndexSafe:indexPath.row];
    [self addSubview:temp];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.left = -kKeyWindow.width;
    }];
    __weak typeof(self) _wself = self;
    temp.completeBlock = ^(){
        [_wself endViewAnimation];
    };
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIButton Actions
- (void)clickFirstBtn:(id)sender
{
    
}

- (void)clickSecondBtn:(id)sender
{
    
}

- (void)beginViewAnimation
{
    _backView.alpha = 0;
    self.top  = kKeyWindow.height;
    [UIView animateWithDuration:0.35 animations:^{
        _backView.alpha = 1.0;
        self.top = 0;
    }];
}

- (void)endViewAnimation
{
    [UIView animateWithDuration:0.35 animations:^{
        _backView.alpha = 0;
        self.top  = kKeyWindow.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
