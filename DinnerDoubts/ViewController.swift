//
//  ViewController.swift
//  DinnerDoubts
//
//  Created by Tyler Brown on 12/14/19.
//  Copyright © 2019 Tyler Brown. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController {
    var currentLocation:CLLocation?
    @IBOutlet weak var restaurantButton: UIButton!
    @IBOutlet weak var recipeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLocation = LocationController.currentLocation
        view.backgroundColor = UIColor.lightGray
        titleLabel.font = UIFont(name: "Verdana", size: 34)
        titleLabel.shadowColor = UIColor.white
        titleLabel.shadowOffset = CGSize(width: 2, height: 1)
        // Do any additional setup after loading the view.
        restaurantButton.applyDesign()
        recipeButton.applyDesign()
        restaurantButton.layer.zPosition = 1
        recipeButton.layer.zPosition = 1
        
    }
    @IBAction func restaurantButton(_ sender: Any) {
        let restaurantViewController = storyboard?.instantiateViewController(identifier: String(describing: RestaurantViewController.self)) as! RestaurantViewController
        self.navigationController?.pushViewController(restaurantViewController, animated: true)
    }
    @IBAction func recipeButton(_ sender: Any) {
       let recipeViewController = storyboard?.instantiateViewController(identifier: String(describing: RecipeViewController.self)) as! RecipeViewController
        self.navigationController?.pushViewController(recipeViewController, animated: true)
    }
    
}
extension UIButton {
    func applyDesign() {
        self.backgroundColor = UIColor.darkGray
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
    @objc
       func locationDidUpdate(notification:Notification){
           _ = LocationController.currentLocation
          }
}



