//
//  TKNetWorkMacro.h
//  TKExtension
//
//  Created by zjt on 2024/12/17.
//

#ifndef TKNetWorkMacro_h
#define TKNetWorkMacro_h

// https
#define HTTPS_MACRO 1
#define sHttp      HTTPS_MACRO ? @"https" : @"http"
#define sPort      HTTPS_MACRO ? @"443"   : @"80"
#define isHTTPS  HTTPS_MACRO ? @"YES"    : @"NO"

#define sHost_Default @"doccdn.talk-cloud.net"

// 环境
static  NSString * sHost =

// 公网
@"global.talk-cloud.net";

// DEMO
//@"demo.talk-cloud.net";

// testing
//@"testing.talk-cloud.net";

//测试
//@"demo.talk111-cloud.net";

#define sHost_Back @"global.talk-cloud.com"
static  NSString *sSchoolLogin =

// 线上环境
//@"https://school.talk-cloud.net/office/login.html#/";
//@"https://h5-static.talk-cloud.net/static/school/office/login.html#/";
//@"https://h5-static.talk-cloud.net/static/Agreement/talkcloud";
@"https://doccdncf.talk-cloud.net/static/Agreement/talkcloud";
// demo环境
//@"https://demoschool.talk-cloud.net/office/login.html#/";

#endif /* TKNetWorkMacro_h */
