//
//  ItemTableViewCell.swift
//  ThrumpIt
//
//  Created by Satish Kumar R Kancherla on 12/2/17.
//  Copyright © 2017 Thrumpit. All rights reserved.
//

import UIKit
import SDWebImage
class ItemTableViewCell: UITableViewCell {
    
    let leftFollowButtonTag = 1001
    let rightFollowButtonTag = 2001
    
    @IBOutlet weak var clImageView: UIImageView!
    @IBOutlet weak var clTitleLabel: UILabel!
    @IBOutlet weak var clDescriptionLabel: UILabel!
    @IBOutlet weak var clLeftImageView: UIImageView!
    @IBOutlet weak var clLeftNameLabel: UILabel!
    @IBOutlet weak var clLeftFollowButton: UIButton!
    @IBOutlet weak var clRightImageView: UIImageView!
    @IBOutlet weak var clRightNameLabel: UILabel!
    @IBOutlet weak var clRightFollowButton: UIButton!
    var challenge: ChallengeModel?
    
    @IBOutlet weak var timeBtn: UIButton!
    @IBOutlet weak var viewersButton: UIButton!
    @IBOutlet weak var refImageView: UIImageView!
    @IBOutlet weak var clRightWinningImageView: UIImageView!
    @IBOutlet weak var clLeftWinningImageView: UIImageView!
    @IBAction func onTappingFollowButton(_ sender: UIButton) {
    }
    
    func loadChallenge(){
        if let challenge = self.challenge{
            self.clLeftWinningImageView.isHidden = true
            self.clRightWinningImageView.isHidden = true
            self.clTitleLabel.text = challenge.title ?? ""
            self.clDescriptionLabel.text = challenge.description ?? ""
            weak var weakself = self
            let clImgUrl = "https://thrumpit.com/getChallengeImage?challengeId=\(challenge.zingSessionId)"
            self.clImageView.sd_setImage(with: URL(string : clImgUrl), placeholderImage: #imageLiteral(resourceName: "placeholder"), options: [.refreshCached]) { (image, error, imageCacheType, imageUrl) in
                if image == nil{
                    weakself?.clImageView.image = #imageLiteral(resourceName: "placeholder")
                }
            }
            let clLUsrImgUrl = "https://thrumpit.com/getUserProfileImage?userId=\(challenge.challenger?.user?.userId ?? 0)"
            self.clLeftImageView.sd_setImage(with: URL(string : clLUsrImgUrl), placeholderImage: #imageLiteral(resourceName: "placeholder"), options: [.refreshCached]) { (image, error, imageCacheType, imageUrl) in
                if image == nil{
                    weakself?.clLeftImageView.image = #imageLiteral(resourceName: "placeholder")
                }
            }
            self.clLeftFollowButton.setTitle("\(challenge.challenger?.score ?? 0)", for: .normal)
            self.clLeftNameLabel.text = challenge.challenger?.user?.name ?? ""
            let clRUsrImgUrl = "https://thrumpit.com/getUserProfileImage?userId=\(challenge.opponent?.user?.userId ?? 0)"
            self.clRightImageView.sd_setImage(with: URL(string : clRUsrImgUrl), placeholderImage: #imageLiteral(resourceName: "placeholder"), options: [.refreshCached]) { (image, error, imageCacheType, imageUrl) in
                if image == nil{
                    weakself?.clRightImageView.image = #imageLiteral(resourceName: "placeholder")
                }
            }
            self.clRightNameLabel.text = challenge.opponent?.user?.name ?? ""
            self.clRightFollowButton.setTitle("\(challenge.opponent?.score ?? 0)", for: .normal)
            if challenge.challenger?.score ?? 0 > challenge.opponent?.score ?? 0{
                self.clLeftWinningImageView.isHidden = false
                self.clLeftWinningImageView.animationDuration = 1
                self.clLeftWinningImageView.animationImages = [#imageLiteral(resourceName: "cup"), #imageLiteral(resourceName: "white")]
                self.clLeftWinningImageView.startAnimating()
            }else if challenge.challenger?.score ?? 0 < challenge.opponent?.score ?? 0{
                self.clRightWinningImageView.isHidden = false
                self.clRightWinningImageView.animationDuration = 1
                self.clRightWinningImageView.animationImages = [#imageLiteral(resourceName: "cup"), #imageLiteral(resourceName: "white")]
                self.clRightWinningImageView.startAnimating()
            }
            if challenge.isActive == "Y"{
                self.refImageView.animationDuration = 0.5
                self.refImageView.animationImages = [#imageLiteral(resourceName: "ref1"), #imageLiteral(resourceName: "ref2"), #imageLiteral(resourceName: "ref3"), #imageLiteral(resourceName: "ref4")]
                self.refImageView.startAnimating()
            }
            self.viewersButton.setTitle("\(challenge.viewersCount)", for: .normal)
            self.viewersButton.isHidden = challenge.viewersCount == 0
            self.timeBtn.setTitle("  \(DateUtil.timeAgoSinceDate(utimeStamp: challenge.startDate ?? 0.0, numericDates: false))", for: .normal)
        }
    }
    
}
