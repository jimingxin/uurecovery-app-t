//
//  ViewController.swift
//  CXSwiftCommonModule
//
//  Created by zainguo on 09/29/2020.
//  Copyright (c) 2020 zainguo. All rights reserved.
//

import UIKit
//import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tf_input: UITextField!
    
    @IBOutlet weak var tf_input2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        self.cx.navigationBar?.title = "222"
        let a = UIDevice.current.systemVersion
        // Do any additional setup after loading the view, typically from a nib.
        let lab = UILabel()
        
        cx.navigationBar?.title = "测试"
        cx.navigationBar?.backgroundColor = .red
        
        var value: String = "23.12555".decimalNumber().round()
        debugPrint(value)
        
        value = "23.12355".decimalNumber().str()
        debugPrint(value)
        
        let nvalue = "23.12555".decimalNumber().round(type: NSDecimalNumber.self)
        debugPrint(value)
        tf_input.isIndexEnd = true
        tf_input2.isIndexEnd = true
            
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

