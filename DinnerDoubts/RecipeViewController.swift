//
//  RecipeViewController.swift
//  DinnerDoubts
//
//  Created by Tyler Brown on 12/14/19.
//  Copyright © 2019 Tyler Brown. All rights reserved.
//

import UIKit
import CoreData
class RecipeViewController: UIViewController {
    
    @IBOutlet weak var pickRestaurantButton: UIButton!
    @IBOutlet weak var addRecipeButton: UIButton!
    @IBOutlet weak var recipeNameBox: UITextField!
    @IBOutlet weak var prepTimeBox: UITextField!
    var fetchResult:[Recipe] = []
    @IBOutlet weak var recipeIngredientsBox: UITextView!
    @IBOutlet weak var recipeInstructionsBox: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        addRecipeButton.applyDesign()
        pickRestaurantButton.applyDesign()
        recipeIngredientsBox.layer.borderColor = UIColor.lightGray.cgColor
        recipeIngredientsBox.layer.borderWidth = 1.0
        
        recipeInstructionsBox.layer.borderColor = UIColor.lightGray.cgColor
        recipeInstructionsBox.layer.borderWidth = 1.0
        let context = DatabaseController.persistentStoreContainer().viewContext
       let fetchRequest:NSFetchRequest = Recipe.fetchRequest()
             do{
              fetchResult = try context.fetch(fetchRequest)
             }catch {
                 print(error)
             }
        // Do any additional setup after loading the view.
    }
   
    @IBAction func addRecipeButton(_ sender: Any) {
        let addRecipeViewController = storyboard?.instantiateViewController(identifier: String(describing: AddRecipeViewController.self)) as! AddRecipeViewController
        
        self.navigationController?.pushViewController(addRecipeViewController, animated: true)
    }
    
    @IBAction func selectRandomRecipe(_ sender: Any) {
        if (fetchResult.count == 0) {
        self.recipeNameBox.text = "No Recipes Found, add one by clicking top right button!"
        }else {
            let randomIndex = Int(arc4random_uniform(UInt32(fetchResult.count)))
            self.recipeNameBox.text = fetchResult[randomIndex].recipeName
            
            self.recipeIngredientsBox.text = fetchResult[randomIndex].recipeIngredients
            
            self.recipeInstructionsBox.text = fetchResult[randomIndex].recipeInstructions
            
            self.prepTimeBox.text = String(fetchResult[randomIndex].recipeCookTime)
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
