//
//  ViewController.swift
//  Calendar
//
//  Created by Yasemin YEL on 19.08.2021.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {

  @IBOutlet weak var navigationBar: UINavigationBar!
  @IBOutlet weak var exitButton: UIBarButtonItem!
  @IBOutlet weak var readButton: UIBarButtonItem!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  //Image View
  private let moodİmageView : UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = UIColor.clear
    imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    imageView.image = UIImage(imageLiteralResourceName: "mood_firstset_8")
    return imageView
  }()
  private let dateimageView : UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = UIColor.clear
    imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    imageView.image = UIImage(systemName: "calendar")
    imageView.tintColor = .black
    
    return imageView
  }()
  private let timeimageView : UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = UIColor.clear
    imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    imageView.image = UIImage(systemName: "clock")
    imageView.tintColor = .black
    return imageView
  }()
  
  
  //Text Label
  private let dateText : UITextView = {
    let textView = UITextView()
    textView.backgroundColor = #colorLiteral(red: 0.568627451, green: 0.3294117647, blue: 0.6509803922, alpha: 0.85)
    textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    textView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    textView.text  = "Hi World"
    textView.textAlignment = .center
    textView.textColor = .black
    textView.font = UIFont(name: "Patrick Hand", size: 22.0)
   
    return textView
  }()
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
    return label
  }()
  
  private let timeText : UITextField = {
    let textField = UITextField()
    textField.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.8901960784, blue: 0.862745098, alpha: 1)
    textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
    textField.heightAnchor.constraint(equalToConstant: 80).isActive = true
    textField.text  = "Hi World"
    textField.textAlignment = .center
    textField.textColor = .black
    textField.font = UIFont(name: "Patrick Hand", size: 18)
    return textField
  }()
  
  private let spaceLabel : UILabel = {
    let label = UILabel()
    label.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.8901960784, blue: 0.862745098, alpha: 1)
    label.widthAnchor.constraint(equalToConstant: 200).isActive = true
    label.heightAnchor.constraint(equalToConstant: 50).isActive = true
    label.text  = ""
    label.textAlignment = .center
    label.textColor = .black
    label.numberOfLines = 0
    return label
  }()
  
  
  private let datePicker : UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .dateAndTime
    datePicker.locale = .current
    datePicker.date = Date()
    return datePicker
  }()
  
  
  //Stack View
  private let stackView : UIStackView = {
    let stackView   = UIStackView()
    stackView.axis  = NSLayoutConstraint.Axis.horizontal
    stackView.distribution  = UIStackView.Distribution.equalSpacing
    stackView.alignment = UIStackView.Alignment.center
    stackView.spacing   = 5
    return stackView
  }()
  
  var calendar : FSCalendar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationBar.tintColor = .black
 
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .full
    dateFormatter.timeStyle = .short
    dateFormatter.locale = .current
    dateFormatter.dateFormat = "dd MMM yyyy EEEE"
    
    let timeFormatter = DateFormatter()
    timeFormatter.dateStyle = .full
    timeFormatter.timeStyle = .short
    timeFormatter.locale = .current
    timeFormatter.dateFormat = "HH:mm"
    
    dateText.text = dateFormatter.string(from: datePicker.date)
    timeText.text = timeFormatter.string(from: datePicker.date)
    
    
    
    stackView.addArrangedSubview(dateText)
    stackView.addArrangedSubview(dateimageView)
    stackView.addArrangedSubview(timeText)
    stackView.addArrangedSubview(timeimageView)
    stackView.addArrangedSubview(spaceLabel)
    stackView.addArrangedSubview(moodİmageView)
    
    //toolbar
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    
    // bar button
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelPressed))
    
    toolBar.setItems([doneButton,cancelButton], animated: true)
    
    // assign toolbar
    dateText.inputAccessoryView = toolBar
    timeText.inputAccessoryView = toolBar
    
    
    
    // assign date picker to tha text field
    dateText.inputView = datePicker
    timeText.inputView = datePicker
    //datepicker mode
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.datePickerMode = .date

    self.view.addSubview(stackView)
    
    //Constraints
    
    stackView.frame = CGRect(x: 10, y: navigationBar.bottom, width: view.width-20, height: 70)
  
  }
  @objc func donePressed() {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .full
    dateFormatter.timeStyle = .short
    dateFormatter.locale = .current
    dateFormatter.dateFormat = "dd MMM yyyy EEEE"
    
    let timeFormatter = DateFormatter()
    timeFormatter.dateStyle = .full
    timeFormatter.timeStyle = .short
    timeFormatter.locale = .current
    timeFormatter.dateFormat = "HH:mm"
    
    dateText.text = dateFormatter.string(from: datePicker.date)
    timeText.text = timeFormatter.string(from: datePicker.date)
    self.view.endEditing(true)
    view.frame.origin.y = 0
  }
  @objc func cancelPressed() {
    self.view.endEditing(true)
    view.frame.origin.y = 0
  }
  
  
}
