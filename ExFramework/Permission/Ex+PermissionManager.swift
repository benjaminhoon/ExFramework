//
//  ExPermissionManager.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 15..
//  Copyright © 2018년 Hoon. All rights reserved.
//

import Foundation
import UIKit
import AddressBook
import LocalAuthentication

public class ExPermissionManager {
    public static let shared = ExPermissionManager()
    private init() {}
}


public extension ExPermissionManager{
    
    /**
     * 주소록 권한 요청 ( 사용자가 이전에 거부했을 경우 셋팅 페이지로 이동 )
     * @param
     * @returns
     */
    func checkAddressBookPermission(){
        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
        
        switch authorizationStatus {
        case .denied, .restricted:
            if let url = URL(string: UIApplication.openSettingsURLString)
            {
                UIApplication.shared.openURL(url)
            }
            printFlag("Denied")
            break
        case .authorized:
            printFlag("Authorized")
            break
        case .notDetermined:
            printFlag("Not Determined")
            
            let addressBookRef = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
            ABAddressBookRequestAccessWithCompletion(addressBookRef, { (granted, error) in
                if error != nil {
                    DispatchQueue.main.async {
                       
                    }
                    return
                }
                
                if granted{
                    printFlag("사용자 권한 수락")
                }
                else {
                    printFlag("사용자 권한 거부")
                    DispatchQueue.main.async {
                       
                    }
                }
            }) // end block: ABAddressBookRequestAccessWithCompletion
            break
        }
    }
}

public extension ExPermissionManager{
    
    /**
     * 터치아이디 디바이스 지원여부
     * @param
     * @returns Bool
     */
    func isSupportTouchId(_ closure:@escaping (_ isAvailable:Bool, _ error:Error? )->Void?) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error){
            printFlag("Available TouchId")
            closure(true, nil)
            return
        }else{
            printFlag("unavailable TouchId")
            closure(false, error!)
//            switch error!{
//            case LAError.touchIDNotEnrolled: printError("등록된 지문이 없습니다."); break
//            case LAError.passcodeNotSet: printError("등록된 패스워드가 없습니다."); break
//            case LAError.touchIDNotAvailable: printError("터치아이디를 지원하지 않는 디바이스 입니다."); break
//            default: printError(error!.localizedDescription); break
//            }
            return
        }
    }
    
    /**
     * 터치아이디 인증 실행
     * @param
     * @returns
     */
    func beginTouchID(localizedReason:String = "Access requires authentication",_ closure:@escaping (_ isSuccess:Bool, _ error:Error? )->Void){
        let context = LAContext()
        context.evaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            localizedReason: localizedReason,
            reply: {(success, error) in
                
                guard let _ = error else{
                    printError(error!.localizedDescription)
//                    switch error!{
//                    case LAError.systemCancel: printError("인증 과정이 취소되었습니다."); break
//                    case LAError.userCancel: printError("인증에 실패하였습니다.."); break
//                    case LAError.userFallback: printError("터치아이디 대신 패스워드 인증을 선택하였습니다."); break
//                    default: printError(error!.localizedDescription); break
//                    }
                    
                    DispatchQueue.main.async {
                        closure(false, error!)
                    }
                    return
                }
                printOK("success")
                
                DispatchQueue.main.async {
                    closure(true, nil)
                }
        })
    }
}
