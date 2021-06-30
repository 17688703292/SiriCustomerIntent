//
//  CustomerPluginRegistrant.m
//  Runner
//
//  Created by Sky Red on 2021/6/29.
//

#import "CustomerPluginRegistrant.h"
#import "CustomerOperationsiriPlugin.h"

@implementation CustomerPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [CustomerOperationsiriPlugin registerWithRegistrar:[registry registrarForPlugin:@"CustomerOperationsiriPlugin"]];
}

@end
