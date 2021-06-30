//
//  AssemblyTool.m
//  Runner
//
//  Created by Sky Red on 2021/6/29.
//

#import "AssemblyTool.h"
#import "SkIntent.h"
#import <Intents/Intents.h>
#import <IntentsUI/IntentsUI.h>
#import "AppDelegate.h"

API_AVAILABLE(ios(12.0))
@interface AssemblyTool ()<INUIAddVoiceShortcutViewControllerDelegate,INUIEditVoiceShortcutViewControllerDelegate,NSUserActivityDelegate>


@property(nonatomic,strong) INUIAddVoiceShortcutViewController *addShortcutViewController;
@property(nonatomic,strong) INUIEditVoiceShortcutViewController *editShortcutViewController;
@property(nonatomic,strong) NSUserActivity *activity;

@property(nonatomic,strong) SkIntent *Intent;
@property(nonatomic,strong) INInteraction *interaction;


@property(nonatomic,strong) NSMutableArray *voiceArray;
@property(nonatomic, copy) NSString *editType;
@property(nonatomic,strong) AssemblyModel *model;//数据源_可添加的快捷类型

@property (nonatomic,strong)dispatch_queue_t serialQueue;


@end

@implementation AssemblyTool

+(instancetype)shareManger{
    
    static AssemblyTool *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        manager = [[AssemblyTool alloc]init];
    });
    return  manager;
}

-(void)EditVoice{

    
    if ([self.editType isEqualToString:@"0"]) {

        
        if (@available(iOS 12.0, *)) {
            self.Intent = [[SkIntent alloc]init];
        }
        self.Intent.deviceSN = self.model.deviceSN;
        self.Intent.actionContent = self.model.orderName;
        self.Intent.orderType = self.model.orderType;
        
        
        INShortcut *shortcut = [[INShortcut alloc] initWithIntent:self.Intent];
        self.addShortcutViewController = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortcut];
        self.addShortcutViewController.delegate = self;

        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:self.addShortcutViewController animated:YES completion:^{
            
        }];
    }else{
        
        
            INVoiceShortcut *voiceShortcut;
            for (INVoiceShortcut *shortcut in self.voiceArray) {
         
                if([shortcut.identifier.UUIDString isEqualToString:self.model.officeID])
                {
                    voiceShortcut = shortcut;
                    break;
                }
            }
            self.editShortcutViewController = [[INUIEditVoiceShortcutViewController alloc] initWithVoiceShortcut:voiceShortcut];
            self.editShortcutViewController.delegate = self;
            [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:self.editShortcutViewController animated:YES completion:nil];
        
    }

}

#pragma mark - delegate

-(void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller
API_AVAILABLE(ios(12.0)){
    NSLog(@"取消");
    if (self.fairblock) {
        self.fairblock(self.model);
    }
   
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)addVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(INVoiceShortcut *)voiceShortcut error:(NSError *)error
API_AVAILABLE(ios(12.0)) API_AVAILABLE(ios(12.0)){

    AssemblyModel *model = self.model;
 
    model.officeID = voiceShortcut.identifier.UUIDString;
    NSLog(@"addVoiceShortcutViewController");
    if (self.successblock) {
        self.successblock(model);
    }
 
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)userActivityWillSave:(NSUserActivity *)userActivity
{

    userActivity.userInfo = @{@"deviceSN":self.model.deviceSN,
                              @"orderType":self.model.orderType,
    };
}

- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didUpdateVoiceShortcut:(nullable INVoiceShortcut *)voiceShortcut error:(nullable NSError *)error
API_AVAILABLE(ios(12.0)){
    AssemblyModel *model = self.model;
    model.officeID = voiceShortcut.identifier.UUIDString;
    NSLog(@"editVoiceShortcutViewController");
    
    if (self.successblock) {
        self.successblock(model);
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didDeleteVoiceShortcutWithIdentifier:(NSUUID *)deletedVoiceShortcutIdentifier
API_AVAILABLE(ios(12.0)){
    AssemblyModel *model = self.model;

    NSLog(@"editVoiceShortcutViewController");
    

    if (self.successblock) {
        self.successblock(model);
    }
    [controller dismissViewControllerAnimated:YES completion:nil];

}

- (void)editVoiceShortcutViewControllerDidCancel:(INUIEditVoiceShortcutViewController *)controller
API_AVAILABLE(ios(12.0)){
    NSLog(@"editVoiceShortcutViewControllerDidCancel");
    

    if (self.fairblock) {
        self.fairblock(self.model);
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}



-(dispatch_queue_t)serialQueue{
    
    if (!_serialQueue) {
        _serialQueue = dispatch_queue_create("siri.com", DISPATCH_QUEUE_SERIAL);
    }
    return  _serialQueue;
}

-(void)initWithModel:(NSDictionary *)dic EditType:(NSString *)type Success:(nonnull SuccessBlock)blocksuccess Fair:(nonnull FairBlock)blockfair{
 
    
  
    self.successblock = blocksuccess;
    self.fairblock = blockfair;
    

    NSLog(@"请先初始化initWithModel");
    if (dic.allKeys.count < 3) {
        
        NSLog(@"请先初始化initWithModel");
        return;
    }
    self.editType = type;
    self.model = [[AssemblyModel alloc]initWithDeviceSN:[dic valueForKey:@"deviceSN"] OrderName:[dic valueForKey:@"orderName"] OrderType:[dic valueForKey:@"orderType"]];
    [self EditVoice];
}




-(void )GetAllVoiceResult:(ResultBlock)blockresult{
    
    self.resultblock = blockresult;
     __block NSMutableArray *array_temp = [NSMutableArray array];

    dispatch_async(self.serialQueue, ^{
    
  
        [INVoiceShortcutCenter.sharedCenter getAllVoiceShortcutsWithCompletion:^(NSArray<INVoiceShortcut *> * _Nullable voiceShortcuts, NSError * _Nullable error) {

            
            
              if(error)
              {
             
                  NSLog(@"%@",error);
              }
              else
              {
                 
                  for (INVoiceShortcut *shortcut in voiceShortcuts) {
                     
                      [array_temp addObject:shortcut.identifier.UUIDString];
                  }
              }
        
            self.voiceArray = array_temp;
      
            if (self.resultblock) {
                self.resultblock(array_temp);
            }
        }];   
    });
    
}


@end
