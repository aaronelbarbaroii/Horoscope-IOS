//
//  DetailViewController.swift
//  Horoscope-IOS
//
//  Created by Mananas on 7/11/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    var horoscope: Horoscope!

    @IBOutlet weak var imageDetail: UIImageView!
    
    @IBOutlet weak var predictionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = horoscope.name
        
        navigationItem.subtitle = horoscope.dates
        
        imageDetail.image = horoscope.getSignIcon()
        
        getPrediction(period: "daily")
        
    }
    
    @IBAction func didChangePeriod(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
            case 0: getPrediction(period: "daily")
            case 1: getPrediction(period: "weekly")
            default: getPrediction(period: "monthly")
        }
    }

    
    func getPrediction(period: String) {
            let url = URL(string: "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/\(period)?sign=\(horoscope.id)")
            
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url!)
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    let jsonData = jsonObject["data"] as! [String: String]
                    
                    let result = jsonData["horoscope_data"]!
                    
                    DispatchQueue.main.async {
                        self.predictionTextView.text = result
                    }
                } catch {
                    print(error)
                }
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
