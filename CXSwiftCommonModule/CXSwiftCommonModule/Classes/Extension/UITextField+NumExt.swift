//
//  UITextField+NumExt.swift
//  CXMerchant
//
//  Created by 嵇明新 on 2021/1/16.
//  Copyright © 2021 zainguo. All rights reserved.
//

import Foundation
import UIKit


// UITextField 添加numberOfDecimalDigits属性，
// 控制 UITextField 输入 keyboardType = .decimalPad 小数时的精度
// delegate 默认是UITextField 自己
// 如果delegate 重新赋值了，将不会生效
public extension UITextField {
    
    struct AssociatedKeys {
        static var numberOfDecimalDigitsKey = "UITextField.numberOfDecimalDigits"
        static var isIndexEnd = "isIndexEnd"
    }
    
    var numberOfDecimalDigits: Int? {
        get {
            guard let num = objc_getAssociatedObject(self, &AssociatedKeys.numberOfDecimalDigitsKey) as? Int else {
                objc_setAssociatedObject(self, &AssociatedKeys.numberOfDecimalDigitsKey, 0, .OBJC_ASSOCIATION_ASSIGN)
                return nil
            }
            return num
        }
        set (value) {
            self.keyboardType = .decimalPad
            self.delegate = self
            objc_setAssociatedObject(self, &AssociatedKeys.numberOfDecimalDigitsKey, value, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    
    /// 是否需要光标定位在最后面
    var isIndexEnd: Bool {
        get {
            guard let isEnd = objc_getAssociatedObject(self, &AssociatedKeys.isIndexEnd) as? Bool else {
                objc_setAssociatedObject(self, &AssociatedKeys.isIndexEnd, false, .OBJC_ASSOCIATION_ASSIGN)
                return false
            }
            return isEnd
        }
        
        set (value) {
            objc_setAssociatedObject(self, &AssociatedKeys.isIndexEnd, value, .OBJC_ASSOCIATION_ASSIGN)
            self.delegate = self
            self.setEditIndex(start: false)
        }
    }
    
}
extension UITextField: UITextFieldDelegate {
    
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        guard let oldText = textField.text,
              let r = Range(range, in: oldText),
              let numOfDigits = numberOfDecimalDigits else {
            return true
        }
        
        if numOfDigits == 0 {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= numOfDigits
        
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}

// MARK: - 添加方法监听
extension UITextField {
    
    /// 设置编辑开始的时候光标的位置
    /// - Parameter start: 是否设置开始的时候
    fileprivate func setEditIndex(start: Bool) {
        // 监听初始化方法，设置编辑的光标
        self.rx.sentMessage(#selector(UITextFieldDelegate.textFieldShouldBeginEditing(_:)))
            .subscribe(onNext: { [weak self] _ in
                debugPrint("before textFieldShouldBeginEditing")
                Asyncs.delay(0.01) {
                    self?.selectedRange(offset: self?.text?.count ?? 0)
                }
                
            })
            .disposed(by: CXConstraint.disposeBag)
    }
    
    
    
    fileprivate func selectedRange(offset: Int) {
        
        // 定位在最后
        if self.isIndexEnd {
            let offset = self.offset(from: self.beginningOfDocument, to: self.endOfDocument)
            let end = self.position(from: self.beginningOfDocument, offset: offset) ?? UITextPosition()
            self.selectedTextRange = self.textRange(from: end, to: end)
            
        } 
       
    }

}

