//
//  ViewController.swift
//  MHOrientationTest
//
//  Created by LittleFoxiOSDeveloper on 2023/04/06.
//

import UIKit
import MHOrientation

class ViewController: UIViewController {
    
    private var rotationBtn: UIButton!
    var orientation: MHOrientation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemPink
        self.makeView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.setWindow(size: size)
    }
    
    func makeView(){
        
        self.rotationBtn = {
            let w = self.view.frame.size.width/2
            let h = self.view.frame.size.height/3
            let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: w, height: h)))
            btn.backgroundColor = .white
            btn.setTitle("rotation", for: .normal)
            btn.setTitleColor(.systemPink, for: .normal)
            btn.titleLabel?.textAlignment = .center
            btn.center = self.view.center
            btn.addTarget(self, action: #selector(rotateBtnCallback(sender:)), for: .touchUpInside)
            return btn
        }()
        self.view.addSubview(self.rotationBtn)
    }
    
    func setWindow(size: CGSize){
        self.rotationBtn.center.x = size.width/2
        self.rotationBtn.center.y = size.height/2
    }
    
    @objc func rotateBtnCallback(sender: UIButton){

        if self.orientation?.currentOrientation == .portrait{
            self.orientation?.set(orientation: .landscapeLeft, { orientation in
//                self.setWindow()
            })
        }else{
            self.orientation?.set(orientation: .portrait, { orientation in
//                self.setWindow()
            })
        }
    }
}

