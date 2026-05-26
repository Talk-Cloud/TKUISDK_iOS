//
//  TXChineseToPinyin.h
//  TXSortByNameToolDemo
//
//  Created by on 2017/4/27.
//  Copyright © 2017年. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TKChineseToPinyin : NSObject
+ (NSString *) pinyinFromChiniseString:(NSString *)string;
+ (char) sortSectionTitle:(NSString *)string;
char TKpinyinFirstLetter(unsigned short hanzi);
@end
