//
//  BaseViewController.h
//  Line0new
//
//  Created by trojan on 14-8-28.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic, strong) UIView     *navView;
@property(nonatomic, strong) UIButton   *leftBtn;
@property(nonatomic, strong) UILabel    *titleLab;

@property(nonatomic, strong) UIImageView *arrownImage;

@property(nonatomic, strong) NSString   *noDataTipsImgName;
@property(nonatomic, strong) NSString   *noDataTipsStr;
    /// 是否有需要显示无数提示图片
@property(nonatomic, assign) BOOL       isNeedShowNoDataTips;
    /// 如果当前页面支持友盟的页面路径统计就设置该值
@property(nonatomic, strong) NSString   *umengPageName;

@property(nonatomic, assign) BOOL        wrightName;
    /// 是否不需要右滑返回上一页的手势(默认需要)
@property(nonatomic,   copy) void       (^backBtnClickCallback)();
    /// 是否显示蓝色nav样式 默认为NO
@property(nonatomic, assign) BOOL       isShowBlueNavStyle;
    /// 手引号图片数组
@property(nonatomic, strong) NSArray    *guideImgArray;

    /// 右滑返回上一页的手势处理事件 子类可以覆盖重写
- (void)backSwipeGuesture:(UISwipeGestureRecognizer *)gesture;
- (void)backBtnClick:(UIButton *)sender;
    /// 显示新手引导
- (void)showGuideImgView:(void (^)(void))finishedBlock;

@end
