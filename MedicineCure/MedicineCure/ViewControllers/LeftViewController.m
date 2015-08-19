//
//  LeftViewController.m
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "LeftViewController.h"

#import "SettingInfoVC.h"

#define kLeftViewWidth 260

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIView      *_topView;
    UIImageView *_userImage;
    UILabel     *_userNameLable;
    UITableView *_leftTable;
    
    NSArray     *_leftTableData;
    
    UIButton    *_botLeftBtn;
    UIButton    *_botRightBtn;
}

@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        _leftTableData = @[ @"收藏", @"病例", @"说明书" ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addViewAtSub];
}

#pragma mark - SubViews
- (void)addViewAtSub
{
    _topView = [self createTopView];
    [self.view addSubview:_topView];
    
    _leftTable = [[UITableView alloc]initWithFrame:CGRectMake(5, _topView.bottom + 5, kLeftViewWidth - 10, 45*3) style:UITableViewStylePlain];
    _leftTable.dataSource = self;
    _leftTable.delegate   = self;
    _leftTable.rowHeight  = 45;
    _leftTable.scrollEnabled = NO;
    [self.view addSubview:_leftTable];
    
    _botLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _botLeftBtn.frame = CGRectMake(0, kKeyWindow.height - 50, kLeftViewWidth/2, 50);
    [_botLeftBtn setTitle:@"病人版" forState:UIControlStateNormal];
    [_botLeftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _botLeftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:_botLeftBtn];
    
    _botRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _botRightBtn.frame = CGRectMake(_botLeftBtn.right, _botLeftBtn.top, _botLeftBtn.width, _botLeftBtn.height);
    [_botRightBtn setTitle:@"健康版" forState:UIControlStateNormal];
    [_botRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _botRightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:_botRightBtn];
    
    _botLeftBtn.backgroundColor = kLightBlueColor;
    _botRightBtn.backgroundColor = kLightGreenBtnColor;
    [_botLeftBtn addTarget:self action:@selector(clickBottomLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_botRightBtn addTarget:self action:@selector(clickBottomRightBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIView *)createTopView
{
    UIView *bgViewc = [UIView new];
    bgViewc.frame = CGRectMake(0, 0, kLeftViewWidth, 120);
    bgViewc.backgroundColor = UICOLOR_RGBA(180, 90, 70, 0.8);
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kLeftViewWidth - 40, 22, 35, 35);
    settingBtn.backgroundColor = [UIColor lightGrayColor];
    [settingBtn addTarget:self action:@selector(clickSettingBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgViewc addSubview:settingBtn];
    
    _userImage = [[UIImageView alloc] initWithFrame:CGRectMake((kLeftViewWidth - 88)/2, 33, 88, 88)];
    _userImage.backgroundColor = kLightBlueColor;
    _userImage.layer.borderColor = kLineGrayColor.CGColor;
    _userImage.layer.borderWidth = 0.5;
    _userImage.layer.cornerRadius = 44;
    _userImage.clipsToBounds = YES;
    [bgViewc addSubview:_userImage];
    
    _userImage.userInteractionEnabled = YES;
    [_userImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserImageView:)]];
    
    _userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(15, _userImage.bottom + 5, kLeftViewWidth - 30, 20)];
    _userNameLable.textAlignment = NSTextAlignmentCenter;
    _userNameLable.textColor = kBBlackColor;
    _userNameLable.font = gFontSystemSize(19);
    _userNameLable.text = @"何  小姐";
    [bgViewc addSubview:_userNameLable];
    
    bgViewc.height = _userNameLable.bottom + 5;
    return bgViewc;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"com.left.cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    cell.textLabel.text = [_leftTableData objectAtIndexSafe:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
                //从相册选择
            [self localPhoto];
            break;
        case 1:
                //拍照
            [self takePhoto];
            break;
    }
}

    //从相册选择
-(void)localPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
        //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

    //拍照
-(void)takePhoto
{
        //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
            //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
            //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        mAlertView(@"提示", @"该设备无摄像头");
    }
}

#pragma Delegate method UIImagePickerControllerDelegate
    //图像选取器的委托方法，选完图片后回调该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image
{
//    UIImage *smallImage = [self imageWithImage:image scaledToSize:CGSizeMake(100, 100)];
//    NSData *data = UIImageJPEGRepresentation(smallImage, 1.0f);
//    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        //文件管理器
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
//    NSString *fileName = [NSString stringWithFormat:@"%@%.0lf.png",[GlobalControl shareInstance].loginUser.userToken,[[NSDate date] timeIntervalSince1970]];
//        //得到选择后沙盒中图片的完整路径
//    NSString *filePath = [[NSString alloc]initWithFormat:@"%@/%@",DocumentsPath,fileName];
//    [fileManager createFileAtPath:filePath contents:data attributes:nil];
//    NSDictionary *files = @{fileName: filePath};
//    
//    __weak typeof(self) _wself = self;
//    [_userDataCtrl uploadUserHeadImage:kUploadUserHeadImage params:nil files:files completeBlock:^(BOOL isSuccess, NSError *err, NSString *picUrl)
//     {
//         [[LWaittingView sharedInstance] hideWaittingView];
//         if (isSuccess)
//         {
//             UserEntity *userEntity = [UserDefaultControl shareInstance].cacheLoginedUserEntity;
//             userEntity.picUrlBig = picUrl;
//             [UserDefaultControl shareInstance].cacheLoginedUserEntity = userEntity;
//             [GlobalControl shareInstance].loginUser.picUrlBig = picUrl;
//             [_wself.tableView reloadData];
//             dispatch_main_sync_safe(^{
//                 
//                 [kNotificationCenter postNotificationName:kUpdateUserInfo object:nil];
//             });
//         }
//         else
//         {
//             mAlertView(@"提示", @"修改头像失败");
//         }
//     }];
}

    ///保持原来的长宽比，生成一个缩略图
-(UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UIButton Actions
- (void)clickSettingBtn:(id)sender
{
    [_drawer reloadCenterViewControllerUsingBlock:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SettingInfoVC *setting = [SettingInfoVC new];
        [_drawer presentViewController:setting animated:YES completion:nil];
    });
}

- (void)tapUserImageView:(UITapGestureRecognizer *)gesture
{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"从相册中选取", @"拍照", nil];
    [choiceSheet showInView:self.view];
}

- (void)clickBottomLeftBtn:(id)sender
{
    [_drawer reloadCenterViewControllerUsingBlock:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UserDefaultControl shareInstance] logout];
    });
}

- (void)clickBottomRightBtn:(id)sender
{
    [_drawer reloadCenterViewControllerUsingBlock:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UserDefaultControl shareInstance] logout];
    });
}

@end
