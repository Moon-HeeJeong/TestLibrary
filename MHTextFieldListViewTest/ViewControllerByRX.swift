//
//  ViewControllerByRX.swift
//  MHTextFieldListViewTest
//
//  Created by LittleFoxiOSDeveloper on 2023/04/06.
//

import Foundation
import UIKit
import MHTextFieldListView
import RxSwift
import RxCocoa

class ViewControllerByRx: UIViewController {
    
    var selectedBtn: UIButton!
    var textFieldView: MHTextFieldListView<MenuKind>!
    
    private var _disposeBag = DisposeBag()
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        
        self.makeView()
        self.bind()
    }
    
    func bind(){
        
        self.selectedBtn.rx.tap.asObservable().bind {_ in
            self.textFieldView.isShow = !self.textFieldView.isShow
        }.disposed(by: self._disposeBag)
        
        self.textFieldView.rx.listTap.bind { kind in
            print("select \(kind)")
            self.textFieldView.isShow = !self.textFieldView.isShow
            self.selectedBtn.setTitle(kind.rawValue, for: .normal)
        }.disposed(by: self._disposeBag)
        
        self.textFieldView.rx.textKinds.onNext(MenuKind.allCases)
    }
    
    
    func makeView(){
        let btnWidth = self.view.frame.size.width*(250.0/1125.0)
        let btnHeight = btnWidth*(120.0/250.0)
        
        self.selectedBtn = {
            let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: btnWidth, height: btnHeight)))
            btn.center = self.view.center
            btn.backgroundColor = .blue
            btn.setTitleColor(.white, for: .normal)
            btn.addRoundSpecificedCorners(cornerRadius: 10, byRoundingCorners: .allCorners, boderColor: .white, boderWidth: 1)
            btn.setTitle("밥 선택", for: .normal)
            return btn
        }()
        
        self.textFieldView = {
            let v = MHTextFieldListView<MenuKind>(frame: CGRect(origin: CGPoint(x: self.selectedBtn.frame.origin.x, y: self.selectedBtn.frame.origin.y + self.selectedBtn.frame.size.height - 7), size: self.selectedBtn.frame.size),
                                        elementHeight: btnHeight,
                                        borderColor: .blue,
                                        textColor: .blue,
                                        leftMargin: btnWidth*0.1,
                                        textAlignment: .left,
                                        placeholder: "menu")
            v.backgroundColor = .white
            v.isShow = false
            return v
        }()
        self.view.addSubview(self.textFieldView)
        self.view.addSubview(self.selectedBtn)
    }
}
