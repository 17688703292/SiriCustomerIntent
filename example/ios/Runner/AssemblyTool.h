//
//  AssemblyTool.h
//  Runner
//
//  Created by Sky Red on 2021/6/29.
//

#import <Foundation/Foundation.h>

#import "AssemblyModel.h"



NS_ASSUME_NONNULL_BEGIN


typedef void(^SuccessBlock)(AssemblyModel *model);//添加便捷指令成功
typedef void(^FairBlock)(AssemblyModel *model);//添加便捷指令失败
typedef void(^ResultBlock)(NSMutableArray *dataSource);//所有便捷指令

@interface AssemblyTool : NSObject

@property (nonatomic, copy)SuccessBlock successblock;
@property (nonatomic, copy)FairBlock fairblock;
@property (nonatomic, copy)ResultBlock resultblock;

+(instancetype)shareManger;

-(void)initWithModel:(NSDictionary *)dic EditType:(NSString *)type Success:(SuccessBlock)blocksuccess Fair:(FairBlock)blockfair;
-(void)GetAllVoiceResult:(ResultBlock )blockresult;

@end

NS_ASSUME_NONNULL_END
