//
//  UIViewController.swift
//  BasicLoginPage
//
//  Created by Vansh Maheshwari on 20/01/22.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var player:AVPlayer?
    
    var playerLayer:AVPlayerLayer?
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVid()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signupButton)
        Utilities.styleHollowButton(loginButton)
    }

    func setUpVid() {
        
        let bPath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        guard bPath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bPath!)
        
        
        let item = AVPlayerItem(url: url)
        
        player = AVPlayer(playerItem: item)
        
        playerLayer = AVPlayerLayer(player: player!)
        
        playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(playerLayer!, at: 0)
        
        player?.playImmediately(atRate: 1)
        
    }
    
    
}
