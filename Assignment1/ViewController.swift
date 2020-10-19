//
//  ViewController.swift
//  Assignment1
//
//  Created by 丸山翔太郎 on 2020/10/16.
//

import UIKit

class ViewController: UIViewController {

    // view.frame をそのまま使う、で事足りると思います
//    lazy var viewFrame = {
//        view.frame
//    }()

    // private付けましょう
    // ここで5つ生成すると fieldCount が要らなくなると思います
    private var textFields:[UITextField] = [UITextField](repeating: UITextField(), count: 5)

    // private付けましょう
    private let resultLabel = UILabel()

    // private付けましょう
    private let returnButton = UIButton()

//    let fieldCount = 5

    //viewDidLoadで画面に追加し下記のviewDidLayoutSubviewsでviewのframeに合わせて配置しています
    //viewのライフサイクルがイマイチ理解しきれておらず使っているメソッドが適切かどうか自信がありません。
    override func viewDidLoad() {
        super.viewDidLoad()

        // forEach でスッキリ書けます
//        for _ in 1...fieldCount{
//            let textField = UITextField()
//            textFields.append(textField)
//            view.addSubview(textField)
//        }

        textFields.forEach {
            view.addSubview($0)
        }

        view.addSubview(returnButton)
        resultLabel.text = "0.0"
        view.addSubview(resultLabel)
    }

    override func viewDidLayoutSubviews() {
        // 追加
        super.viewDidLayoutSubviews()

//        for i:Int in 0..<textFields.count{
//            textFields[i].borderStyle = .line
//            textFields[i].frame.size = CGSize(width:100, height:30)
//            textFields[i].center.x =  view.frame.width / 2
//            textFields[i].center.y = (view.frame.height / 3) * (CGFloat(i + 1)/5)
//        }

        // forEach でスッキリ
        textFields.enumerated().forEach {
            $0.element.borderStyle = .line
            $0.element.frame.size = CGSize(width:100, height:30)
            $0.element.center.x =  view.frame.width / 2

            // UIStackViewでまとめたほうがスッキリするかもですね
            $0.element.center.y = (view.frame.height / 3) * (CGFloat($0.offset + 1)/5)
        }

        returnButton.setTitle("合計", for: .normal)
        returnButton.setTitleColor(.blue, for: .normal)
        returnButton.layer.cornerRadius = 5
        returnButton.layer.borderColor = UIColor.gray.cgColor
        returnButton.layer.borderWidth = 1
        returnButton.bounds.size = CGSize(width: 80, height: 30)
        returnButton.center.x = view.frame.width / 2
        returnButton.center.y = view.frame.height / 2

        // UIControl.Event は不要です
        returnButton.addTarget(self, action: #selector(buttonEvent(_:)), for: .touchUpInside)

        resultLabel.frame = CGRect(x: returnButton.frame.maxX + 30,
                                   y: returnButton.frame.minY,
                                   width: 100, height: 30)
    }


    @objc func buttonEvent(_ sender: UIButton) {
//        var calcResult:Double = 0
//        for textField in textFields{
//            if let num = Double(textField.text ?? "0.0"){
//                calcResult += num
//            }
//        }

        // map と reduce でスッキリ
        let calcResult = textFields
            .map { Double($0.text ?? "0.0") ?? 0.0 }
            .reduce(0.0, +)

        resultLabel.text = String(calcResult)
    }
}
