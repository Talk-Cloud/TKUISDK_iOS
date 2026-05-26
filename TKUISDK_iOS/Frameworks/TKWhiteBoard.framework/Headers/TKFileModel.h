//
//  TKFileModel.h
//  TKWhiteBoard
//
//  Created by MAC-MiNi on 2018/4/18.
//  Copyright © 2018年 MAC-MiNi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKFileModel : NSObject <NSCopying>

@property (nonatomic, copy) NSString *url;
@property (nonatomic,strong) NSArray *useFileFolderIds;
@property (nonatomic,assign) BOOL notRoomFile;

@property (nonatomic, copy) NSString *action;//show

// filedata
@property (nonatomic, copy) NSString *fileid;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *downloadpath;
@property (nonatomic, copy) NSString *filetype;
@property (nonatomic, copy) NSString *currpage;
@property (nonatomic, copy) NSString *pagenum;
@property (nonatomic, copy) NSString *pptstep;//0 贞
@property (nonatomic, copy) NSString *steptotal;//总的
@property (nonatomic, copy) NSString *swfpath;


@property (nonatomic, strong) NSNumber *isDynamicPPT; // 是否是ppt
@property (nonatomic, strong) NSNumber *isGeneralFile; // 是否是普通课件
@property (nonatomic, strong) NSNumber *isH5Document; // 是否是H5课件
@property (nonatomic, strong) NSNumber *isTestDocument; // 是否是测试课件

@property (nonatomic, copy) NSString *isMedia;
@property (nonatomic, copy) NSString *mediaType;
@property (nonatomic, copy) NSString *preloadingzip;


////// 未知
@property (nonatomic, copy) NSString *animation;
@property (nonatomic, copy) NSString *companyid;

@property (nonatomic, copy) NSString *filepath;
@property (nonatomic, copy) NSString *fileurl;
@property (nonatomic, copy) NSString *pdfpath;
@property (nonatomic, copy) NSString *size;
//@property (nonatomic, copy) NSString *type;// 1 默认文档
@property (nonatomic, copy) NSString *uploadtime;
@property (nonatomic, copy) NSString *uploaduserid;

@property (nonatomic, copy) NSString *dynamicppt;//1 是原动态ppt 2.新的

//0:表示普通文档　１－２动态ppt(1: 第一版动态ppt 2: 新版动态ppt ）  3:h5文档 4.测试课件
@property (nonatomic, copy) NSString *fileprop;
@property (nonatomic, copy) NSString *isShow;//是否查看
@property (nonatomic, copy) NSString *duration;//BOOl

/**
 区分文件类型 0：课堂  1：系统
 */
@property (nonatomic, copy) NSString *filecategory;

//动态ppt是否有缩略图  0:没有 1:有 （仅对动态ppt生效 ，旧数据动态ppt没有缩略图）
@property (nonatomic, strong) NSNumber* dynamicppt_thumb;
@property (nonatomic, strong) NSString *tailor;

/// 该课件是否下载到本地了
+ (BOOL)isExistLocal:(NSString *)fID;

/// filemodel 转 pubmsg data (用于发信令)
- (NSDictionary *)wbShowPageMap;

/// filemodel 转 H5 data (用于发给H5 切课件)
- (NSDictionary *)wbChangeDocumentMapWithHost:(NSString *)host teacherId:(NSString *)teacherId;

/// pubmsg dictionary 转 model
+ (TKFileModel *)creatModelWithData:(NSDictionary *)data;

/// 创建默认白板
+ (TKFileModel *)createWhiteBoardModel;

/// 创建白板模型
+ (TKFileModel *)createModelFromFileList:(NSDictionary *)data;

/// url 为空 清理webview
+ (NSDictionary *) wbClearWebViewMap;

/// json 转 字典
+ (NSMutableDictionary *)dictionaryWithIDData:(id)data;

- (BOOL)isTest;
@end
