//
//  ViewController.swift
//  MHVideoPlayerTest
//
//  Created by LittleFoxiOSDeveloper on 2023/03/30.
//

import UIKit
import MHVideoPlayer

enum VideoPlayerStatus{
    case play
    case pause
}

class ViewController: UIViewController {
    

    private var playerView: MHVideoPlayerView!
    
    var playStatus: VideoPlayerStatus?{
        didSet{
            switch self.playStatus{
            case .play:
                self.playerView.play()
                break
            case .pause:
                self.playerView.pause()
                break
            default:
                break
            }
        }
    }
    
    private var isCanBackgroundPlay: Bool = true //video background play possible/impossible
    private var playBtn: UIButton!
    
    var videoUrlStr: String?{
        didSet{
            guard let str = self.videoUrlStr else{
                return
            }
            
            self.playerView?.url = URL(string: str)
        }
    }
    private var playRate: Float = 0 //video play speed rate
    
    var playTargetTime: Double = 0{ //video target play time
        didSet{
            self.playerView.currentTime = self.playTargetTime
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBlue
        self.makeVideoView()
        self.setVideoClosure()
        
        self.videoUrlStr = "video url"
        
        //백그라운드 재생이 가능할 경우(isCanBackgroundPlay가 true) 표시할 재생 정보
        self.playerView.playingInfo = PlayingInfo(titleStr: "title", imgUrlStr: "image url")
        
        self.playStatus = .play
    }

    
    func makeVideoView(){
        let width = self.view.frame.size.width
        let height = width*0.7
        
        self.playerView = {
            let v = MHVideoPlayerView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: height)))
            v.backgroundColor = .white
            v.isCanBackgroundPlay = self.isCanBackgroundPlay
            return v
        }()
        self.view.addSubview(self.playerView)
        
        self.playBtn = {
            let btn = UIButton(frame: self.playerView.frame)
            btn.addTarget(self, action: #selector(playBtnCallback(sender: )), for: .touchUpInside)
            return btn
        }()
        self.view.addSubview(self.playBtn)
    }
    
    //MHVideoPlayerView closure use example
    func setVideoClosure(){
        self.playerView.setPlayerDurationClosure { playerView, duration in
            print("video duration \(duration)")
        }
        self.playerView.setPlayerLoadStartClosure { playerView in
            print("load start")
        }
        self.playerView.setPlayerFinishedClosure { playerView in
            print("finish video")
        }
    }
    
    @objc func playBtnCallback(sender: UIButton){
        switch self.playStatus{
        case .play:
            self.playStatus = .pause
            break
        case .pause:
            self.playStatus = .play
            break
        default:
            break
        }
    }
}

