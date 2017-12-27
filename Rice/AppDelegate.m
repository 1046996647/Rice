//
//  AppDelegate.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/15.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import <QMapKit/QMapKit.h>
#import <QMapSearchKit/QMapSearchKit.h>
#import <UMSocialCore/UMSocialCore.h>
#import <AlipaySDK/AlipaySDK.h>

#import "WXApi.h"
#import "WXApiObject.h"

// 友盟推送
#import "UMessage.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif

#define USHARE_DEMO_APPKEY @"5a30d5b7f29d980cba000262"

#import "ZAlertView.h"
#import "ZAlertViewManager.h"


@interface AppDelegate ()<UNUserNotificationCenterDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // 键盘遮盖处理第三方库
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    // 地图----------------

    [QMapServices sharedServices].apiKey = @"ZVSBZ-57HCP-3JADY-LK5EG-WTLYK-VDFF2";
    [[QMSSearchServices sharedServices] setApiKey:@"ZVSBZ-57HCP-3JADY-LK5EG-WTLYK-VDFF2"];
    
    // 友盟第三方登录或分享----------------
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];

    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];

    [self configUSharePlatforms];

    [self confitUShareSettings];
    
//    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = YES;


    // 友盟推送
    [UMessage startWithAppkey:USHARE_DEMO_APPKEY launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];

    if (@available(iOS 10.0, *)) {
        //iOS10必须加下面这段代码。
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate=self;
        UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
                //这里可以添加一些自己的逻辑
            } else {
                //点击不允许
                //这里可以添加一些自己的逻辑
            }
        }];
    }


    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
    
    
    return YES;
}

// ------------登录或分享
- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxd8482615c33b8859" appSecret:@"9a2bd8b900170248fdd09b047c707dd8" redirectURL:nil];
    
//    [WXApi registerApp:@"wxd8482615c33b8859"];

    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106603508"/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
    
}

#pragma mark - 微信授权回调
/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void)onReq:(BaseReq*)req{
    NSLog(@"onReq");
}
/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
- (void)onResp:(BaseResp*)resp{
    if([resp isKindOfClass:[SendMessageToWXResp class]]){//微信分享回调
        SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
        if (messageResp.errCode == -2) {
            NSLog(@"用户取消分享");
        }
    }else if ([resp isKindOfClass:[SendAuthResp class]]){//微信登录回调
        SendAuthResp *aresp = (SendAuthResp *)resp;
        
        /*
         ErrCode ERR_OK = 0(用户同意)
         ERR_AUTH_DENIED = -4（用户拒绝授权）
         ERR_USER_CANCEL = -2（用户取消）
         code    用户换取access_token的code，仅在ErrCode为0时有效
         state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
         lang    微信客户端当前语言
         country 微信用户当前国家信息
         */
        
        NSLog(@"aresp.errCode:%d",aresp.errCode);
        
        if (aresp.errCode== 0) {
            NSLog(@"微信登录成功");
        }else if (aresp.errCode == -2){
            NSLog(@"用户取消登录");
        }
    }else if ([resp isKindOfClass:[PayResp class]]){//微信支付
        PayResp *response = (PayResp *)resp;
        NSLog(@"response.returnKey:%@",response.returnKey);
        
        if (response.errCode == WXSuccess) {
            //服务器端查询支付通知或查询API返回的结果再提示成功
            NSLog(@"微信支付成功");

            //支付成功通知事件
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kPaySuccessNotification" object:nil];
            
        }else if (response.errCode == WXErrCodeUserCancel){
            NSLog(@"用户取消支付");
            //支付取消通知事件
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kPayCancelNotification" object:nil];
        }else{//WXErrCodeCommon
            NSLog(@"支付失败，retcode=%d",response.errCode);
        }
    }
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        
        if ([url.host isEqualToString:@"safepay"]) {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                
                NSString *code = resultDic[@"resultStatus"];
                if (code.integerValue == 6001) {
                    // memo = "用户中途取消";
                    //支付取消通知事件
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kPayCancelNotification" object:nil];
                }
                if (code.integerValue == 9000) {
                    //支付成功通知事件
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kPaySuccessNotification" object:nil];
                }
                
            }];
    
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                // 解析 auth code
                NSString *result = resultDic[@"result"];
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
                NSLog(@"授权结果 authCode = %@", authCode?:@"");
            }];
        }
        else {
            [WXApi handleOpenURL:url delegate:self];
        }
    }
    return result;
}

////iOS9.0之后回调API接口
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//
//    return [WXApi handleOpenURL:url delegate:self];
//}


// ------------推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    // [UMessage registerDeviceToken:deviceToken];
    NSString *pushToken = [self stringDevicetoken:deviceToken];
    NSLog(@"deviceToken:%@",pushToken);
    
    [InfoCache archiveObject:pushToken toFile:@"pushToken"];

}

#pragma mark 以下的
-(NSString *)stringDevicetoken:(NSData *)deviceToken
{
    NSString *token = [deviceToken description];
    NSString *pushToken = [[[token stringByReplacingOccurrencesOfString:@"<"withString:@""]                   stringByReplacingOccurrencesOfString:@">"withString:@""] stringByReplacingOccurrencesOfString:@" "withString:@""];
    return pushToken;
}

//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    //    self.userInfo = userInfo;
        //定制自定的的弹出框
        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
//                                                                message:@"Test On ApplicationStateActive"
//                                                               delegate:self
//                                                      cancelButtonTitle:@"确定"
//                                                      otherButtonTitles:nil];
//
//            [alertView show];
            
//            [[ZAlertViewManager shareManager] showWithType:AlertViewTypeSuccess];

        }
}



//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
        NSString *pushValue = userInfo[@"fdKey"];
        
        if ([pushValue isEqualToString:@"TakeOrder"]) {
            //进行中订单状态更新通知事件(刷新首页或进行中订单)
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kSendingOrderNotification" object:nil];
        }

        if ([pushValue isEqualToString:@"ArriveOrder"]) {
            //完成订单通知事件(弹出评价视图)
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kFinishOrderNotification" object:userInfo[@"orderId"]];
        }
        
//        //定制自定的的弹出框
//        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//        {
//            [[ZAlertViewManager shareManager] showWithType:AlertViewTypeSuccess];
//
//        }
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
//    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge);

}

//iOS10后新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    if (application.applicationIconBadgeNumber>0) {  //badge number 不为0，说明程序有那个圈圈图标
        NSLog(@"我可能收到了推送");
        //这里进行有关处理
        [application setApplicationIconBadgeNumber:0];   //将图标清零。
        
        //进行中订单状态更新通知事件(刷新首页或进行中订单)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kSendingOrderNotification" object:nil];
        
        //完成订单通知事件(刷新历史订单)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kHistoryOrderNotification" object:nil];
        
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
