//
//  ViewController.swift
//  Assignment1
//
//  Created by 丸山翔太郎 on 2020/10/16.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var viewFrame = {
        view.frame
    }()
    
    var textFields:[UITextField] = []
    
    let resultLabel = UILabel()
    
    let returnButton = UIButton()
    
    let fieldCount = 5
    
    //viewDidLoadで画面に追加し下記のviewDidLayoutSubviewsでviewのframeに合わせて配置しています
    //viewのライフサイクルがイマイチ理解しきれておらず使っているメソッドが適切かどうか自信がありません。
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...fieldCount{
            let textField = UITextField()
            textFields.append(textField)
            view.addSubview(textField)
        }
        view.addSubview(returnButton)
        view.addSubview(resultLabel)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        
        for i:Int in 0..<textFields.count{
            textFields[i].borderStyle = .line
            textFields[i].frame.size = CGSize(width:100, height:30)
            textFields[i].center.x =  viewFrame.width / 2
            textFields[i].center.y = (viewFrame.height / 3) * (CGFloat(i + 1)/5)
        }
        
        returnButton.setTitle("合計", for: .normal)
        returnButton.setTitleColor(.blue, for: .normal)
        returnButton.layer.cornerRadius = 5
        returnButton.layer.borderColor = UIColor.gray.cgColor
        returnButton.layer.borderWidth = 1
        returnButton.bounds.size = CGSize(width: 80, height: 30)
        returnButton.center.x = viewFrame.width / 2
        returnButton.center.y = viewFrame.height / 2
        returnButton.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
        
        resultLabel.frame = CGRect(x: returnButton.frame.maxX + 30,
                                   y: returnButton.frame.minY,
                                   width: 100, height: 30)
    }
    

    @objc func buttonEvent(_ sender: UIButton) {
        var calcResult:Double = 0
        for textField in textFields{
            if let num = Double(textField.text ?? "0.0"){
                calcResult += num
            }
        }
        resultLabel.text = String(calcResult)
    }
    
    
}

