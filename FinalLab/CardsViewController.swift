//
//  CardsViewController.swift
//  FinalLab
//
//  Created by user910754 on 10/30/18.
//  Copyright © 2018 user910754. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    
    var cardInitialPosition: CGPoint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        cardInitialPosition = cardImageView.center
        
        print(cardImageView.center);
        // Do any additional setup after loading the view.
    }
    var height: CGFloat!
    @IBAction func didPan(_ sender: UIPanGestureRecognizer)
    {
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        var rotation: CGFloat!
        if sender.state == .began
        {
            cardImageView.center = cardInitialPosition
            height = location.y
        } else if sender.state == .changed
        {
            if height > cardInitialPosition.y
            {
                rotation = -translation.x / 900
            }
            else
            {
                rotation = translation.x / 900
            }
            UIView.animate(withDuration: 2, animations: {
                self.cardImageView.transform = self.cardImageView.transform.rotated(by: CGFloat(rotation))
                self.cardImageView.center = CGPoint(x: self.cardImageView.center.x + translation.x/2, y: self.cardImageView.center.y)
            })
        } else if sender.state == .ended
        {
            if translation.x < 50 && translation.x > -50
            {
                UIView.animate(withDuration: 2, animations: {
                    self.cardImageView.transform = CGAffineTransform.identity
                    self.cardImageView.center = self.cardInitialPosition
                })
            }
            else
            {
                if translation.x >= 50 {
                    UIView.animate(withDuration: 2, animations: {
                        self.cardImageView.center.x = self.cardInitialPosition.x + 550
                    }, completion: { finished in
                        self.cardImageView.transform = CGAffineTransform.identity
                        self.cardImageView.center = self.cardInitialPosition
                        
                    })
                }
                else
                {
                    UIView.animate(withDuration: 2, animations: {
                        self.cardImageView.center.x = self.cardInitialPosition.x - 550
                    }, completion: { finished in
                        self.cardImageView.transform = CGAffineTransform.identity
                        self.cardImageView.center = self.cardInitialPosition
                        
                    })
                    
                }
            }
            
        }
        
        
        
        
    }
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "theSegue", sender: nil)    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newViewController = segue.destination as! ProfileViewController
            newViewController.image = cardImageView.image
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
