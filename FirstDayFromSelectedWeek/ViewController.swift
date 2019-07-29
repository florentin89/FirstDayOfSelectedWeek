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
    ///Get the number of weeks for current year.
    var numberOfWeeksInYear: Int {
        let calendar = Calendar(identifier: .iso8601)
        
        // Test a different year
        //                let formatter = DateFormatter()
        //                formatter.dateFormat = "yyyy/MM/dd HH:mm"
        //                let customDate = formatter.date(from: "2022/01/01 00:00")
        //
        let weekRange = calendar.range(of: .weekOfYear,
                                       in: .yearForWeekOfYear,
                                       for: Date()) // for: customDate)
        return weekRange!.count
    }
    var weeksArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weeksArray = (1...numberOfWeeksInYear).map { "\($0)" }
        
        print("Number of weeks in current year: \(numberOfWeeksInYear)")
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
        
        print("\n1st monday of week \(Int(weeksArray[row]) ?? 0) is: \(mondayOfSelectedWeek ?? Date())")
        
        firstMondayLabel.text = "\(mondayOfSelectedWeek!)"
    }
}

extension Date {
    
    func dateCorrespondingTo(weekNumber: Int) -> Date? {
        let thisCalendar = Calendar(identifier: .iso8601)
        let year = thisCalendar.component(.year, from: self)
        let dateComponents = DateComponents(calendar: thisCalendar, timeZone: TimeZone(abbreviation: "UTC"), hour: 0, minute: 0, second: 0, nanosecond: 0, weekday: 2, weekOfYear: weekNumber, yearForWeekOfYear: year) // change the year with 2022 to test a different date
        return thisCalendar.date(from: dateComponents)
    }
}
