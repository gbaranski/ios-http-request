//
//  ViewController.swift
//  http-sender
//
//  Created by Grzegorz Baranski on 16/03/2020.
//  Copyright © 2020 gbaranski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func startTimerButton(_ sender: Any) {
        startTimer()
    }
    @IBAction func getRemainingTime(_ sender: Any) {
        getRemainingTime()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getData(urlstring:String, completionHandler: @escaping (String) -> ()) {
        let url = URL(string: urlstring)
        let request = URLRequest(url: url!)
        var respondData: String = "noerror"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with:request) { (data, response, error) -> Void in
            if error == nil {
                let json = String(data: data!, encoding: .utf8)!
                respondData = json
                completionHandler(respondData)
            }
        }
        task.resume()
    }

    func startTimer() {
        self.getData(urlstring: "http://192.168.1.10:5000/startTimer") { (respondData) in
            print(respondData)
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Response from server", message: respondData, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    func getRemainingTime() {
        self.getData(urlstring: "http://192.168.1.10:5000/getRemainingTime") { (respondData) in
            print(respondData)
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Response from server", message: respondData, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }

}

