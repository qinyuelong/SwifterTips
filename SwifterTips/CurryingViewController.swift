//
//  CurryingViewController.swift
//  SwifterTips
//
//  Created by qinge on 2017/6/18.
//  Copyright © 2017年 qin. All rights reserved.
//  http://swifter.tips/currying/
//  https://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/?utm_campaign=iOS_Dev_Weekly_Issue_157&utm_medium=email&utm_source=iOS%252BDev%252BWeekly

import UIKit

class CurryingViewController: BaseViewController {

    let button = Control()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let addTwo = addTo(adder: 2)
        let result = addTwo(4)
        print("result = \(result)")
        
        let greaterThan10 = greaterThan(comparer: 10)
        print("greaterThan10(20) \(greaterThan10(20))")
        print("greaterThan10(5) \(greaterThan10(5))")
        
        
        
        button.setTarget(target: self, action: CurryingViewController.onButtonTap, controlEvent: .TouchUpInside)
        button.performActionForControlEvent(controlEvent: .TouchUpInside)
    }

    func onButtonTap() {
        print("Button was tapped")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addTo(adder: Int) -> (Int) -> Int {
        return {
            num in
            return num + adder
        }
    }
    
    
    func greaterThan(comparer: Int) -> (Int) -> Bool {
        return {$0 > comparer}
    }

}


    //MARK: - 使用柯里化 实现 target action 

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>: TargetAction  {
    weak var target: T?
    let action: (T) -> () -> ()
    
    func performAction() {
        if let t = target {
            action(t)()
        }
    }
}

enum ControlEvent {
    case TouchUpInside
    case ValueChanged
    // ...
}


class Control {
    var actions = [ControlEvent: TargetAction]()
    
    func setTarget<T: AnyObject>(target: T, action: @escaping (T) -> () -> (), controlEvent: ControlEvent) {
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}
