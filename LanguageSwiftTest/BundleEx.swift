//
//  NSBundle+Language.swift
//  LanguageSwiftTest
//
//  Created by Moayad Al kouz on 8/11/16.
//  Copyright © 2016 Moayad Al kouz. All rights reserved.
//

import Foundation
import ObjectiveC


var _bundle: UInt8 = 0;

class BundleEx: NSBundle {
    override func localizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        let bundle:NSBundle? = objc_getAssociatedObject(self, &_bundle) as? NSBundle;
        
        if let temp = bundle{
            return temp.localizedStringForKey(key, value: value, table: tableName);
        }else{
            return super.localizedStringForKey(key, value: value, table: tableName);
        }
    }
    
   
}

extension NSBundle {
    
    
    class func setLanguage(language:String?){
        var oneToken: dispatch_once_t = 0
        //let associatedObjectHandle = "nsh_DescriptiveName";
        dispatch_once(&oneToken) {
            object_setClass(NSBundle.mainBundle(), BundleEx.self as AnyClass);
        }
        
        
        
        if let temp = language{
            
            objc_setAssociatedObject(NSBundle.mainBundle(), &_bundle, NSBundle(path: NSBundle.mainBundle().pathForResource(temp, ofType: "lproj")!), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }else{
            objc_setAssociatedObject(NSBundle.mainBundle(), &_bundle, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        
        
    }
}


