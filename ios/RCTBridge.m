//
//  RCTBridge.m
//  NetworkStateListener
//
//  Created by Matheus Quirino on 26/02/22.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_REMAP_MODULE(RNNetworkStateListener, NetworkStateListener, RCTEventEmitter)
  RCT_EXTERN_METHOD(startNetworkWatching)
  RCT_EXTERN_METHOD(supportedEvents)
  RCT_EXTERN_METHOD(constantsToExport)
@end
