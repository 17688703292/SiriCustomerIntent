//
//  AssemblyModel.h
//  SiriIntents
//
//  Created by Sky Red on 2021/6/26.
//

#import <Foundation/Foundation.h>
#import <Intents/Intents.h>

NS_ASSUME_NONNULL_BEGIN

@interface AssemblyModel : NSObject

-(instancetype)initWithDeviceSN:(NSString *)deviceSN OrderName:(NSString *)orderName OrderType:(NSString *)orderType;

@property(nonatomic,copy) NSString *deviceSN;//设备SN号
@property(nonatomic,copy) NSString *orderName;//消息发送名称
@property(nonatomic,copy) NSString *orderType;//消息发送类型
@property(nonatomic,copy) NSString *officeID;


@end

NS_ASSUME_NONNULL_END
