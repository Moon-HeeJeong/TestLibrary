//
//  ViewController.swift
//  MHTextFieldListViewTest
//
//  Created by LittleFoxiOSDeveloper on 2023/04/06.
//

import UIKit
import MHTextFieldListView

enum MenuKind: String, MHTextFieldListViewKindRequiresEnum, CaseIterable{
    case bread = "빵"
    case rice = "밥"
    case curry = "카레"
    case friedRice = "볶음밥"
}

class ViewController: UIViewController {
    var selectedBtn: UIButton!
    var textFieldView: MHTextFieldListView<MenuKind>!
    
    var menuKind: [MenuKind]?{
        didSet{
            guard let menuKind = menuKind else{
                return
            }
            self.textFieldView?.textKinds = menuKind
        }
    }

    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView(){
        let btnWidth = self.view.frame.size.width*(250.0/1125.0)
        let btnHeight = btnWidth*(120.0/250.0)
        
        self.selectedBtn = {
            let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: btnWidth, height: btnHeight)))
            btn.center = self.view.center
            btn.backgroundColor = .blue
            btn.setTitleColor(.white, for: .normal)
            btn.addTarget(self, action: #selector(tapBtn(sender:)), for: .touchUpInside)
            return btn
        }()
        self.view.addSubview(self.selectedBtn)
        
        self.textFieldView = {
            let v = MHTextFieldListView<MenuKind>(frame: CGRect(origin: CGPoint(x: self.selectedBtn.frame.origin.x, y: self.selectedBtn.frame.origin.y + self.selectedBtn.frame.size.height), size: self.selectedBtn.frame.size),
                                        elementHeight: btnHeight,
                                        borderColor: .blue,
                                        textColor: .blue,
                                        leftMargin: btnWidth*0.1,
                                        textAlignment: .left,
                                        placeholder: "menu")
            v.backgroundColor = .white
            v.isShow = false
            v.setTextFieldListTapped { [weak self] tag in
                self?.selectedMenu(tag: tag ?? .rice)
            }
            return v
        }()
        self.view.addSubview(self.textFieldView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.makeView()
        self.menuKind = MenuKind.allCases
    }
}

extension ViewController{
    @objc func tapBtn(sender: UIButton){
        self.textFieldView.isShow = !self.textFieldView.isShow
    }
    
    
    func selectedMenu(tag: MenuKind){
        self.textFieldView.isShow = !self.textFieldView.isShow
        self.selectedBtn.setTitle(tag.rawValue, for: .normal)
    }
}
