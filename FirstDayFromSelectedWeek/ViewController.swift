//
//  ViewController.swift
//  FirstDayFromSelectedWeek
//
//  Created by Florentin Lupascu on 26/07/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Interface Links
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var firstMondayLabel: UILabel!
    
    // Properties
    var weeksArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weeksArray = (1...53).map { "\($0)" }
    }
}

// Functionality for Next Trailer Inspection Cell
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weeksArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weeksArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let mondayOfSelectedWeek = Date().dateCorrespondingTo(weekNumber: Int(weeksArray[row]) ?? 0)
        
        print("1st monday of week \(Int(weeksArray[row]) ?? 0) is: \(mondayOfSelectedWeek!)")
    }
}

extension Date {
    
    func dateCorrespondingTo(weekNumber: Int) -> Date? {
        let thisCalendar = Calendar(identifier: .iso8601)
        return thisCalendar.date(bySetting: .weekOfYear, value: weekNumber, of: self)
    }
}
