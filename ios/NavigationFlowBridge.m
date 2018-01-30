//
//  NavigationFlowBridge.m
//  RNNavigationFlow
//
//  Created by Shahen Hovhannisyan on 1/25/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ReactNavigationFlow, NSObject)
+ (BOOL)requiresMainQueueSetup
{
    return NO;
}

RCT_EXTERN_METHOD(registerScreen:(NSString *)sceneName
                  properties:(NSDictionary *)properties
                  waitForRender: (BOOL *)waitForRender)

RCT_EXTERN_METHOD(push:(NSString *)sceneName
                  props:(NSDictionary *)props
                  options:(NSDictionary *)options
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(present:(NSString *)screenName
                  props:(NSDictionary *)props
                  options:(NSDictionary *)options
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(firstRenderComplete:(NSString *)navFlowInstanceId)

RCT_EXTERN_METHOD(pop:(NSDictionary *)payload
                  options:(NSDictionary *)options)

RCT_EXTERN_METHOD(dismiss:(NSDictionary *)payload
                  options:(NSDictionary *)options)

@end
