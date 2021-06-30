#import "CustomerOperationsiriPlugin.h"


#import "AssemblyTool.h"
#import "AppDelegate.h"

@implementation CustomerOperationsiriPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"customersirioperationrobert"
            binaryMessenger:[registrar messenger]];
    CustomerOperationsiriPlugin* instance = [[CustomerOperationsiriPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
      NSLog(@"ios_getPlatformVersion");
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"getAssemblyGetAllVoiceResult" isEqualToString:call.method]){
      NSLog(@"ios_getAssemblyGetAllVoiceResult");
     
      [[AssemblyTool shareManger] GetAllVoiceResult:^(NSMutableArray * _Nonnull dataSource) {
        
          result(dataSource);
      }];
    }else if ([@"getAssemblyinitWithModel" isEqualToString:call.method]){
        
   
  
        [[AssemblyTool shareManger] initWithModel:call.arguments[0] EditType:call.arguments[1] Success:^(AssemblyModel * _Nonnull model) {

       
            result(@{@"code":@"1"});
                } Fair:^(AssemblyModel * _Nonnull model) {
                   
                    result(@{@"code":@"0"});
                
                }];
        
    }
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
