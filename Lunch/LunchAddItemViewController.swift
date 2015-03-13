//
//  LunchAddItemViewController.swift
//  Lunch
//
//  Created by Site Equip on 10/03/2015.
//  Copyright (c) 2015 Site Equip. All rights reserved.
//


import UIKit

//Aim is to connect up our save button, to allow us to pass information back to our list table.

//Step 1: Add in our protocol class for our delegate with empty methods
protocol AddItemViewControllerDelegate : class {
    //This method allows us to send our Item back to our list table view controller
    func addItemViewControllerDidSave(controller: LunchAddItemViewController, item: Item)
    //This method will allow us to dismiss our current view controller
    func addItemViewControllerDidCancel(controller: LunchAddItemViewController)
}


class LunchAddItemViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var quanityTextField: UITextField!
    
    @IBOutlet weak var saveButtonPressed: UIBarButtonItem!
    
    @IBOutlet weak var segmentButtonPressed: UISegmentedControl!
    
    //Step 2: add an empty property that will be filled with our delegate
    
    //Add in a delegate variable with an instance of our delegate, so we can access its methods inside of our class.
    weak var delegate : AddItemViewControllerDelegate?
    //We add in a property called iconPressed so we can set the value of our segmented control to it.
    //We can then assign it to our iconName property inside our save function
    var iconPressed = "Other"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Add Item"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //Step 3: Add in our save button functionality - create a new Item object.
    @IBAction func saveButton(sender: UIBarButtonItem) {
        let item = Item()
        item.name = nameTextField.text
        item.quanity = quanityTextField.text
        item.iconName = iconPressed
        println(item.iconName)
        //When our save button is clicked, this sends the delegate method addItemViewControlDidSave back to our list table view controller, which then does something with our new item
        delegate?.addItemViewControllerDidSave(self, item: item)
        
        
    }
    
    //Step 4: Add in our cancel button functionality
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        //When the cancel button is pressed, the addItemViewControllerDidCancel method is called on our list table view controller.
        //We use self, as we are the controller sending the message
        delegate?.addItemViewControllerDidCancel(self)
        
    }
    
    @IBAction func segmentSelected(sender: UISegmentedControl) {
        /*
        
        A switch statement considers a value and compares it against several posible matching values.
        
        switch someValueToConsider {
        case value1:
        respond to value1
        case value2:
        respond to value2
        case value3:
        respond to value3
        default
        responds to all other possibilities
        
        }
        
        Switch statements must be exhuastive, which means you must provide a response for every possible outcome. If thats not appropriate, use a default which appears last
        */
        
        switch segmentButtonPressed.selectedSegmentIndex {
            
        case 0:
            iconPressed = "FruitVeg"
            println(iconPressed)
            
        case 1:
            iconPressed = "Meat"
            println(iconPressed)
            
        case 2:
            iconPressed = "Fish"
            println(iconPressed)
            
        default:
            iconPressed = "Other"
            println(iconPressed)
            
        }
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