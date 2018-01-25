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
                  properties:(NSDictionary *)properties)

RCT_EXTERN_METHOD(push:(NSString *)sceneName
                  properties:(NSDictionary *)properties)

RCT_EXTERN_METHOD(present:(NSString *)screenName
                  properties:(NSDictionary *)properties)

RCT_EXTERN_METHOD(pop:(BOOL)animated)
RCT_EXTERN_METHOD(dismiss:(BOOL)animated)

@end
