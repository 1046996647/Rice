//
//  CountBindingVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CountBindingVC.h"
#import <UMSocialCore/UMSocialCore.h>


@interface CountBindingVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *imgArr;
@property(nonatomic,strong) PersonModel *person;


@end

@implementation CountBindingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.person = [InfoCache unarchiveObjectWithFile:Person];
    self.dataArr = [NSMutableArray array];
    self.imgArr = [NSMutableArray array];
    
    if (self.person.wechat.length > 0) {
        [self.dataArr addObject:@"已绑定"];
        [self.imgArr addObject:@"51"];
        
    }
    else {
        [self.dataArr addObject:@"未绑定"];
        [self.imgArr addObject:@"50"];
        
    }
    
    if (self.person.qq.length > 0) {
        [self.dataArr addObject:@"已绑定"];
        [self.imgArr addObject:@"49"];
    }
    else {
        [self.dataArr addObject:@"未绑定"];
        [self.imgArr addObject:@"48"];
        
    }

    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 10, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                  reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, 9, 15) icon:@"Back Chevron Copy 2"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        cell.accessoryView = imgView;
    }
    if (indexPath.row != self.dataArr.count-1) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(21, 56-1, kScreenWidth-21*2, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
        [cell.contentView addSubview:line];
    }
    
    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.detailTextLabel.text = self.dataArr[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *text = self.dataArr[indexPath.row];
    if ([text isEqualToString:@"已绑定"]) {
        
        NSString *urlStr = nil;
        if (indexPath.row == 0) {
            urlStr = @"要解除与微信账号的绑定吗";

        }
        if (indexPath.row == 1) {
            urlStr = @"要解除与QQ账号的绑定吗";
            
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:urlStr message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"解除绑定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self removeContact:indexPath.row];
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        if (indexPath.row == 0) {
            [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
        }
        if (indexPath.row == 1) {
            [self getUserInfoForPlatform:UMSocialPlatformType_QQ];

        }
    }


}

// 解除绑定
- (void)removeContact:(NSInteger)row
{

    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    if (row == 0) {
        [paramDic  setObject:@"WeChat" forKey:@"RemoveMode"];

    }
    else {
        [paramDic  setObject:@"QQ" forKey:@"RemoveMode"];

    }
    
    [AFNetworking_RequestData requestMethodPOSTUrl:RemoveContact dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        if (row == 0) {
            [self.dataArr replaceObjectAtIndex:row withObject:@"未绑定"];
            [self.imgArr replaceObjectAtIndex:row withObject:@"50"];

            self.person.wechat = @"";
            [InfoCache archiveObject:self.person toFile:Person];

        }
        else {
            [self.dataArr replaceObjectAtIndex:row withObject:@"未绑定"];
            [self.imgArr replaceObjectAtIndex:row withObject:@"48"];
            self.person.qq = @"";
            [InfoCache archiveObject:self.person toFile:Person];
        }
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    

}

// 绑定
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
        
        NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
        
        if (platformType == UMSocialPlatformType_QQ) {
            [paramDic  setValue:resp.uid forKey:@"qq"];
            [paramDic  setValue:@"QQ" forKey:@"BindMode"];
            
        }
        else {
            [paramDic  setValue:resp.uid forKey:@"wechat"];
            [paramDic  setValue:@"WeChat" forKey:@"BindMode"];
        }
        
        [AFNetworking_RequestData requestMethodPOSTUrl:BuildContact dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
            
            if (platformType == UMSocialPlatformType_QQ) {
                [self.dataArr replaceObjectAtIndex:1 withObject:@"已绑定"];
                [self.imgArr replaceObjectAtIndex:1 withObject:@"49"];
                self.person.qq = resp.uid;
            }
            else {
                [self.dataArr replaceObjectAtIndex:0 withObject:@"已绑定"];
                [self.imgArr replaceObjectAtIndex:0 withObject:@"51"];
                self.person.wechat = resp.uid;

            }
            [InfoCache archiveObject:self.person toFile:Person];
            [_tableView reloadData];


        } failure:^(NSError *error) {
            
        }];
    }];
}


@end
