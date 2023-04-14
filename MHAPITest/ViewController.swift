//
//  ViewController.swift
//  MHAPITest
//
//  Created by LittleFoxiOSDeveloper on 2023/04/10.
//

import UIKit
import MHAPI
import Alamofire

class ViewController: UIViewController {
    
    var api: AppleAPI?
    var textFieldView: UITextField!
    var searchBtn: UIButton!
    
    var resultCountLabel: UILabel!
    
    var resultCount: Int = 0{
        didSet{
            self.resultCountLabel.text = "검색결과 : \(self.resultCount)건"
            self.resultCountLabel.frame.size.width = self.textFieldView.frame.size.width
            self.resultCountLabel.sizeToFit()
            self.resultCountLabel.center.x = self.searchBtn.center.x
            self.resultCountLabel.center.y = self.searchBtn.frame.origin.y + self.textFieldView.frame.size.height*2
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemPurple
        self.makeView()
    }
    
    func callAPI(keyword: String?){
        self.api?.call(api: SearchAPIInfo(keyword: keyword, config:AppleAPIConfig()), completed: { res in
            print(res)
            
            self.resultCount = res.data?.resultCount ?? 0
            
        })
    }
    
    func makeView(){
        let fieldWidth = self.view.frame.size.width/2
        let fieldHeight = (100/500)*fieldWidth
        
        self.textFieldView = {
            let field = UITextField(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: fieldWidth, height: fieldHeight)))
            field.center.x = self.view.frame.size.width/2
            field.center.y = self.view.frame.size.height/2
            field.backgroundColor = .white
            field.textColor = .black
            field.placeholder = "input keyword"
            return field
        }()
        self.view.addSubview(self.textFieldView)
        
        self.searchBtn = {
            let btn = UIButton(frame: self.textFieldView.frame)
            btn.backgroundColor = .white
            btn.setTitle("Search", for: .normal)
            btn.setTitleColor(.systemPurple, for: .normal)
            btn.frame.origin.y = self.textFieldView.frame.origin.y + self.textFieldView.frame.size.height*2
            btn.addTarget(self, action: #selector(searchCallback(sender:)), for: .touchUpInside)
            return btn
        }()
        self.view.addSubview(self.searchBtn)
        
        self.resultCountLabel = {
            let lb = UILabel()
            lb.text = "검색 결과 : 0건"
            lb.textColor = .yellow
            lb.font = UIFont.boldSystemFont(ofSize: self.textFieldView.frame.size.height/2)
            lb.frame.size.width = self.textFieldView.frame.size.width
            lb.sizeToFit()
            lb.center.x = self.textFieldView.center.x
            lb.center.y = self.searchBtn.frame.origin.y + self.searchBtn.frame.size.height*2
            return lb
        }()
        self.view.addSubview(self.resultCountLabel)
    }
    
    
    @objc func searchCallback(sender: UIButton){
        print("search \(self.textFieldView.text)")
        self.callAPI(keyword: self.textFieldView.text)
    }
}

