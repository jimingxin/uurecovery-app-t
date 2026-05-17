//
//  ServerTimerView.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/3/8.
//

import UIKit
import DefaultsKit

class ServerTimerView: BaseView {

    lazy var v_root = UIView();
    lazy var lab_desc = UILabel.init(title: "限时折扣倒计时", textColor: .hex("#FA823E"), fontSize: 14)
    lazy var lab_time = UILabel.init(title: "", textColor: .hex("#FA823E"), fontSize: 14).then { lab in
        lab.textAlignment = .right
    }
    static let TIME_OUT_VALUE: Int = 600 * 7
    var timeOut: Int = TIME_OUT_VALUE
    
    override func baseAddSubViews() {
        
        v_root.flex.direction(.row)
            .alignItems(.center)
            .width(100%)
            .paddingLeft(10)
            .backgroundColor(.hex("#FFF8F0"))
            .define { flex in
//                flex.addItem(UIImageView(imageName: "server_time")).width(12).height(12)
                flex.addItem(lab_desc).height(44).marginHorizontal(3)
                flex.addItem(lab_time).minWidth(65)
            }
        
        addSubview(v_root)
    }
    
    override func baseConfig() {
        
        timeOut = userDefaults.get(for: MXDefaultKey.timeOut) ?? ServerTimerView.TIME_OUT_VALUE
        let  now = Date().timeIntervalSince1970
        let timeInterval = userDefaults.get(for: MXDefaultKey.timeInterval) ?? now
        
        let distance = Int(now - timeInterval)
        
        if distance > timeOut {
            timeOut = ServerTimerView.TIME_OUT_VALUE
        } else {
            timeOut = timeOut - distance
        }
       
        if timeOut <= 60  {
            timeOut = ServerTimerView.TIME_OUT_VALUE
        }
        
        // 倒计时
        countdown(second: timeOut, immediately: true) { [weak self] second
            in
            let hour = second / 3600
            let min = (second / 60) % 60
            let sec = second % 60
            self?.timeOut = second
            self?.lab_time.text = String(format: "%02d:%02d:%02d ", hour, min, sec)
            self?.lab_time.flex.markDirty()
        }.subscribe { _ in }.disposed(by: disposeBag)
    
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        v_root.pin.left(20).top().bottom().width(Const.screenWidth - 40)
        v_root.flex.layout(mode: .adjustHeight)
        if v_root.cx.height > 0 {
            v_root.clearVisual.conrnerRadius(radius: 16).conrnerCorner(corner: [.topLeft, .topRight]).showVisual
        }
    }
    
    deinit {
        let timeInterval = Date().timeIntervalSince1970
        userDefaults.set(timeInterval, for: MXDefaultKey.timeInterval)
        userDefaults.set(timeOut, for: MXDefaultKey.timeOut)
    }

}
