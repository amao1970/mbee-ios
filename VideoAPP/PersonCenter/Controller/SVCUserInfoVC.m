//
//  SVCUserInfoVC.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/20.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCUserInfoVC.h"
#import "SVCUserInfoCell.h"
#import "SVCUserInfoHeadView.h"
#import "SVCUpdateHeadImgView.h"
#import <Photos/Photos.h>
#import "SVCchangPasswordViewController.h"
#import "SVCNickNameView.h"

@interface SVCUserInfoVC ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray*>* titleAry;
@property (nonatomic, strong) SVCUserInfoHeadView *headView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) SVCNickNameView *NickNameView;
@end

@implementation SVCUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑资料";
    self.titleAry = @[@[@"头像",@"用户名",],@[@"邀请码",@"绑定手机",@"修改密码",]];
    [self setUpMainView];
}

-(void)setUpMainView{
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Nav_HEIGHT);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = Color(244, 245, 246);
    [self.tableView registerNib:[UINib nibWithNibName:@"SVCUserInfoCell" bundle:nil] forCellReuseIdentifier:@"SVCUserInfoCell"];
    [self.view addSubview:self.tableView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        if (indexPath.row == 0) {
            [self updateHeadImg];
        }else{
            self.NickNameView = [SVCNickNameView getViewFormNSBunld];
            self.NickNameView.frame = CGRectMake(0, 0, JXWidth(355), JXHeight(150));
            self.NickNameView.center = CGPointMake(SCR_WIDTH/2.f, SCR_HIGHT/3.f);
            [self.NickNameView.textView becomeFirstResponder];
            [self.NickNameView.close addTarget:self action:@selector(close_bgView) forControlEvents:UIControlEventTouchUpInside];
            [self.NickNameView.commit addTarget:self action:@selector(click_nickName) forControlEvents:UIControlEventTouchUpInside];
            self.NickNameView.layer.cornerRadius = 5;
            self.NickNameView.clipsToBounds = YES;
            self.NickNameView.userInteractionEnabled = YES;
            [self.NickNameView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close_NickNameView)]];
            
            self.bgView = [UIView new];
            self.bgView.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT );
            self.bgView.backgroundColor = [UIColor colorWithHexString:@"000000" andAlpha:0.2];
            [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close_bgView)]];
            [self.bgView addSubview:self.NickNameView];
            [self.navigationController.view addSubview:self.bgView];
        }
    }else{
        if (indexPath.row == 0){
            SVCinvateFriendsViewController *invateVC = [[SVCinvateFriendsViewController alloc] init];
            if ([self token].length > 1) {
                invateVC.type = @"1";
            }
            [self.navigationController pushViewController:invateVC animated:YES];
        }
        else if (indexPath.row == 2) {
            [self gotoChangepassWord];
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleAry[section].count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVCUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SVCUserInfoCell"];
    cell.titleLab.text = self.titleAry[indexPath.section][indexPath.row];
    SVCCurrUser *user = [SVCUserInfoUtil mGetUser];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.img.hidden = NO;
            [cell.img sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"默认图"]];
        }else{
            cell.img.hidden = YES;;
            cell.subtitleLab.text = user.nickname;
        }
    }else{
        if (indexPath.row == 0) {
            cell.subtitleLab.text = user.invite_code;
        }else if (indexPath.row == 1){
            NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone_number"];
            cell.subtitleLab.text = phone;
        }else{
            cell.subtitleLab.text = @"";
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JXHeight(50);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, SCR_WIDTH, JXHeight(10));
    view.backgroundColor = Color(244, 245, 246);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return JXHeight(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updateHeadImg{
    SVCUpdateHeadImgView *view = [SVCUpdateHeadImgView getViewFormNSBunld];
    view.frame = CGRectMake(0, 0, JXWidth(240), JXHeight(160));
    view.center = CGPointMake(SCR_WIDTH/2.f, SCR_HIGHT/2.f);
    [view.closeBtn addTarget:self action:@selector(close_bgView) forControlEvents:UIControlEventTouchUpInside];
    [view.photoBtn addTarget:self action:@selector(click_photo) forControlEvents:UIControlEventTouchUpInside];
    [view.cameraBtn addTarget:self action:@selector(close_camera) forControlEvents:UIControlEventTouchUpInside];
    
    self.bgView = [UIView new];
    self.bgView.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT );
    self.bgView.backgroundColor = [UIColor colorWithHexString:@"000000" andAlpha:0.2];
    [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close_bgView)]];
    [self.bgView addSubview:view];
    [self.navigationController.view addSubview:self.bgView];
}

-(void)close_bgView{
    [self.bgView removeFromSuperview];
}

-(void)click_photo{
    [self.bgView removeFromSuperview];
    [self LocalPhoto];
}

-(void)close_camera{
    [self.bgView removeFromSuperview];
    [self takePhoto];
}

-(void)close_NickNameView{
    
}

-(void)click_nickName{
    if (!self.NickNameView.textView.text.length) {
        [self.view toastShow:@"请输入昵称"];
        return;
    }
    [self.bgView removeFromSuperview];
    WS(weakSelf);
    [SVCCommunityApi UserUpdateNickNameWithNSDiction:@{@"nick":self.NickNameView.textView.text} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            SVCCurrUser *model = [SVCUserInfoUtil mGetUser];
            model.nickname = self.NickNameView.textView.text;
            [SVCUserInfoUtil mSaveUser:model];
            [self.tableView reloadData];
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"rechargesuccess" object:nil];
            [weakSelf.view toastShow:@"修改成功"];
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        
    }];
}

#pragma mark -->修改密码
- (void)gotoChangepassWord
{
    SVCchangPasswordViewController *changePasswordVC = [[SVCchangPasswordViewController alloc] init];
    if ([self token].length > 1) {
        changePasswordVC.type = @"1";
    }
    [self.navigationController pushViewController:changePasswordVC animated:YES];
}

- (NSString *)token
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

// 拍照
-(void)takePhoto
{//相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
        
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"相机权限不足，设置相机权限" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // 无权限 引导去开启
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                
                if ([[UIApplication sharedApplication]canOpenURL:url]) {
                    
                    [[UIApplication sharedApplication]openURL:url];
                    
                }
            }];
            [alertController addAction:okAction];
            
            UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [alertController addAction:closeAction];
        [self presentViewController:alertController animated:YES completion:nil];
        ;
        return;
    }
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

//打开本地相册
-(void)LocalPhoto
{
    // iOS 8.0以上系统
    PHAuthorizationStatus authorStatus = [PHPhotoLibrary authorizationStatus];
    NSLog(@"openGallery_authorStatus == %ld",(long)authorStatus);
    if (authorStatus == PHAuthorizationStatusAuthorized ||
        authorStatus == PHAuthorizationStatusNotDetermined){
        //获取权限
        //        [picker dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"相机权限不足，设置相机权限" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // 无权限 引导去开启
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                
                if ([[UIApplication sharedApplication]canOpenURL:url]) {
                    
                    [[UIApplication sharedApplication]openURL:url];
                    
                }
            }];
            [alertController addAction:okAction];
            
            UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [alertController addAction:closeAction];
            [self presentViewController:alertController animated:YES completion:nil];
        ;
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    picker.navigationBar.tintColor = [UIColor blackColor];
    [self.tabBarController presentViewController:picker animated:YES completion:^{
        UIViewController*vc = picker.viewControllers.lastObject;
        picker.navigationBar.tintColor = [UIColor blackColor];
        vc.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    }];
}

#pragma mark --UIImagePickerControllerDelegate
// 当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage *img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self updateImg:img];
    }
}

-(void)updateImg:(UIImage*)img{
    WS(weakSelf);
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud valueForKey:@"token"];
    
    NSDictionary *dic = @{@"token":token?token:@"",
                          @"avatar":[@"data:image/jpeg;base64," stringByAppendingFormat:@"%@",[self imageToString:img]]
                          };
     [WsHUD showHUDWithLabel:@"正在上传中..." modal:NO timeoutDuration:40.0];
    [SVCCommunityApi UserUpdateHeadImgWithNSDiction:dic BlockSuccess:^(NSInteger code, NSString * msg, NSDictionary *JSON) {
        [WsHUD hideHUD];
        if (code == 0) {
            SVCCurrUser *model = [SVCUserInfoUtil mGetUser];
            model.avatar = JSON[@"avatar"];
            [SVCUserInfoUtil mSaveUser:model];
            [self.tableView reloadData];
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"rechargesuccess" object:nil];
        }
        else if(code == -997){
            SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
            SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
        else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
    }];
}

// 图片转64base字符串
- (NSString *)imageToString:(UIImage *)image {
    NSData *imagedata = UIImageJPEGRepresentation(image, 0.2) ;//UIImagePNGRepresentation(image);
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return image64;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
