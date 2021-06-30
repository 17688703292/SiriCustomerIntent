//
//  AssemblyModel.m
//  SiriIntents
//
//  Created by Sky Red on 2021/6/26.
//

#import "AssemblyModel.h"

@implementation AssemblyModel

-(instancetype)initWithDeviceSN:(NSString *)deviceSN OrderName:(NSString *)orderName OrderType:(NSString *)orderType
{
    self = [super init];
    if(self)
    {
        self.deviceSN = deviceSN;
        self.orderName = orderName;
        self.orderType = orderType;
    
    }
    return self;
}

@end
