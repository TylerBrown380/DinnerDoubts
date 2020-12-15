//
//  AddRecipeViewController.swift
//  DinnerDoubts
//
//  Created by Tyler Brown on 12/15/19.
//  Copyright © 2019 Tyler Brown. All rights reserved.
//

import UIKit
import CoreData
class AddRecipeViewController: UIViewController {
    @IBOutlet weak var addIngredientsBox: UITextView!
    @IBOutlet weak var addInstructionsBox: UITextView!
    @IBOutlet weak var prepTimeBox: UITextField!
    @IBOutlet weak var recipeNameBox: UITextField!
    @IBOutlet weak var saveRecipeButton: UIButton!
    var fetchResult:[Recipe] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        addIngredientsBox.layer.borderColor = UIColor.lightGray.cgColor
        addIngredientsBox.layer.borderWidth = 1.0
        addInstructionsBox.layer.borderColor = UIColor.lightGray.cgColor
        addInstructionsBox.layer.borderWidth = 1.0
        let context = DatabaseController.persistentStoreContainer().viewContext
        let fetchRequest:NSFetchRequest = Recipe.fetchRequest()
        do{
            fetchResult = try context.fetch(fetchRequest)
        }catch {
            print(error)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveRecipeButton(_ sender: Any) {
          let context = DatabaseController.persistentStoreContainer().viewContext
        let newRecipe = Recipe(context: context)
        if (recipeNameBox.text == nil) {
        recipeNameBox.insertText("Nothing Entered")
        }
        newRecipe.recipeName = recipeNameBox.text
        
        let prepString = prepTimeBox.text ?? "Nothing"
        let cookInt = Int(prepString) ?? 0
        newRecipe.recipeCookTime = Int32(cookInt)
        
        let ingredientString = addIngredientsBox.text ?? "Nothing Entered"
        newRecipe.recipeIngredients = ingredientString
        
        let instructionString = addInstructionsBox.text ?? "Nothing Entered"
        newRecipe.recipeInstructions = instructionString
        DatabaseController.saveContext()
        let recipeViewController = storyboard?.instantiateViewController(identifier: String(describing: RecipeViewController.self)) as! RecipeViewController
        self.navigationController?.pushViewController(recipeViewController, animated: true)
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
