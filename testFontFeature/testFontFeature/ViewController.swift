//
//  ViewController.swift
//  TestCoreText
//
//  Created by alibaba on 2017/5/28.
//  Copyright © 2017年 ddrccw. All rights reserved.
//

import UIKit


class Receiver {
    
    @objc func convertTimeFromSeconds(seconds: NSInteger) -> String {
        if (0 == seconds) {
            return "0:00";
        }
        
        var result:NSString = "";
        
        let secs = seconds;
        
        var tempMinute  = 0;
        var tempSecond  = 0;
        
        var minute   = "";
        var second   = "";
        
        tempMinute  = secs / 60;
        tempSecond  = secs - tempMinute * 60;
        
        minute = NSNumber.init(value: tempMinute).stringValue
        second = NSNumber.init(value: tempSecond).stringValue
        
        
        if (tempSecond < 10) {
            second = "0".appending(second)
        }
        
        //        result = NSString(format: "%@:%@", 3, 3)
        result = NSString(format: "%@:%@", minute, second)
        
        return result as String
    }
    
    
    @objc func monospacesFont() -> UIFont {
        var font:UIFont? = nil
        if #available(iOS 9.0, *) {
            //9以上只能用该方法
            font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: UIFontWeightRegular)
            debugPrint("button2 Descriptor")
            debugPrint(font?.fontDescriptor);

        } else {
            let sysFont = UIFont.systemFont(ofSize: 13)
            let featureSettings = [UIFontFeatureTypeIdentifierKey:kNumberSpacingType,
                                   UIFontFeatureSelectorIdentifierKey:kMonospacedNumbersSelector]
            let originalDescriptor = sysFont.fontDescriptor
            debugPrint("button2 originalDescriptor")
            debugPrint(originalDescriptor);
            
            let descriptor = originalDescriptor.addingAttributes([UIFontDescriptorFeatureSettingsAttribute: featureSettings])
            debugPrint("button2 descriptor")
            debugPrint(descriptor);
            
            // Size 0 to use previously set font size
            let targetFont = UIFont(descriptor: descriptor, size: 0.0)
            font = targetFont
        }
    
        
        let fontFeatures = CTFontCopyFeatures(font as! CTFont)
        debugPrint("button2 fontFeatures")
        debugPrint(fontFeatures);
        return font!
        
    }
    
    @objc func font() -> UIFont {
        let sysFont = UIFont.systemFont(ofSize: 13)
        
        debugPrint("button1 descriptor")
        debugPrint(sysFont.fontDescriptor);
        
        let fontFeatures = CTFontCopyFeatures(sysFont as! CTFont)
        debugPrint("button1 fontFeatures")
        debugPrint(fontFeatures);
        
        
        return sysFont
    }
    
    var timer1: Timer? = nil
    var button1: UIButton? = nil
    var seconds1: NSInteger = 0
    @objc func change(sender: UIButton) {
        button1 = sender
        
        if sender.isSelected == false {
            timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick1), userInfo: nil, repeats: true)
        } else {
            timer1?.invalidate()
        }
        
        sender.isSelected = !sender.isSelected
    }
    
    @objc func tick1() -> Void {
        self.seconds1 = self.seconds1 + 1
        let dateString = self.convertTimeFromSeconds(seconds: self.seconds1)
        self.button1!.setTitle(dateString, for: .normal)
        debugPrint("button1 \(self.button1?.titleLabel as Any) ")
    }
    
    var timer2: Timer? = nil
    var button2: UIButton? = nil
    var seconds2: NSInteger = 0
    @objc func change2(sender: UIButton) {
        button2 = sender
        
        if sender.isSelected == false {
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick2), userInfo: nil, repeats: true)
        } else {
            timer2?.invalidate()
        }
        
        sender.isSelected = !sender.isSelected
    }
    
    @objc func tick2() -> Void {
        self.seconds2 = self.seconds2 + 1
        let dateString = self.convertTimeFromSeconds(seconds: self.seconds2)
        
        let string = NSAttributedString(string: dateString, attributes: [NSFontAttributeName: self.button2?.titleLabel?.font])
        self.button2?.setAttributedTitle(string, for: .normal)
        debugPrint("button2 \(self.button2?.titleLabel as Any) ")
    }
    
}


class ViewController: UIViewController {
    var receiver: Receiver? = nil
    var button1: UIButton?
    var button2: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        receiver = Receiver()
        
        button1 = UIButton(frame: CGRect(x: 5, y: 50, width: 300, height: 50))
        button1?.backgroundColor = UIColor.blue
        button1?.setTitle("start", for: .normal)
        button1?.titleLabel?.font = receiver?.font()
        button1?.titleLabel?.textColor = UIColor.white
        button1?.addTarget(receiver, action:#selector(receiver?.change(sender:)), for: .touchUpInside)
        view.addSubview(button1!)
        debugPrint(button1?.titleLabel)
        
        
        
        button2 = UIButton(frame: CGRect(x: 5, y: 110, width: 300, height: 50))
        button2?.backgroundColor = UIColor.gray
        button2?.titleLabel?.font = receiver?.monospacesFont()
        button2?.titleLabel?.textColor = UIColor.white
        button2?.setAttributedTitle(NSAttributedString(string: "start"), for: .normal)
        
        button2?.addTarget(receiver, action:#selector(receiver?.change2(sender:)), for: .touchUpInside)
        view.addSubview(button2!)
        
        let actionButton = UIButton(frame: CGRect(x: 5, y: 200, width: 300, height: 50))
        actionButton.backgroundColor = UIColor.red
        actionButton.setTitle("start", for: .normal)
        actionButton.titleLabel?.textColor = UIColor.white
        view.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(action), for: .touchUpInside)
    }
    
    @objc
    func action() -> Void {
        receiver?.change(sender: button1!)
        receiver?.change2(sender: button2!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

