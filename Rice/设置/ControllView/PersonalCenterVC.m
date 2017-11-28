//
//  SettingVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "LoginVC.h"
#import "AppDelegate.h"
#import "NavigationController.h"
#import "registerVC.h"
#import "UIImage+UIImageExt.h"
#import "InfoChangeController.h"
#import "BRPickerView.h"
//#import "ModifyTelFirstVC.h"


@interface PersonalCenterVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *leftDataList;
@property(nonatomic,strong) NSArray *rightDataList;
@property(nonatomic,strong) UIImageView *headImg;


@end

@implementation PersonalCenterVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight-kTopHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _tableView;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftDataList = @[@"头像",@"昵称",@"生日"];
    
//    if (!self.person.name) {
//        self.person.name = @"请输入昵称";
//    }
//    if (!self.person.phone) {
//        self.person.phone = @"请选择生日日期";
//    }
//    self.rightDataList = @[@"",self.person.name,self.person.phone];
    self.rightDataList = @[@"",@"请输入昵称",@"请选择生日日期"];

    [self.view addSubview:self.tableView];
    
    UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 36, 22) text:@"保存" font:SystemFont(16) textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    //    [viewBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:viewBtn];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserBodyInfo) name:@"kRefreshNotification" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftDataList.count;
//    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 71;

    }
    return 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //获取单元格
    __block UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {

        
    }
    if (indexPath.row == 1) {
        
        InfoChangeController *vc = [[InfoChangeController alloc] init];
        vc.title = @"昵称";
        vc.text = cell.detailTextLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSString *str) {
            
            self.person.name = str;
            [self saveAction];
            
        };
        
    }
    if (indexPath.row == 2) {
        
        [BRDatePickerView showDatePickerWithTitle:@"" dateType:UIDatePickerModeDate defaultSelValue:cell.detailTextLabel.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
            cell.detailTextLabel.text = selectValue;
        }];
        
    }
    if (indexPath.row == 3) {
        
//        registerVC *vc = [[registerVC alloc] init];
//        vc.title = @"修改密码";
//        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, 9, 15) icon:@"Back Chevron Copy 2"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        cell.accessoryView = imgView;
    }
    
    if (indexPath.row == 0) {
        
        if (!self.headImg) {
            UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-50-35, (71-50)/2, 50, 50)];
            headImg.layer.cornerRadius = headImg.height/2.0;
            headImg.layer.masksToBounds = YES;
            [cell.contentView addSubview:headImg];
            self.headImg = headImg;
        }
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:self.person.img] placeholderImage:[UIImage imageNamed:@"Group"]];

    }
    
    if (indexPath.row != self.leftDataList.count-1) {
        
        CGFloat height = 0;
        
        if (indexPath.row == 0) {
            height = 71;
        }
        else {
            height = 56;

        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(21, height-1, kScreenWidth-21*2, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
        [cell.contentView addSubview:line];
    }

    cell.textLabel.text = self.leftDataList[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.detailTextLabel.text = self.rightDataList[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}

#pragma mark - UIImagePickerControllerDelegate

//选取后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info:%@",info[UIImagePickerControllerOriginalImage]);
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];

    //通过判断picker的sourceType，如果是拍照则保存到相册去
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
//    NSData *data = [UIImage imageCompressForWidth:img targetWidth:100];
    
    NSData *data = [UIImage imageOrientation:img];

//    [self uploadImage:data];
    
    
    
}

//取消后调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//此方法就在UIImageWriteToSavedPhotosAlbum的上方
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"已保存");
}

- (void)uploadImage:(NSData *)data
{
    [SVProgressHUD show];

    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
//    NSMutableString *strM = [NSMutableString string];
//    for (int i=0; i<7; i++) {
//        [strM appendString:[NSString stringWithFormat:@"%@,",encodedImageStr]];
//    }
//    NSString *str = [strM substringToIndex:strM.length-1];
    
//    NSLog(@"!!!!!!%@",encodedImageStr);

    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:encodedImageStr forKey:@"imageStr"];
    
//    [AFNetworking_RequestData requestMethodPOSTUrl:UploadUserHeadImage dic:paramDic Succed:^(id responseObject) {
//
//        [SVProgressHUD dismiss];
//
//        NSLog(@"%@",responseObject);
//        [SVProgressHUD showSuccessWithStatus:@"头像上传成功!"];
//        self.person.HeadImage = responseObject[@"Model1"];
//
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            [SVProgressHUD dismiss];
//
//        });
//        [self saveAction];
//
//
//    } failure:^(NSError *error) {
//
//        NSLog(@"%@",error);
//        [SVProgressHUD dismiss];
//
//
//    }];
}

//- (void)uploadImage:(NSString *)base64Str
//{
//    
//    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
//    [paramDic  setObject:base64Str forKey:@"imageStr"];
//    
//    [AFNetworking_RequestData requestMethodPOSTUrl:UploadUserHeadImage dic:paramDic Succed:^(id responseObject) {
//        
//        [SVProgressHUD dismiss];
//        
//        NSLog(@"%@",responseObject);
//        
//        self.person.HeadImage = responseObject[@"Model1"];
//        [self saveAction];
//        
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//    }];
//}

// 保存用户信息
- (void)saveAction
{
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.person.name
                 forKey:@"UserName"];
//    [paramDic  setValue:self.person.HeadImage
//                 forKey:@"HeadImage"];
//
//    [AFNetworking_RequestData requestMethodPOSTUrl:SetUserBodyInfo dic:paramDic Succed:^(id responseObject) {
//
////        [SVProgressHUD dismiss];
//
//        NSLog(@"%@",responseObject);
//
//        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
//
//        if (200 == [code integerValue]) {
//
//            [self getUserBodyInfo];
//
//        }
//
//    } failure:^(NSError *error) {
//
//        NSLog(@"%@",error);
//        [SVProgressHUD dismiss];
//
//
//    }];
    
}

// 获取用户信息
- (void)getUserBodyInfo
{
    
//    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
//    [paramDic  setValue:self.person.UserId forKey:@"Id"];
//
//    [AFNetworking_RequestData requestMethodPOSTUrl:GetUserBodyInfo dic:paramDic Succed:^(id responseObject) {
//
////        [SVProgressHUD dismiss];
//
//        NSLog(@"%@",responseObject);
//
//        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
//
//        if (200 == [code integerValue]) {
//
//            NSArray *arr = [responseObject objectForKey:@"ListData"];
//            PersonModel *model = [PersonModel yy_modelWithJSON:[arr firstObject]];
//            self.person = model;
//            [InfoCache archiveObject:model toFile:@"Person"];
//
//            if (!self.person.name) {
//                self.person.name = @"";
//            }
//            if (!self.person.phone) {
//                self.person.phone = @"尚未绑定";
//            }
//            self.rightDataList = @[@"",self.person.name,self.person.phone,@"修改"];
//
//            [self.headImg sd_setImageWithURL:[NSURL URLWithString:self.person.HeadImage] placeholderImage:[UIImage imageNamed:@"error_head"]];
//
//            [self.tableView reloadData];
//        }
//
//    } failure:^(NSError *error) {
//
//        NSLog(@"%@",error);
//        [SVProgressHUD dismiss];
//
//
//    }];
    
}

@end
