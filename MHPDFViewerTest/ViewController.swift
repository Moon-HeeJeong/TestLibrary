//
//  ViewController.swift
//  MHPDFViewerTest
//
//  Created by LittleFoxiOSDeveloper on 2023/04/07.
//

import UIKit
import MHPDFViewer

class ViewController: UIViewController {
    
    var pdfViewer: MHPDFViewer?
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.makeDownloadBtn()
        self.setPDFViewer()
    }
    
    func makeDownloadBtn(){
        let downloadBtn: UIButton = {
            let w = self.view.frame.size.width*(300.0/1125.0)
            let h = w/2
            let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: w, height: h)))
            btn.backgroundColor = .systemBlue
            btn.center = self.view.center
            btn.setTitle("Download", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.addTarget(self, action: #selector(btnCallback(sender:)), for: .touchUpInside)
            return btn
        }()
        self.view.addSubview(downloadBtn)
    }
    
    func setPDFViewer(){
        self.pdfViewer?.setClosure(closure: {[weak self] status  in
            switch status{
            case .start:
                print("download start")
                break
            case .end(let isSuccess, let errorMessage):
                print("download success:\(isSuccess) end ")
                if !isSuccess{
                    print("pdf error : \(errorMessage)")
                }
                break
            case .ing:
                break
            }
        })
    }

    @objc func btnCallback(sender: UIButton){
        print("click btn")
        
        self.pdfViewer?.open(urlStr: "pdf url", title: "test url~ ")
    }
}


