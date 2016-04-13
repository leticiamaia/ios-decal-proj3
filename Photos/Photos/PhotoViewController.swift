//
//  PhotoViewController.swift
//  Photos
//
//  Created by Leticia Maia on 4/9/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photo: Photo?
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var bigHeartImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photo = photo {

            likesLabel.text = String(photo.likes) + " Likes"
            userNameLabel.text = "By: " + photo.username
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            formatter.timeStyle = .ShortStyle
            let datePostedString = formatter.stringFromDate(photo.datePosted)
            timeLabel.text = datePostedString
            
            if let cachedImage = Utils.cache.objectForKey(photo.url) as? UIImage {
                imageView.image = cachedImage
            } else {
                let url = NSURL(string: photo.url)
                let data = NSData(contentsOfURL : url!)
                let image = UIImage(data: data!)
                imageView.image = image
                Utils.cache.setObject(image!, forKey: url!)
            }
            
            likeButton.setImage(UIImage(named: "heart-white.png"), forState: UIControlState.Selected)
            if(photo.liked!) {
                likeButton.setImage(UIImage(named: "filled-heart.png"), forState: UIControlState.Normal)
            } else {
                likeButton.setImage(UIImage(named: "heart-white.png"), forState: UIControlState.Normal)
            }

        }
    }
    
    @IBAction func like(sender: UIButton) {
        if let photo = photo {
            if(photo.liked!) {
                photo.liked! = false
                photo.likes! -= 1
                likeButton.setImage(UIImage(named: "heart-white.png"), forState: UIControlState.Normal)
                
            } else {
                photo.liked! = true
                photo.likes! += 1
                likeButton.setImage(UIImage(named: "filled-heart.png"), forState: UIControlState.Normal)
                view.bringSubviewToFront(bigHeartImage)
                UIView.animateWithDuration(1.5, animations: {
                    self.bigHeartImage.alpha = 1.0
                })
                UIView.animateWithDuration(1.5, animations: {
                    self.bigHeartImage.alpha = 0.0
                })
            }
            likesLabel.text = String(photo.likes) + " Likes"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
