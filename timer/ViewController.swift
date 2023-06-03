//
//  ViewController.swift
//  navigation_bar
//
//  Created by Jakub Sukiennim on 03/06/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var lb: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var timer = Timer()
    var time: Double = 0
    var data: [Double] = []
    
    @objc func timerResult() {
        time += 0.01 // Zwiększamy o 0.01 dla częstotliwości timera co 0.01 sekundy
        lb.text = formatTime(time)
    }

    @IBAction func pauza(_ sender: Any) {
        timer.invalidate()
    }
   
    @IBAction func koniec(_ sender: Any) {
        timer.invalidate()
        time = 0
        lb.text = formatTime(time)
        data.removeAll()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let value = data[indexPath.row]
        cell.textLabel?.text = formatTime(value)
        return cell
    }
    
    @IBAction func pomiar(_ sender: Any) {
        let newValue = time
        data.append(newValue)
        let newIndexPath = IndexPath(row: data.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    @IBAction func start(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerResult), userInfo: nil, repeats: true) // Częstotliwość timera co 0.01 sekundy
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Formatowanie czasu
    func formatTime(_ time: Double) -> String {
        let minutes = Int(time / 60)
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((time * 1000).truncatingRemainder(dividingBy: 1000))
        let microseconds = Int((time * 1000000).truncatingRemainder(dividingBy: 1000))
        
        return String(format: "%02d:%02d:%03d:%03d", minutes, seconds, milliseconds, microseconds)
    }
}

