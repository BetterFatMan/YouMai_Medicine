//
//  LWaitingView.h
//  Line0New
//
//  Created by line0 on 13-4-28.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import <UIKit/UIKit.h>

    // 覆盖navibar以下的页面
@interface LWaittingView : UIView

+ (id)sharedInstance;

- (void)showWaittingView;
- (void)hideWaittingView;


@end
