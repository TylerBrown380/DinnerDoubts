//
//  RestaurantViewController.swift
//  DinnerDoubts
//
//  Created by Tyler Brown on 12/14/19.
//  Copyright © 2019 Tyler Brown. All rights reserved.
//

import UIKit
import CoreData
import MapKit
class RestaurantViewController: UIViewController {
    
    @IBOutlet weak var addRestaurantsToCoreDataButton: UIButton!
    @IBOutlet weak var restaurantPicker: UIButton!
    @IBOutlet weak var restaurantLabel: UILabel!

    var cl = ViewController()
    lazy var currentLocation = cl.currentLocation
    
    @IBOutlet weak var mapView: MKMapView!
    var fetchResult:[Restaurant] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantLabel.layer.zPosition = 1
        restaurantPicker.layer.zPosition = 1
        addRestaurantsToCoreDataButton.applyDesign()
        restaurantPicker.applyDesign()
        currentLocation = LocationController.currentLocation
       
        NotificationCenter.default.addObserver(self, selector: #selector(locationDidUpdate(notification:)), name: NSNotification.Name(rawValue: LocationController.NOTIFICATION_LOCATION_DID_UPDATE), object: nil)
       
        let context = DatabaseController.persistentStoreContainer().viewContext
     
        // Do any additional setup after loading the view.
        
        let fetchRequest:NSFetchRequest = Restaurant.fetchRequest()
        do{
         fetchResult = try context.fetch(fetchRequest)
        }catch {
            print(error)
        }
    }
        @objc
        func locationDidUpdate(notification:Notification){
            _ = LocationController.currentLocation
            zoomToLocationOnMap()
           }
    func zoomToLocationOnMap() {
        if let locationToZoomInOn = currentLocation?.coordinate {
            mapView.setRegion(MKCoordinateRegion(center: locationToZoomInOn, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        }
    }
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        LocationController.startMonitoryingLocation()
        self.zoomToLocationOnMap()
        
    }
    
    @IBAction func addRestuarantsToCoreData(_ sender: Any) {
        let context = DatabaseController.persistentStoreContainer().viewContext
        var newRestaurant = Restaurant(context: context)
            newRestaurant.restaurantName = "PF Changs"
            newRestaurant.restaurantTheme = "Chinese"
            newRestaurant.restaurantLocation = RestaurantLocation(context: context )
            newRestaurant.restaurantLocation?.longitude = -116.205714
            newRestaurant.restaurantLocation?.latitude = 43.613609
            DatabaseController.saveContext()
        //adds Five Guys
         newRestaurant = Restaurant(context: context)
             newRestaurant.restaurantName = "Five Guys Burgers and Fries"
             newRestaurant.restaurantTheme = "American"
             newRestaurant.restaurantLocation = RestaurantLocation(context: context )
             newRestaurant.restaurantLocation?.longitude = -116.2852
             newRestaurant.restaurantLocation?.latitude = 43.6192
             DatabaseController.saveContext()
        //adds chicFila
         newRestaurant = Restaurant(context: context)
             newRestaurant.restaurantName = "Chic Fil-A"
             newRestaurant.restaurantTheme = "Chinese"
             newRestaurant.restaurantLocation = RestaurantLocation(context: context )
             newRestaurant.restaurantLocation?.longitude = -116.193019
             newRestaurant.restaurantLocation?.latitude = 43.608236
             DatabaseController.saveContext()
        //adds Five Guys
         newRestaurant = Restaurant(context: context)
             newRestaurant.restaurantName = "Five Guys Burgers and Fries"
             newRestaurant.restaurantTheme = "American"
             newRestaurant.restaurantLocation = RestaurantLocation(context: context )
             newRestaurant.restaurantLocation?.longitude = -116.2852
             newRestaurant.restaurantLocation?.latitude = 43.6192
             DatabaseController.saveContext()
        //adds Boise Fry Company
         newRestaurant = Restaurant(context: context)
             newRestaurant.restaurantName = "Boise Fry Company"
             newRestaurant.restaurantTheme = "American"
             newRestaurant.restaurantLocation = RestaurantLocation(context: context )
             newRestaurant.restaurantLocation?.longitude = -116.193397522
             newRestaurant.restaurantLocation?.latitude = 43.607681274
             DatabaseController.saveContext()
        //updates fetch request for generate restaurants button
        let fetchRequest:NSFetchRequest = Restaurant.fetchRequest()
              do{
               fetchResult = try context.fetch(fetchRequest)
              }catch {
                  print(error)
              }
    }
    
    @IBAction func restaurantPicker(_ sender: Any) {
        if(fetchResult.count == 0) {
            self.restaurantLabel.text = "Nothing in core data"
        }else {
            let randomIndex = Int(arc4random_uniform(UInt32(fetchResult.count)))
            self.restaurantLabel.text = fetchResult[randomIndex].restaurantName
            let target = CLLocationCoordinate2D(latitude: fetchResult[randomIndex].restaurantLocation!.latitude, longitude: fetchResult[randomIndex].restaurantLocation!.longitude
            )
            let annotation = MKPointAnnotation()
            annotation.coordinate = target
            mapView.addAnnotation(annotation)
            mapView.setCenter(target, animated: true)
        }
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
