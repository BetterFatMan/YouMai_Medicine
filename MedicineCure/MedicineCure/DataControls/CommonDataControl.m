//
//  CommonDataControl.m
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "CommonDataControl.h"

#import "TreatmentEntity.h"
#import "ArticleEntity.h"
#import "MedicineEntity.h"
#import "CureItemEntity.h"

#define kGetTreatmentList   (@"treat/listTreatment")
#define kComHomeInit        (@"home/init")

#define kGetMedicineList    (@"treat/listMedicine")
#define kAddMedicineOneTime (@"home/addMedicine")

@implementation CommonDataControl

- (void)homeInit:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, NSArray *items, NSArray *ummList,NSArray *utmList, NSError *error))completeBlock
{
    NSDictionary *httpParams = [self defaultPars:params];
    [self postApiWithPath:kComHomeInit params:httpParams completeBlock:^(BOOL isSuccess, MKNetworkOperation *operation, NSError *err) {
        if (isSuccess)
        {
            NSDictionary *responce = operation.responseJSON;
            NSArray  *array = [responce safeBindValue:@"articleList"];
            NSMutableArray *article = [NSMutableArray array];
            
                /*
                 ummList -- 药品列表
                 utmList -- 治疗过程列表
                 */
            
            for (NSDictionary *dic in array) {
                ArticleEntity *entity = [[ArticleEntity alloc] initWithDict:dic];
                if (entity)
                {
                    [article addObject:entity];
                }
            }
            
            NSArray *utmList = [responce safeBindValue:@"utmList"];
            NSArray *ummList = [responce safeBindValue:@"ummList"];
            NSMutableArray *uttArr = [NSMutableArray array];
            for (NSDictionary *ddic in utmList) {
                CureItemEntity *entity = [[CureItemEntity alloc] initWithDict:ddic];
                if (entity) {
                    [uttArr addObject:entity];
                }
            }
            
            NSMutableArray *mmArr = [NSMutableArray array];
            for (NSDictionary *ddic in ummList) {
                MedicineEntity *entity = [[MedicineEntity alloc] initWithDict:ddic];
                if (entity) {
                    [mmArr addObject:entity];
                }
            }
            
            if (completeBlock)
            {
                completeBlock(YES, article, mmArr, uttArr, err);
            }
        }
        else
        {
            if (completeBlock)
            {
                completeBlock(NO, nil, nil, nil, err);
            }
        }
    }];
}

- (void)getTreatmentList:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess,  NSArray *treatmentList, NSError *error))completeBlock
{
    NSDictionary *httpParams = [self defaultPars:params];
    [self postApiWithPath:kGetTreatmentList params:httpParams completeBlock:^(BOOL isSuccess, MKNetworkOperation *operation, NSError *err) {
        if (isSuccess)
        {
            NSDictionary *responce = operation.responseJSON;
            NSArray  *array = [responce safeBindValue:@"treatList"];
            NSMutableArray *ttreat = [NSMutableArray array];
            
            for (NSDictionary *dic in array) {
                TreatmentEntity *entity = [[TreatmentEntity alloc] initWithDict:dic];
                if (entity)
                {
                    [ttreat addObject:entity];
                }
            }
            
            if (completeBlock)
            {
                completeBlock(YES, ttreat, err);
            }
        }
        else
        {
            if (completeBlock)
            {
                completeBlock(NO, nil, err);
            }
        }
    }];
}

- (void)getMedicineList:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, NSArray *medicineList, NSError *error))completeBlock
{
    NSDictionary *httpParams = [self defaultPars:params];
    [self postApiWithPath:kGetMedicineList params:httpParams completeBlock:^(BOOL isSuccess, MKNetworkOperation *operation, NSError *err) {
        if (isSuccess)
        {
            NSDictionary *responce = operation.responseJSON;
            NSArray  *array = [responce safeBindValue:@"medicineList"];
            NSMutableArray *ttreat = [NSMutableArray array];
            
            for (NSDictionary *dic in array) {
                MedicineEntity *entity = [[MedicineEntity alloc] initWithDict:dic];
                if (entity)
                {
                    [ttreat addObject:entity];
                }
            }
            
            if (completeBlock)
            {
                completeBlock(YES, ttreat, err);
            }
        }
        else
        {
            if (completeBlock)
            {
                completeBlock(NO, nil, err);
            }
        }
    }];
}

- (void)addOneMedicine:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, NSError *error))completeBlock
{
    NSDictionary *httpParams = [self defaultPars:params];
    [self postApiWithPath:kAddMedicineOneTime params:httpParams completeBlock:^(BOOL isSuccess, MKNetworkOperation *operation, NSError *err) {
        if (isSuccess)
        {
            if (completeBlock)
            {
                completeBlock(YES, err);
            }
        }
        else
        {
            if (completeBlock)
            {
                completeBlock(NO, err);
            }
        }
    }];
}

@end

/*"articleList": [{
 
 "status": 1,
 
 "articleId": 1,
 
 "articleUrl": "www.baidu.com",//文章详情页
 
 "imageTitle":      "http:\/\/img7.line0.com\/static\/guanjiashop\/image\/logo\/1433828032267.jpeg",//文章图片
 
 "title": "乳腺癌预防"//title
 
 }],
 
 "ummList": [{
 
 "status": 1,
 
 "id": 1,
 
 "medicine": {
 
 "status": 1,
 
 "detailUrl": "www.baidu.com",//药品介绍页
 
 "diseaseId": 1,//
 
 "dosage": 1,//剂量
 
 "frequency": 1,//一天几次
 
 "medicineId": 1//药品id
 
 },
 
 "medicineId": 1,
 
 "userId": 1*/
