//
//  ViewController.swift
//  CustomLoginPage
//
//  Created by rd on 21/07/21.
//  Copyright © 2021 vishnu. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpElements()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //setup video in the background
        setUpVideo()

    }


    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
            }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    func setUpElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }
    
    func setUpVideo(){
        
        //get the path to the resource in the bundle
      let bundlePath = Bundle.main.path(forResource: "Video", ofType: "mp4")
        
        guard bundlePath != nil else {return}
        
        //create the url from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        
        //create the video player item
        let item = AVPlayerItem(url: url)
        
        //create the video player
        videoPlayer = AVPlayer(playerItem: item)
        
        //create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)

        //add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.2)
            }

}

