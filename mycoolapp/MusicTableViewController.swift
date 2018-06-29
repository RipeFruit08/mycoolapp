//
//  MusicTableViewController.swift
//  mycoolapp
//
//  Created by Stephen Kim on 6/21/18.
//  Copyright © 2018 Stephen Kim. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicTableViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    var qryAlbums: MPMediaQuery!
    override func viewDidLoad() {
        super.viewDidLoad()
//        var songsArray:[MPMediaItem] = [MPMediaItem]()
//        var mediaQuery = MPMediaQuery()
//        songsArray = MPMediaQuery.songs().items as! [MPMediaItem]
//
//        for songItem in songsArray{
//            print(songItem.albumArtist)
//            print(songItem.albumTitle)
//            print(songItem.title)
//            break
//        }
        // item - points to the songs?
        // collection - points to the albums names?
        // itemSection - points to the sections for each song?
        // collectionSection - points to the sections for the albums?
        // itemSection vs collectionSection not too sure? they only differ in the ranges
        qryAlbums = MPMediaQuery.albums()
        qryAlbums.groupingType = MPMediaGrouping.album

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let sectionIndexTitles = qryAlbums.itemSections!.map { (x) -> String in
            x.title
        }
        return sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return qryAlbums.itemSections![section].title
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return qryAlbums.collectionSections!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qryAlbums.collectionSections![section].range.length
    }
    


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediacell", for: indexPath)
        let currLoc = qryAlbums.collectionSections![indexPath.section].range.location
        //print(currLoc)
        let rowItem = qryAlbums.collections![indexPath.row + currLoc]
        //Main text is Album name
        cell.textLabel?.text = rowItem.items[0].albumTitle
        // Detail text is Album artist
        cell.detailTextLabel?.text = rowItem.items[0].albumArtist!
        // Configure the cell...

        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected this row!")
        let offset = indexPath.row
        let sectionIndex = qryAlbums.collectionSections![indexPath.section].range.location
        let album = qryAlbums.collections![sectionIndex + offset].items
        var songsAsString: String = ""
        for song in album{
            songsAsString += song.title! + " : \(song.playCount)" + "\n"
        }
        let alert = UIAlertController(title: "\(album[0].albumTitle!)", message: "\(songsAsString)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
