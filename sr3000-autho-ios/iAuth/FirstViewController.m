//
//  FirstViewController.m
//  iAuth
//
//  Created by Qi Kuang on 11-8-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "KeyVerify.h"
#import <SystemConfiguration/SCNetworkReachability.h>
@implementation FirstViewController
@synthesize bnuGateway;
@synthesize webConnection;
@synthesize domGateway;
@synthesize status;

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self btnTestConnection:nil];
}

- (void) Alert:(NSString *) msg
{
    UIAlertView *alert = nil;
    alert = [[[UIAlertView alloc]initWithTitle:@"认证网关" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] autorelease];
    [alert show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [self setBnuGateway:nil];
    [self setWebConnection:nil];
    [self setDomGateway:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [bnuGateway release];
    [webConnection release];
    [domGateway release];
    [super dealloc];
}

- (IBAction)btnTestConnection:(id)sender {    
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, "www.qq.com");
    SCNetworkReachabilityGetFlags(ref, &flags);
    NSLog(@"Flags = %d\n", flags);
    if(flags == 7 || flags == 0) //网络不通
    {
        domGateway.text = @"连接不通";
        domGateway.textColor = [UIColor redColor];
        bnuGateway.text = @"连接不通";
        bnuGateway.textColor = [UIColor redColor];
        webConnection.text = @"连接不通";
        webConnection.textColor = [UIColor redColor];
        return;
    }
    else if(flags == 2 || flags == 3)
    {
        NSString *url = [[NSString alloc]initWithFormat:@"http://www.qq.com/"];
        NSMutableURLRequest *testRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
        NSURLResponse *testResponse;
        NSError *testError;
        NSData *testData = [NSURLConnection sendSynchronousRequest:testRequest returningResponse:&testResponse error:&testError];
        NSString *response = [[[NSString alloc] initWithData:testData encoding:NSASCIIStringEncoding] autorelease];
        int len = [response length];
        NSLog(@"Connection test response length = %d\n", len);
        if(len < 20) //空响应或者仅返回HTML头
        {
            if(len == 0) NSLog(@"Empty response received...\n");
            domGateway.text = @"测试失败";
            domGateway.textColor = [UIColor redColor];
            bnuGateway.text = @"测试失败";
            bnuGateway.textColor = [UIColor redColor];
            webConnection.text = @"测试失败";
            webConnection.textColor = [UIColor redColor];
        }
        else if((len > 100 && len < 200) || (len > 850 && len < 900)) //返回了校园网网关的跳转网页
        {
            if(len < 200) NSLog(@"School gateway jump page detected!\n");
            else NSLog(@"Dormitory login successful page detected!\n");
            domGateway.text = @"已通过";
            domGateway.textColor = [UIColor greenColor];
            bnuGateway.text = @"需要连接";
            bnuGateway.textColor = [UIColor redColor];
            webConnection.text = @"未测试";
            webConnection.textColor = [UIColor blueColor];
        }
        else if(len > 3000 && len < 4000) //返回了宿舍区网关的登录网页
        {
            NSLog(@"Dormitory area login page detected!\n");
            domGateway.text = @"需要连接";
            domGateway.textColor = [UIColor redColor];
            bnuGateway.text = @"未测试";
            bnuGateway.textColor = [UIColor blueColor];
            webConnection.text = @"未测试";
            webConnection.textColor = [UIColor blueColor];
        }
        else if((len > 6000))// || (len > 850 && len < 900)) //返回了百度主页(或者返回不带跳转的宿舍区网关，不知道这个诡异的问题从何而来)
        {
            NSLog(@"Baidu search page detected!\n");
            domGateway.text = @"已通过";
            domGateway.textColor = [UIColor greenColor];
            bnuGateway.text = @"已通过";
            bnuGateway.textColor = [UIColor greenColor];
            webConnection.text = @"连接成功";
            webConnection.textColor = [UIColor  greenColor];
            //if(len > 850 && len < 900) webConnection.text = @"连接成功.";
        }
        else
        {
            [self Alert:[[[NSString alloc] initWithFormat:@"发生了未知错误\n请将此信息反馈给开发者\n响应长度%d字节", len] autorelease]];
            //NSLog(@"\n%@", response);
        }
        /*
        if([response length]<2)
        {
            domGateway.text = @"无需连接";
            domGateway.textColor = [UIColor blueColor];
            bnuGateway.text = @"连接成功";
            bnuGateway.textColor = [UIColor greenColor];
            webConnection.text = @"连接不通";
            webConnection.textColor = [UIColor redColor];
            return;
        }
        if([response length]<1000)
        {
            domGateway.text = @"已经连上";
            domGateway.textColor = [UIColor greenColor];
            bnuGateway.text = @"连接成功";
            bnuGateway.textColor = [UIColor greenColor];
            webConnection.text = @"连接不通";
            webConnection.textColor = [UIColor redColor];
            return;
        }
        if([response length]>3000)
        {
            domGateway.text = @"需要连接";
            domGateway.textColor = [UIColor redColor];
            bnuGateway.text = @"连接不通";
            bnuGateway.textColor = [UIColor redColor];
            webConnection.text = @"连接不通";
            webConnection.textColor = [UIColor redColor];
            return;
        }*/
    }
    else
    {
        [self Alert:[[[NSString alloc] initWithFormat:@"发生了未知错误\n请将此信息反馈给开发者\n网络状态标志变量=%d", flags] autorelease]];
    }
}

- (IBAction)btnDLogin:(id)sender {
    if(![KeyVerify verifyReg])
    {
        [self Alert:@"请注册后使用！"];
        return;
    }
    NSString *url = [[NSString alloc]initWithFormat:@"http://%@/portal/logon.cgi", [KeyVerify Values].dIP];
    NSMutableURLRequest *dloginRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    [dloginRequest setHTTPMethod:@"POST"];
    [dloginRequest setHTTPBody:[[NSString stringWithFormat:@"PtUser=%@&PtPwd=%@&PtButton=Logon", [KeyVerify Values].Username, [KeyVerify Values].Password] dataUsingEncoding:NSASCIIStringEncoding]];
    NSURLResponse *dloginResponse;
    NSError *dloginError;
    NSData *dloginData = [NSURLConnection sendSynchronousRequest:dloginRequest returningResponse:&dloginResponse error:&dloginError];
    NSString *response = [[[NSString alloc] initWithData:dloginData encoding:NSASCIIStringEncoding] autorelease];
    int len = [response length];
    if(len < 20) [self Alert:@"登录宿舍区网关失败\n可能是您不在宿舍区\n或者宿舍区无线信号差"];
    else if(len < 1200)
    {
        [self Alert:@"登录宿舍区网关成功！"];
    }
    else
    {
        [self Alert:@"登录宿舍区网关失败！\n可能是用户名或密码错误"];
    }
    usleep(300000);
    [self btnTestConnection:nil];
    NSLog(@"DLogin response data length = %d\n", len);
}

- (IBAction)btnDLogout:(id)sender {
    if(![KeyVerify verifyReg])
    {
        [self Alert:@"请注册后使用！"];
        return;
    }
    NSString *url = [[NSString alloc]initWithFormat:@"http://%@/portal/logon.cgi", [KeyVerify Values].dIP];
    NSMutableURLRequest *dlogoutRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    [dlogoutRequest setHTTPMethod:@"POST"];
    [dlogoutRequest setHTTPBody:[[NSString stringWithFormat:@"PtButton=Logoff"] dataUsingEncoding:NSASCIIStringEncoding]];
    NSURLResponse *dlogoutResponse;
    NSError *dlogoutError;
    NSData *dlogoutData = [NSURLConnection sendSynchronousRequest:dlogoutRequest returningResponse:&dlogoutResponse error:&dlogoutError];
    int len = [[[[NSString alloc] initWithData:dlogoutData encoding:NSASCIIStringEncoding] autorelease] length];
    if(len == 0) [self Alert:@"登出宿舍区网关失败\n可能是您不在宿舍区\n或者宿舍区无线信号差"];
    else [self Alert:@"登出宿舍区网关成功！"];
    usleep(300000);
    [self btnTestConnection:nil];
    NSLog(@"DLogout response data length = %d\n", len);
}

- (IBAction)btnLogin:(id)sender {
    if(![KeyVerify verifyReg])
    {
        [self Alert:@"请注册后使用！"];
        return;
    }
    if([domGateway.text isEqualToString:@"需要连接"])
    {
        [self Alert:@"检测到您在宿舍区，请先连接宿舍区网关！"];
        return;
    }
    NSString *url = [[NSString alloc]initWithFormat:@"http://%@/cgi-bin/do_login", [KeyVerify Values].IP];
    NSMutableURLRequest *loginRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    [loginRequest setHTTPMethod:@"POST"];
    [loginRequest setHTTPBody:[[NSString stringWithFormat:@"username=%@&password=%@&drop=0&type=3&n=100&mac=00:00:00:00:00:00", [KeyVerify Values].Username, [KeyVerify Values].Password] dataUsingEncoding:NSASCIIStringEncoding]];
    NSURLResponse *loginResponse;
    NSError *loginError;
    NSData *loginData = [NSURLConnection sendSynchronousRequest:loginRequest returningResponse:&loginResponse error:&loginError];
    NSString *response = [[[NSString alloc] initWithData:loginData encoding:NSASCIIStringEncoding] autorelease];
    if([response length]==0)
    {
        [self Alert:@"连接服务器超时，请重试"];
        return;
    }
    response = [response stringByReplacingOccurrencesOfString:@"`" withString:@""];
    NSLog(@"%@", response);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[0-9]+$"];
    if([predicate evaluateWithObject:response])
    {
        [self Alert:@"登录成功！"];
        [self setStatus:response];
        usleep(300000);
        [self btnTestConnection:nil];
        return;
    }
    if([response isEqualToString:@"user_tab_error"])
    {
        [self Alert:@"认证程序未启动"];
    }
    else if([response isEqualToString:@"username_error"])
    {
        [self Alert:@"用户名错误"];
    }
    else if([response isEqualToString:@"password_error"])
    {
        [self Alert:@"密码错误"];
    }
    else if([response isEqualToString:@"non_auth_error"])
    {
        [self Alert:@"您无需认证，可直接上网"];
    }
    else if([response isEqualToString:@"status_error"])
    {
        [self Alert:@"您已欠费，请尽快充值。"];
    }
    else if([response isEqualToString:@"available_error"])
    {
        [self Alert:@"账号已禁用"];
    }
    else if([response isEqualToString:@"sync_error"])
    {
        [self Alert:@"正在同步资料，请2分钟后再试。"];
    }
    else if([response isEqualToString:@"delete_error"])
    {
        [self Alert:@"您的账号已被删除"];
    }
    else if([response isEqualToString:@"ip_exist_error"])
    {
        [self Alert:@"IP已存在，请稍后再试"];
    }
    else if([response isEqualToString:@"usernum_error"])
    {
        [self Alert:@"系统在线用户数已达上限"];
    }
    else if([response isEqualToString:@"online_num_error"])
    {
        [self Alert:@"帐号的登录人数已达上限"];
    }
    else if([response isEqualToString:@"mode_error"])
    {
        [self Alert:@"禁止客户端登录，请使用WEB登录。"];
    }
    else if([response isEqualToString:@"flux_error"])
    {
        [self Alert:@"您的流量已超支。"];
    }
    else if([response isEqualToString:@"minutes_error"])
    {
        [self Alert:@"您的时长已超支。"];
    }
    else if([response isEqualToString:@"ip_error"])
    {
        [self Alert:@"您的IP地址不合法。"];
    }
    else if([response isEqualToString:@"time_policy_error"])
    {
        [self Alert:@"当前时段不允许连接。"];
    }
    else
    {
        [self Alert:[[NSString alloc] initWithFormat:@"登录校园网发生未知错误\n错误信息：\n%@", response]];
    }
    usleep(300000);
    [self btnTestConnection:nil];
}

- (IBAction)btnLogout:(id)sender {
    if(![KeyVerify verifyReg])
    {
        [self Alert:@"请注册后使用！"];
        return;
    }
    if([domGateway.text isEqualToString:@"需要连接"])
    {
        [self Alert:@"检测到您在宿舍区，请先连接宿舍区网关！"];
        return;
    }
    NSString *url = [[NSString alloc]initWithFormat:@"http://%@/cgi-bin/do_logout", [KeyVerify Values].IP];
    NSMutableURLRequest *logoutRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    [logoutRequest setHTTPMethod:@"POST"];
    [logoutRequest setHTTPBody:[[NSString stringWithFormat:@"uid=%@", [self status]] dataUsingEncoding:NSASCIIStringEncoding]];
    NSURLResponse *logoutResponse;
    NSError *logoutError;
    NSData *logoutData = [NSURLConnection sendSynchronousRequest:logoutRequest returningResponse:&logoutResponse error:&logoutError];
    NSString *response = [[[NSString alloc] initWithData:logoutData encoding:NSASCIIStringEncoding] autorelease];
    NSLog(@"Logout info = %@\n", response);
    if([response isEqualToString:@"logout_ok"])
    {
        [self Alert:@"登出校园网网关成功!"];
    }
    else
    {
        [self Alert:@"登出校园网网关失败！"];
    }
    usleep(300000);
    [self btnTestConnection:nil];
}

- (IBAction)btnForceLogout:(id)sender {
    if(![KeyVerify verifyReg])
    {
        [self Alert:@"请注册后使用！"];
        return;
    }
    if([domGateway.text isEqualToString:@"需要连接"])
    {
        [self Alert:@"检测到您在宿舍区，请先连接宿舍区网关！"];
        return;
    }
    NSString *url = [[NSString alloc]initWithFormat:@"http://%@/cgi-bin/force_logout", [KeyVerify Values].IP];
    NSMutableURLRequest *forceRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    [forceRequest setHTTPMethod:@"POST"];
    [forceRequest setHTTPBody:[[NSString stringWithFormat:@"username=%@&password=%@&drop=0&type=1&n=1", [KeyVerify Values].Username, [KeyVerify Values].Password] dataUsingEncoding:NSASCIIStringEncoding]];
    NSURLResponse *forceResponse;
    NSError *forceError;
    NSData *forceData = [NSURLConnection sendSynchronousRequest:forceRequest returningResponse:&forceResponse error:&forceError];
    NSString *response = [[[NSString alloc] initWithData:forceData encoding:NSASCIIStringEncoding] autorelease];
    if([response length]==0)
    {
        [self Alert:@"连接服务器超时，请重试"];
        return;
    }
    response = [response stringByReplacingOccurrencesOfString:@"`" withString:@""];
    NSLog(@"%@", response);
    if([response isEqualToString:@"user_tab_error"])
    {
        [self Alert:@"认证程序未启动"];
    }
    else if([response isEqualToString:@"username_error"])
    {
        [self Alert:@"用户名错误"];
    }
    else if([response isEqualToString:@"password_error"])
    {
        [self Alert:@"密码错误"];
    }
    else if([response isEqualToString:@"logout_ok"])
    {
        [self Alert:@"注销成功，请一分钟后登录"];
    }
    else if([response isEqualToString:@"logout_error"])
    {
        [self Alert:@"您不在线上"];
    }
    else
    {
        [self Alert:[[NSString alloc] initWithFormat:@"强制离线发生未知错误\n错误信息：\n%@", response]];
    }
    usleep(300000);
    [self btnTestConnection:nil];
}

@end
