//
//  ViewController.swift
//  MHImageCacheTest
//
//  Created by LittleFoxiOSDeveloper on 2023/03/31.
//

import UIKit
import MHImageCache
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    var ic: MHImageCache?
    
    var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    //input your image and image path
    let path = "\(Bundle.main.resourcePath ?? "")/Images"
    lazy var dataSource:[ImageFrom] = {
        [
        .folder(fileDirectory: self.path, imgName: "icons_1"),
        .folder(fileDirectory: self.path, imgName: "icons_2"),
        .folder(fileDirectory: self.path, imgName: "icons_3"),
        .folder(fileDirectory: self.path, imgName: "icons_3"),
    ]
    }()
    
    
    init(ic: MHImageCache) {
        self.ic = ic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ic?.setImageCache(imageFrom: self.dataSource, allCompletionCallback: { isAllLoded in
            
            if isAllLoded{
                self.makeTableView()
            }
        })
    }
    
    private func makeTableView(){
        self.tableView = {
            let v = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)), style: .plain)
            v.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.identifier)
            v.center.x = self.view.center.x
            v.center.y = self.view.center.y
            v.rowHeight = 100
            v.backgroundColor = .systemBlue
            return v
        }()
        self.view.addSubview(tableView)

        var dataSourceObv = Observable<[UIImage?]>.create { ob in
            var imgs: [UIImage?] = []
            for i in 0..<self.dataSource.count{
                self.ic?.loadImage(imageFrom: self.dataSource[i], completionCallback: { image, isCompleted, error  in
                    
                    if isCompleted{
                        imgs.append(image)
                    }
                    
                    if self.dataSource.count == imgs.count{
                        ob.onNext(imgs)
                    }
                })
            }
            return Disposables.create()
        }
        
        dataSourceObv.asObservable().bind(to: tableView.rx.items(cellIdentifier: MyTableViewCell.identifier, cellType: MyTableViewCell.self)) {(row, element, cell) in
            cell.bind(image: element)
//            cell.image = element
        }.disposed(by: disposeBag)
    }
}

class MyTableViewCell: UITableViewCell{
    
    static let identifier = "MyTableViewCell"
    
    var label: UILabel!
    var imgView: UIImageView!
    
    var key: String = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeView(){
        
        
        self.contentView.backgroundColor = .white
        
        self.label = {
            let lb = UILabel()
            lb.textColor = .black
            lb.frame.size.width = self.contentView.frame.size.width/2
            lb.sizeToFit()
            lb.center.x = self.contentView.center.x
            lb.center.y = self.contentView.frame.size.height/2
            return lb
        }()
        self.contentView.addSubview(self.label)
        
        self.imgView = {
            let height = self.contentView.frame.size.height
            let img = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: height)))
            img.frame.origin.x = self.contentView.frame.size.width*0.2
            return img
        }()
        self.contentView.addSubview(self.imgView)
    }
    
    func bind(text: String){
        self.label.text = text
        self.label.frame.size.width = self.contentView.frame.size.width/2
        self.label.textAlignment = .center
        self.label.sizeToFit()
        self.label.center.x = self.contentView.center.x
        self.label.center.y = self.contentView.frame.size.height/2
    }
    
    func bind(image: UIImage?){
        guard let image = image else{
            return
        }
        
        self.imgView.image = image
        
        self.imgView.frame.size.width = self.imgView.frame.size.height*(image.size.width/image.size.height)
        self.imgView.frame.origin.y = self.contentView.frame.size.height/2
    }
}
extension MyTableViewCell{
    var image: Binder<UIImage?>{
        Binder(self.imgView) { imgView, img in
            imgView.image = img
        }
    }
}

