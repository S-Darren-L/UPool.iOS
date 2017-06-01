//
//  NetworkConvenience.swift
//  UPool
//
//  Created by Darren on 2017-05-31.
//  Copyright © 2017 UPool.iOS. All rights reserved.
//

import UIKit
import Foundation

// MARK: - NetworkClient (Convenient Resource Methods)

extension NetworkClient {
    
//    func authenticateWithViewController(_ hostViewController: UIViewController, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
//        
//        // chain completion handlers for each request so that they run one after the other
//        getRequestToken() { (success, requestToken, errorString) in
//            
//            if success {
//                
//                // success! we have the requestToken!
//                print(requestToken as Any)
//                self.requestToken = requestToken
//                
//                self.loginWithToken(requestToken, hostViewController: hostViewController) { (success, errorString) in
//                    
//                    if success {
//                        self.getSessionID(requestToken) { (success, sessionID, errorString) in
//                            
//                            if success {
//                                
//                                // success! we have the sessionID!
//                                self.sessionID = sessionID
//                                
//                                self.getUserID() { (success, userID, errorString) in
//                                    
//                                    if success {
//                                        
//                                        if let userID = userID {
//                                            
//                                            // and the userID 😄!
//                                            self.userID = userID
//                                        }
//                                    }
//                                    
//                                    completionHandlerForAuth(success, errorString)
//                                }
//                            } else {
//                                completionHandlerForAuth(success, errorString)
//                            }
//                        }
//                    } else {
//                        completionHandlerForAuth(success, errorString)
//                    }
//                }
//            } else {
//                completionHandlerForAuth(success, errorString)
//            }
//        }
//    }
    
    private func getRequestToken(_ completionHandlerForToken: @escaping (_ success: Bool, _ requestToken: String?, _ errorString: String?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [String:AnyObject]()
        
        /* 2. Make the request */
        let _ = taskForGETMethod(Methods.AuthenticationTokenNew, parameters: parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForToken(false, nil, "Login Failed (Request Token).")
            } else {
                if let requestToken = results?[NetworkClient.JSONResponseKeys.RequestToken] as? String {
                    completionHandlerForToken(true, requestToken, nil)
                } else {
                    print("Could not find \(NetworkClient.JSONResponseKeys.RequestToken) in \(String(describing: results))")
                    completionHandlerForToken(false, nil, "Login Failed (Request Token).")
                }
            }
        }
    }
    
//    private func loginWithToken(_ requestToken: String?, hostViewController: UIViewController, completionHandlerForLogin: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
//        
//        let authorizationURL = URL(string: "\(NetworkClient.Constants.AuthorizationURL)\(requestToken!)")
//        let request = URLRequest(url: authorizationURL!)
//        let webAuthViewController = hostViewController.storyboard!.instantiateViewController(withIdentifier: "NetworkAuthViewController") as! NetworkAuthViewController
//        webAuthViewController.urlRequest = request
//        webAuthViewController.requestToken = requestToken
//        webAuthViewController.completionHandlerForView = completionHandlerForLogin
//        
//        let webAuthNavigationController = UINavigationController()
//        webAuthNavigationController.pushViewController(webAuthViewController, animated: false)
//        
//        performUIUpdatesOnMain {
//            hostViewController.present(webAuthNavigationController, animated: true, completion: nil)
//        }
//    }
    
    private func getSessionID(_ requestToken: String?, completionHandlerForSession: @escaping (_ success: Bool, _ sessionID: String?, _ errorString: String?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [NetworkClient.ParameterKeys.RequestToken: requestToken!]
        
        /* 2. Make the request */
        let _ = taskForGETMethod(Methods.AuthenticationSessionNew, parameters: parameters as [String:AnyObject]) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForSession(false, nil, "Login Failed (Session ID).")
            } else {
                if let sessionID = results?[NetworkClient.JSONResponseKeys.SessionID] as? String {
                    completionHandlerForSession(true, sessionID, nil)
                } else {
                    print("Could not find \(NetworkClient.JSONResponseKeys.SessionID) in \(String(describing: results))")
                    completionHandlerForSession(false, nil, "Login Failed (Session ID).")
                }
            }
        }
    }
    
    private func getUserID(_ completionHandlerForUserID: @escaping (_ success: Bool, _ userID: Int?, _ errorString: String?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [NetworkClient.ParameterKeys.SessionID: NetworkClient.sharedInstance().sessionID!]
        
        /* 2. Make the request */
        let _ = taskForGETMethod(Methods.Account, parameters: parameters as [String:AnyObject]) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForUserID(false, nil, "Login Failed (User ID).")
            } else {
                if let userID = results?[NetworkClient.JSONResponseKeys.UserID] as? Int {
                    completionHandlerForUserID(true, userID, nil)
                } else {
                    print("Could not find \(NetworkClient.JSONResponseKeys.UserID) in \(String(describing: results))")
                    completionHandlerForUserID(false, nil, "Login Failed (User ID).")
                }
            }
        }
    }
    
    func getConfig(_ completionHandlerForConfig: @escaping (_ didSucceed: Bool, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [String:AnyObject]()
        
        /* 2. Make the request */
        let _ = taskForGETMethod(Methods.Config, parameters: parameters as [String:AnyObject]) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForConfig(false, error)
            } else if let newConfig = NetworkConfig(dictionary: results as! [String:AnyObject]) {
                self.config = newConfig
                completionHandlerForConfig(true, nil)
            } else {
                completionHandlerForConfig(false, NSError(domain: "getConfig parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getConfig"]))
            }
        }
    }
}
