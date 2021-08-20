//
//  CalendarViewController.swift
//  Calendar
//
//  Created by Yasemin YEL on 19.08.2021.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{

  var calendar = FSCalendar()
  var formatter = DateFormatter()
  
  private let dateLabel : UILabel = {
    let label = UILabel()
    label.backgroundColor = #colorLiteral(red: 0.568627451, green: 0.3294117647, blue: 0.6509803922, alpha: 0.85)
    label.widthAnchor.constraint(equalToConstant: 200).isActive = true
    label.heightAnchor.constraint(equalToConstant: 60).isActive = true
    label.text  = "Hi World"
    label.textAlignment = .center
    label.textColor = .black
    label.font = UIFont(name: "Patrick Hand", size: 22.0)
    label.isUserInteractionEnabled = true
    label.numberOfLines = 0
    return label
  }()
  private let okButton : UIButton = {
    let button = UIButton()
    button.backgroundColor = .blue
    button.titleLabel?.text = "OK"
    return button
  }()
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.view.addSubview(dateLabel)
      self.view.addSubview(okButton)
      
      dateLabel.frame = CGRect(x: 10, y: view.width+50, width: view.width-20, height: 150)
      okButton.frame = CGRect(x: 10, y: dateLabel.bottom, width: view.width-20, height: 50)
    
      
      calendar = FSCalendar(frame: CGRect(x: 0.0, y: 40.0, width: view.width, height: view.width))
      calendar.scrollDirection = .horizontal
      calendar.scope = .month
      calendar.locale = .current
      self.view.addSubview(calendar)
      calendar.delegate = self
      calendar.dataSource = self
      
      //change font and color
      calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17.0)
      calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 18.0)
      calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 16.0)
      
      calendar.appearance.todayColor = .systemGreen
      calendar.appearance.titleTodayColor = .white
      calendar.appearance.titleDefaultColor = .systemBlue
      calendar.appearance.headerTitleColor = .systemRed
      calendar.appearance.weekdayTextColor = .systemRed
      
      //select multiple dates
      calendar.allowsMultipleSelection = true
    }
    
// MARK:- Dtasource
  
  //select date from range of available dates
  func minimumDate(for calendar: FSCalendar) -> Date {
    return Date()
  }
  func maximumDate(for calendar: FSCalendar) -> Date {
    return Date().addingTimeInterval((24*60*60)*60)
  }
  //showing events as a dot
  func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
    formatter.dateFormat = "dd-MM-yyyy"
    guard let eventDate = formatter.date(from: "24-08-2021") else {return 0}
    if date.compare(eventDate) == .orderedSame {
      return 2
    }
    return 0
  }
//MARK:- Delegate
  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    formatter.dateFormat = "dd-MM-yyyy"
    print(formatter.string(from: date))
    dateLabel.text = formatter.string(from: date)
  }
  // multiple select
  func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
    formatter.dateFormat = "dd-MM-yyyy"
    print(formatter.string(from: date))
    //dateLabel.text = formatter.string(from: date)
  }
  //making a particular date unselectable
  func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
    formatter.dateFormat = "dd-MM-yyyy"
    guard let excludedDate = formatter.date(from: "23-08-2021") else {return true}
    if date.compare(excludedDate) == .orderedSame {
      return false
    }
    return true
  }
  func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
    formatter.dateFormat = "dd-MM-yyyy"
    guard let excludedDate = formatter.date(from: "23-08-2021") else {return nil}
    if date.compare(excludedDate) == .orderedSame {
      return .red
    }
    return nil
  }
}
