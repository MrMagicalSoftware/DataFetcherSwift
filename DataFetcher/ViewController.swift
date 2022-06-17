//
//  ViewController.swift
//  DataFetcher
//
//  Created by mr on 17/06/22.
//  Copyright © 2022 mr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let url = "https://randomfox.ca/floof/?ref=apilist.fun";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getjson();
    }

    /*
    func callAPI(){
        guard let url = URL(string: "https://randomfox.ca/floof/?ref=apilist.fun") else{
            return
        }
        
        
        var myData : Fox
        
     
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8){
                print(string)
                
                let decodedData = try JSONDecoder().decode(Fox, from: data)
                
                
            }
            
            print("------>\(data!)")
            
            
            //let user: Fox = try decoder.decode(Fox.self, from: data)
            
        }
     
        task.resume()
    }
    */
    
    
    func getjson() {
        let urlPath = "https://randomfox.ca/floof/?ref=apilist.fun"
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            print("Task completed")
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            do {
                
                print("###############################################")
                
                let decodedData : Fox = try JSONDecoder().decode(Fox.self, from: data)
                print("IMAGE DATA \(decodedData.image)")
                print()
                print("###############################################")

                
                if let jsonResult = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    
                    //print(jsonResult)
                    // let decodedData : Fox = try JSONDecoder().decode(Fox.self, from: data)
                    //print(decodedData.image)
                    
                    
                    if let results = jsonResult["results"] as? [Any] {
                        DispatchQueue.main.async {
                            
                            
                           // self.tableData = results
                           // self.indexTableView.reloadData()
                        }
                    }
                }
                
                
            } catch let parseError {
                print("JSON Error \(parseError.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    

}







struct Fox:Codable{
    let image: String
    let link: String
}

