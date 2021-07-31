//
//  FromTmcPromotionCell.swift
//  MECA
//
//  Created by Macbook  on 06/07/21.
//

import UIKit
import SDWebImage
import AVKit
//import AVFAudio
import AVFoundation
import MediaPlayer
class FromTmcPromotionCell: UITableViewCell,SDWebImageManagerDelegate {
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var lbltitlepromotion: UILabel!
    @IBOutlet weak var lblpromotion_Description: UILabel!
    @IBOutlet weak var imgpromotiontmc: UIImageView!
    let smallVideoPlayerViewController = AVPlayerViewController()

    
    //versaplayer
    @IBOutlet weak var playerView: VersaPlayerView!
    @IBOutlet weak var controls: VersaPlayerControls!
        @IBOutlet weak var videoView: UIView!
    var viewcontrollerTMC = UIViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        playerView.layer.backgroundColor = UIColor.black.cgColor
        playerView.use(controls: controls)
        playerView.controls?.behaviour.shouldAutohide = true
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "FromTmcPromotionCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellpromotion(objFeed:Promotion)  {
        
        lbltitlepromotion.text = objFeed.title!
        
        lblpromotion_Description.text = objFeed.content!
        
        print("lloosdo ...\(objFeed.title)")
        if lblpromotion_Description.text!.count >= 100 {
            btnSeeMoreOutlet.isHidden = false
        }else{
            btnSeeMoreOutlet.isHidden = true
        }
        let videoURL = NSURL(string: objFeed.video_link!)
        let item = VersaPlayerItem(url: videoURL! as URL)
        playerView.set(item: item)
//                let player = AVPlayer(url: videoURL! as URL)
//                let playerViewController = AVPlayerViewController()
//        smallVideoPlayerViewController.showsPlaybackControls = false
//               smallVideoPlayerViewController.player = player
//
//               videoView.addSubview(smallVideoPlayerViewController.view)
//
//        smallVideoPlayerViewController.view.frame = videoView.bounds
//        smallVideoPlayerViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//               smallVideoPlayerViewController.player?.play()
        
    }
    
    
}
