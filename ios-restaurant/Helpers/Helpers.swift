//
//  Helper.swift
//  ec-calendar
//
//  Created by Hugo on 20/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import EventKit
import Photos

class Helper {
    
    static func isCalendarPermissionGranted() -> Bool {
        
        var havePermission = false
        
        let eventStore = EKEventStore()
        let status = EKEventStore.authorizationStatus(for: .event);
        
        switch status {
            case .authorized:
                havePermission = true;
                break;
            case .denied:
                havePermission = false;
                break
            case .notDetermined:
                eventStore.requestAccess(to: .event, completion:
                    {(granted: Bool, error: Error?) -> Void in
                        if granted {
                            havePermission = true;
                        } else {
                            havePermission = false;
                        }
                })
                break;
            default:
                break;
            
        }
        
        return havePermission;
    }
    
    static func isCameraPermissionGranted() -> Bool {
        var havePermission = false;
        
        let cameraMediaType = AVMediaType.video
        let status = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch status {
            case .authorized:
                havePermission = true;
                break;
            case .denied:
                havePermission = false;
                break;
            case .notDetermined:
                // Prompting user for the permission to use the camera.
                AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                    if granted {
                        havePermission = true;
                    } else {
                        havePermission = false;
                    }
                }
                break;
            default:
                break;
        }
        
        return havePermission;
    }
    
    static func isGalleryPermissionGranted() -> Bool {
        var havePermission = false;
        let status = PHPhotoLibrary.authorizationStatus();
        
        switch status {
            case .authorized:
                havePermission = true;
                break;
            case .denied:
                havePermission = false;
                break;
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { (status) in
                    if status == .authorized {
                        havePermission = true;
                    } else {
                        havePermission = false;
                    }
                }
                break;
            default:
                break;
        }
        
        return havePermission;
    }
    
    static func string2Date(dateString:String) -> Date {
        let df:DateFormatter = DateFormatter();
        df.dateFormat = "yyyy-MM-dd";
        return df.date(from: dateString)!;
    }
    
    static func date2String(date: Date, format: String) -> String {
        let df:DateFormatter = DateFormatter();
        df.dateFormat = format;
        return (date != nil) ? df.string(from:date) : "";
    }
    
    static func date2TimeString(date:Date?) -> String {
        let df:DateFormatter = DateFormatter();
        df.dateFormat = "HH:mm";
        return (date != nil) ? df.string(from:date!) : "";
    }
    
    
    static func Localized(key:String) -> String {
        let language = currentLanguage();
        let path: String? = Bundle.main.path(forResource: language, ofType: "lproj") ?? "";
        let budle: Bundle? = Bundle(path: path!);
        if budle == nil
        {
            return NSLocalizedString(key, comment: "");
        }
        return NSLocalizedString(key, tableName: nil, bundle: budle!, value: "", comment: "")
    }
    
    static func changeLanguage(code:String) -> Void {
        UserDefaults.standard.set([code], forKey: "AppleLanguages");
        UserDefaults.standard.synchronize();
    }
    
    static func currentLanguage() -> String {
        let language = UserDefaults.standard.value(forKey: "AppleLanguages") as! NSArray;
        //        UserDefaults.standard.synchronize();
        
        return language.firstObject as! String;
    }
    
    

    
    static func reuqestGalleryPermission() -> Void {
        
    }
    
    static func askPermission() -> Void {
        isCameraPermissionGranted();
        isGalleryPermissionGranted();
    }
    
    static func isLogined() -> Bool {
        return StorageHelper.getUserInfo().name != "";
    }
    
    static func logout() {
        StorageHelper.clearUserInfo();
    }
}
