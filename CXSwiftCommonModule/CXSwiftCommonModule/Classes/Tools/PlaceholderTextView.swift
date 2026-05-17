//
//  PlaceholderTextView.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/29.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit

@IBDesignable
public class PlaceholderTextView: UITextView {
    
    private lazy var placeholderLab = UILabel()
    
    public var limitCount: Int?
    public var wordSpace: CGFloat?
    
    public var placeholder: String = "" {
        didSet {
            placeholderLab.text = placeholder
            setNeedsLayout()
        }
    }
    
    public var placeholderFontSize: CGFloat = 12 {
        didSet {
            placeholderLab.font = UIFont.systemFont(ofSize: placeholderFontSize)
            setNeedsLayout()
        }
    }
    //    @IBInspectable
    public var placeholderColor: UIColor = UIColor(red: 0.6,
                                                   green: 0.6,
                                                   blue: 0.6,
                                                   alpha: 1) {
        didSet {
            placeholderLab.textColor = placeholderColor
        }
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        var frame = placeholderLab.frame
        frame.size.width = self.frame.size.width - 2 * placeholderLab.frame.minX
        placeholderLab.frame = frame
        placeholderLab.sizeToFit()
    }
    
}

private extension PlaceholderTextView {
    
    func setupUI() {
        
        placeholderLab.numberOfLines = 0
        placeholderLab.textColor = UIColor(red: 0.6,
                                           green: 0.6,
                                           blue: 0.6,
                                           alpha: 1)
        
        placeholderLab.frame.origin = CGPoint(x: 5, y: 8)
        placeholderLab.font = UIFont.systemFont(ofSize: 12)
        placeholderLab.sizeToFit()
        
        addSubview(placeholderLab)
        
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(textChanged(_:)),
                         name: UITextView.textDidChangeNotification,
                         object: self)
        
    }
    
    @objc
    func textChanged(_ notification: Notification) {
        
        placeholderLab.isHidden = self.hasText
        guard let textView = notification.object as? PlaceholderTextView,
              let limitNum = limitCount else {
            return
        }
        if textView.markedTextRange == nil && textView.text.count > limitNum {
            textView.text = textView.text.ph_substring(start: 0, limitNum)
        }
    }
    
}

private extension String {
    func ph_substring(start: Int, _ count: Int) -> String {
        let begin = index(startIndex, offsetBy: max(0, start))
        let end = index(startIndex, offsetBy: min(count, start + count))
        return String(self[begin..<end])
    }
}
