//
//  ExternalModule.swift
//  app_checkin
//
//  Created by Matheus Quirino on 22/12/21.
//

import Foundation
import Network
import SystemConfiguration

@objc(NetworkStateListener)
class NetworkStateListener: NSObject, RCTEventEmitter, RCTBridgeModule {
    
    public static let NETWORK_STATE_EVENT : String = "isConnected"
  
//  var appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
//  //
//  public static var queue: DispatchQueue = DispatchQueue(label: "br.com.evolog.app_checkin.queue",
//                                           qos: .background,
//                                           attributes: [],
//                                           autoreleaseFrequency: .inherit,
//                                           target: nil)

  //   override init() {
  //     super.init()
  // }
    
    
  func createNetworkEventData(isConnected: Bool){
    let data: [String: Any] = [ NetworkStateListener.NETWORK_STATE_EVENT: isConnected ]
    DispatchQueue.main.async { [weak self] in
        self?.dispatch(name: NetworkStateListener.NETWORK_STATE_EVENT, body: data)
    }
  }
  func dispatch(name: String, body: Any?){
    DispatchQueue.main.async { [weak self] in
        self?.sendEvent(withName: name, body: body)
    }
  }
    
    public static func isConnectedToNetwork() -> Bool {
            
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    
                    SCNetworkReachabilityCreateWithAddress(nil, $0)
                    
                }
                
            }) else {
                
                return false
            }
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                return false
            }
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            return (isReachable && !needsConnection)
        }
    
  //EXPORTED
  @objc
  func startNetworkWatching() -> Void{
      print("@CALL NetworkManager.startNetworkWatching()")
    
      DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
      if #available(iOS 12.0, *) {
        //
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
          switch path.status {
          case .satisfied:
            self?.createNetworkEventData(isConnected: true)
            break
          case .unsatisfied:
              self?.createNetworkEventData(isConnected: false)
            break
          case .requiresConnection:
              self?.createNetworkEventData(isConnected: false)
            break
          @unknown default:
            print("NETWORK_ FATAL_ERROR")
            break
          }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
        //
      }else{
        if NetworkStateListener.isConnectedToNetwork() {
            self.createNetworkEventData(isConnected: true)
        } else {
            self.createNetworkEventData(isConnected: false)
        }
      }
    }
  }

  @objc
  override func supportedEvents() -> [String] {
    return [ NetworkStateListener.NETWORK_STATE_EVENT ]
  }
  
  @objc
  override func constantsToExport() -> [AnyHashable : Any]! {
    return [:]
  }

  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
    
  override static func moduleName() -> String! {
    return "RNNetworkStateListener"
  }
  
}
