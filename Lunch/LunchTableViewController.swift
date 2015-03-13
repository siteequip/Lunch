//
//  LunchTableViewController.swift
//  Lunch
//
//  Created by Site Equip on 09/03/2015.
//  Copyright (c) 2015 Site Equip. All rights reserved.
//

import UIKit

//Becoming a delegate Step 1:
//Declare yourself as the delegate by adding AddItemViewControllerDelegate to the class declartion
//Step 2

class LunchTableViewController: UITableViewController, AddItemViewControllerDelegate  {
    
    
    //This creates an empty array that will hold only Item objects
    var items = [Item]()

    //This function is called when our view is loaded. Do setup like setting the title in here.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.title = "Lunch"
        
        //Here we are creating a new item, 
        //first line assigns a new item object to a contant called item1
        let item1 = Item()
        //second two lines assign values to this objects name and quanity properties
        item1.name = "Tomatoes"
        item1.quanity = "800g"
        item1.iconName = "FruitVeg"
        //The third uses += to add our item1 to the items array. (Can add self. infront if not sure)
        self.items += [item1]
        
        let item2 = Item()
        item2.name = "Seabass"
        item2.quanity = "4 fillets"
        item2.iconName = "Fish"
        self.items += [item2]
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    //This function allows us to tell the table view how any rows of data we want to display
    // the extra parameter name inside this function is actually the second parameter external parameter name. This will be used when the function is called.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        //Instead of returing a static value eg 1, 2 or 3. We want to return the amount of item objects currently inside our array "items"
        //to do this we use the .count method
        return items.count
    }


    //This function allows us to tell the table view how to display each row of data. Here we add in our prototype cell so the table view knows how to display its data.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Step 1,
        //This line declares our resuable cell. We addin "ItemCell" where it said "reuseIdenfier" so we can tell the tableview to create this kind of cell for each row of data.
        //add in reuse identifier
        //This function is run everytime a new row of data needs a cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        //Step 2, this line accesses the item at a specified number inside our array
        //We use the indexPath to point to the correct row of data
        let item = self.items[indexPath.row]
        println(indexPath.row)
        
        //Step 3, set our text labels
        //First access our cell property textLabel
        //We use the ! to unwrap this optional value so we can set its properties
        //Note only use the ! when you definately know there is a value
        //We then access the text property
        //Finally assign it to the name of the current item
        cell.textLabel!.text = item.name
        cell.detailTextLabel!.text = item.quanity
        
        //Here we want to display our ico inside of our cell
        //Our cell comes with an imageView property
        //We can set this by accessing imageView's image property
        //To set this property we must use a UIImage object
        //As item.iconName is a string, we need to convert it
        //To do this we use UIImage method that allows us to set an image by it's filename.
        cell.imageView!.image = UIImage(named: item.iconName)
        
        
        return cell
    }

    // MARK: - Protocol Methods
    
    //Step 2: Conform to the protocol set in LunchAddItemViewController
    //To do this we need to fill out both protocol methods
    
    //Aim is to add our item passed by LunchAddItemViewController to our table view
    func addItemViewControllerDidSave(controller: LunchAddItemViewController, item: Item) {

        //We want to use the insertRowsAtIndexPath method
        
        //This is what we need to create:
        //An array of NSIIndexPath objects, repensing a row in our table view
        
        //First get the row index
        //This counts how many items are in our array currently. 
        //At the moment we have 2 items in our array, so this is the number that will be returned
        //This actually will correspond to the third row in our table, as our table counts from 0, 1 , 2
        let rowIndex = items.count
        //Create a new index path combining our row and section number. If you have one section, the section number will be 0 as we count from 0.
        let indexPath = NSIndexPath(forRow: rowIndex, inSection: 0)
        
        //Add our indexPath into an array
        let indexPathArray = [indexPath]
        
        //Add our new item to our items array.
        //We do this after the index path to ensure our row index points to the correct place
        self.items += [item]
        
        //Now add our insertRowAtIndexPath method
        
        tableView.insertRowsAtIndexPaths(indexPathArray, withRowAnimation: .Automatic)
        
        //Dismiss our view controller
        dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }
    //Aim is to dismiss the LunchAddItemViewController
    func addItemViewControllerDidCancel(controller: LunchAddItemViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //Step 3: tell the other controller that we are it's delegate
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        
        
        //Only run this code if our segue is equal to "Add Item"
        if segue.identifier == "AddItem" {
            
            //Set the delegate property on our Add Item controller
            
            //First get a reference to our nagivation controller
            //We have to stell Xcode what kind of object is going to be at the end of our segue.
            //To do this we use 'as UINavigationController' to typecast the result
            let navigationController = segue.destinationViewController as UINavigationController
            
            //Second get a reference to our add item view controller
            
            //Here we use topViewController method to access whatever controller is on top of the navigation stack
            
            //The navigation stack containes views and other navigation controllers. They sit on top of one another. The hiearchy would be as follows:
            //AddItemViewController
            //Navigation Controller
            //LunchTableViewController
            //Navgation Controller
            
            
            //Xcode can't be sure of what object is sitting on top of the navigation stack, so again we have to use type casting to let it know - 'as LunchAddItemViewController' 
            
            let addItemController = navigationController.topViewController as  LunchAddItemViewController
            
            //Once we have a reference to the correct controller, we can access it's delete property and set it ourself.
            addItemController.delegate = self
            
            
        }
        
        
        
        
    }
    
    



    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            //When we delete items from a tableView we need to make sure that we delete it from our array too.
            
            //When the function is called, the cell that is in delete mode passes its indexPath to us. 
            //We then use removeAtIndec and pass it indexPath.row, to delete the correct item in our array.
            self.items.removeAtIndex(indexPath.row)
            
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    //Here we want to rearrange the order of our items in our item array, so that our order is preserved
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        //First get a reference to the item that is inside the row we want to move from
        let item = items[fromIndexPath.row]
        //next remove this item
        items.removeAtIndex(fromIndexPath.row)
        //Insert the item back into array at the correct position
        items.insert(item, atIndex: toIndexPath.row)
        println(item.name)

    }

    //This method allows us to rearrange our tableView cells, but does not change the order of our items in our item array.
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
