//
//  ViewController.swift
//  Prework
//
//  Created by Ning on 6/30/21.
//

import UIKit
import Comets
import Gradients
import SnapKit
import SwiftTheme

class  Money{
     struct Variables {
        static var bill = 0.0
        static var tipPercentages = 0.0
        static var tip = 0.0
        static var total = 0.0
        static var person = 1.0
        static var perPersonMoney = 0.0
     }
 }

extension Money {
    class var bill: Double {
        get {
            return Variables.bill
        }
        set {
            Variables.bill = newValue
        }
    }
    class var tipPercentages: Double {
        get {
            return Variables.tipPercentages
        }
        set {
            Variables.tipPercentages = newValue
        }
    }
    class var tip: Double {
        get {
            return Variables.tip
        }
        set {
            Variables.tip = newValue
        }
    }
    class var total: Double {
        get {
            return Variables.total
        }
        set {
            Variables.total = newValue
        }
    }
    class var person: Double {
        get {
            return Variables.person
        }
        set {
            Variables.person = newValue
        }
    }
    class var perPersonMoney: Double {
        get {
            return Variables.perPersonMoney
        }
        set {
            Variables.perPersonMoney = newValue
        }
    }
 }

extension UITextField {
    
    func underlined(){
        let border = CALayer()
        let width = CGFloat(3.0)
        border.borderColor = UIColor.systemGray2.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    
}




class ViewController: UIViewController  {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var personAmount: UIStepper!
    
    @IBOutlet weak var personCount: UILabel!
    
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var perCent: UILabel!
    
    @IBOutlet weak var perPerson: UILabel!
    @IBOutlet weak var perPersonlabel: UILabel!
    
    //
    @IBOutlet weak var TipPercentageLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    
    @IBOutlet weak var total_Label: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    //
    
    let numberFormatter = NumberFormatter()
    var  currentSymbol = ""
    
    //inviewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        billAmountTextField.placeholder =  numberFormatter.string(from:NSNumber(value: 0))
        billAmountTextField.setValue(UIColor.systemGray, forKeyPath: "placeholderLabel.textColor")

     //   billAmountTextField.placeholder = NumberFormatter.localizedString(from: NSNumber(value: 0), number: .currency)
        tipAmountLabel.text = numberFormatter.string(from:NSNumber(value: Money.tip))
        totalLabel.text = numberFormatter.string(from:NSNumber(value: Money.total))
        
        var perPersonmoney = 0.0
        if perPersonlabel.text == "Per Person (Up)"{
             perPersonmoney = ceil(Money.perPersonMoney)
        }else if perPersonlabel.text == "Per Person (Down)" {
            perPersonmoney = floor(Money.perPersonMoney)
        }else {
            perPersonmoney = Money.perPersonMoney
        }
        perPerson.text = numberFormatter.string(from:NSNumber(value: perPersonmoney))
        
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    //inviewWillAppear
    
    //增加通知
            var myObserver:Bool? {
                didSet {
                    SnailNotice.add(observer: self, selector: #selector(reload1), notification: .perPersonUp)
                    SnailNotice.add(observer: self, selector: #selector(reload2), notification: .perPersonDown)
                    SnailNotice.add(observer: self, selector: #selector(reload3), notification: .perPersonDefault)
                    SnailNotice.add(observer: self, selector: #selector(reload4), notification: .currencyPick)
                }
            }
            
            //移除通知
            deinit {
                SnailNotice.remove(observer: self, notification: .perPersonUp)
                SnailNotice.remove(observer: self, notification: .perPersonDown)
                SnailNotice.remove(observer: self, notification: .perPersonDefault)
                SnailNotice.remove(observer: self, notification: .currencyPick)

            }

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("9999999.FIrsit:", Setting.colourDark )
        // Sets the title in the Navigation Bar
            self.title = "Tip Calculator"
        //123456789
        billAmountTextField.text = UserDefaults.standard.string(forKey: "String")
        tipSlider.value = UserDefaults.standard.float(forKey: "Double1")
        
        let getTip = String(format: "%.2f", tipSlider.value)
        let tip = Double(getTip) ?? 0
        let percent = Int(tip * 100)
        perCent.text = String(format: "%d %%", Int(percent))
        //123456789
        
        DispatchQueue.main.async {
                self.billAmountTextField.becomeFirstResponder()
            }
        
        numberFormatter.numberStyle = .currency
        
        currentSymbol = numberFormatter.currencySymbol
        

         myObserver = true
        
        //
        view.theme_backgroundColor = GlobalPicker.backgroundColor
        
    //    updateTheme()
        TipPercentageLabel.theme_textColor = GlobalPicker.textColor
        perCent.theme_textColor = GlobalPicker.textColor
        billLabel.theme_textColor = GlobalPicker.textColor
            tipLabel.theme_textColor = GlobalPicker.textColor
        total_Label.theme_textColor = GlobalPicker.textColor
            peopleLabel.theme_textColor = GlobalPicker.textColor
            perPersonlabel.theme_textColor = GlobalPicker.textColor
            perPerson.theme_textColor = GlobalPicker.textColor
            personCount.theme_textColor = GlobalPicker.textColor
            totalLabel.theme_textColor = GlobalPicker.textColor
            tipAmountLabel.theme_textColor = GlobalPicker.textColor
            billAmountTextField.theme_textColor = GlobalPicker.textColor
       
            
        //
        
         
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                            for: .default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
        
        billAmountTextField.underlined()
        
        perPersonlabel.text = "Per Person"
        
        tipSlider.transform =  CGAffineTransform.init(scaleX: 1.0, y: 1.5)
        
        
        
       
       
        
        
        billAmountTextField.addTarget(self, action: #selector(billChange(sender1:)), for: UIControl.Event.editingChanged)
        
        personAmount.addTarget(self, action: #selector(personChange(sender2:)), for: UIControl.Event.valueChanged)
        
   
        tipSlider.isContinuous=true
        tipSlider.addTarget(self, action: #selector(tipChange(sender3:)), for: UIControl.Event.valueChanged)
        
        
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.black
            tooBar.items=[
                UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
                UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))]
            tooBar.sizeToFit()
        billAmountTextField.inputAccessoryView = tooBar
        
        
    //1111111111111
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        let comets = [Comet(startPoint: CGPoint(x: 100, y: 0),
                            endPoint: CGPoint(x: 0, y: 100),
                            lineColor: UIColor.red.withAlphaComponent(0.2),
                            cometColor: UIColor.red),
                      Comet(startPoint: CGPoint(x: 0.4 * width, y: 0),
                            endPoint: CGPoint(x: width, y: 0.8 * width),
                            lineColor: UIColor.red.withAlphaComponent(0.2),
                            cometColor: UIColor.red),
                      Comet(startPoint: CGPoint(x: 0.8 * width, y: 0),
                            endPoint: CGPoint(x: width, y: 0.2 * width),
                            lineColor: UIColor.red.withAlphaComponent(0.2),
                            cometColor: UIColor.red),
                      Comet(startPoint: CGPoint(x: width, y: 0.2 * height),
                            endPoint: CGPoint(x: 0, y: 0.25 * height),
                            lineColor: UIColor.red.withAlphaComponent(0.2),
                            cometColor: UIColor.red),
                      Comet(startPoint: CGPoint(x: 0, y: height - 0.8 * width),
                            endPoint: CGPoint(x: 0.6 * width, y: height),
                            lineColor: UIColor.red.withAlphaComponent(0.2),
                            cometColor: UIColor.red),
                      Comet(startPoint: CGPoint(x: width - 100, y: height),
                            endPoint: CGPoint(x: width, y: height - 100),
                            lineColor: UIColor.red.withAlphaComponent(0.2),
                            cometColor: UIColor.red),
                      Comet(startPoint: CGPoint(x: 0, y: 0.8 * height),
                            endPoint: CGPoint(x: width, y: 0.75 * height),
                            lineColor: UIColor.red.withAlphaComponent(0.2),
                            cometColor: UIColor.red)]
        
        // draw track and animate
        for comet in comets {
            view.layer.addSublayer(comet.drawLine())
            view.layer.addSublayer(comet.animate())
        }
        
        
    }
    
    
    @objc func billChange(sender1: UITextField){
        UserDefaults.standard.set(sender1.text, forKey: "String")
        Money.bill = Double(sender1.text!) ?? 0
        
        // Get Total tip by multiplying tip * tipPercentage
        Money.tip = Money.bill * Money.tipPercentages
        Money.total = Money.bill + Money.tip
        //Update Tip Amount Label Money.tip
        tipAmountLabel.text = numberFormatter.string(from:NSNumber(value: Money.tip))
        
        //Update Total Amount
        totalLabel.text = numberFormatter.string(from:NSNumber(value: Money.total))
        
        Money.perPersonMoney = Money.total / Money.person
        
        var perPersonmoney = 0.0
        if perPersonlabel.text == "Per Person (Up)"{
             perPersonmoney = ceil(Money.perPersonMoney)
        }else if perPersonlabel.text == "Per Person (Down)" {
            perPersonmoney = floor(Money.perPersonMoney)
        }else {
            perPersonmoney = Money.perPersonMoney
        }
        
        // formatter.locale = NSLocale.currentLocale() // This is the default
        // In Swift 4, this ^ has been renamed to simply NSLocale.curre

        perPerson.text = numberFormatter.string(from:NSNumber(value: perPersonmoney))
        
    }
    
    @objc func personChange(sender2: UIStepper){
        Money.person = sender2.value
        let personInt  =  Int(Money.person);
        var perPersonmoney = 0.0
        Money.perPersonMoney = Money.total / Money.person
       
        if perPersonlabel.text == "Per Person (Up)"{
             perPersonmoney = ceil(Money.perPersonMoney)
        }else if perPersonlabel.text == "Per Person (Down)" {
            perPersonmoney = floor(Money.perPersonMoney)
        }else {
            perPersonmoney = Money.perPersonMoney
        }
        
        perPerson.text = numberFormatter.string(from:NSNumber(value: perPersonmoney))
        personCount.text = String(format: "%d", personInt)
        

    }
    
    @objc func tipChange(sender3: UISlider){
        UserDefaults.standard.set(sender3.value, forKey: "Double1")
        let getTip = String(format: "%.2f", sender3.value)
        
        Money.tipPercentages = Double(getTip) ?? 0
        
        let percent = Int(Money.tipPercentages * 100)
       //

        //
        perCent.text = String(format: "%d %%", percent)

        Money.tip = Money.bill * Money.tipPercentages
        Money.total = Money.bill + Money.tip
        //Update Tip Amount Label
        tipAmountLabel.text = numberFormatter.string(from:NSNumber(value: Money.tip))
        
        totalLabel.text = numberFormatter.string(from:NSNumber(value:  Money.total))
        
        //Update Total Amount
        Money.perPersonMoney = Money.total / Money.person
        var perPersonmoney = 0.0
        if perPersonlabel.text == "Per Person (Up)"{
             perPersonmoney = ceil(Money.perPersonMoney)
        }else if perPersonlabel.text == "Per Person (Down)" {
            perPersonmoney = floor(Money.perPersonMoney)
        }else {
            perPersonmoney = Money.perPersonMoney
        }
        
        perPerson.text = numberFormatter.string(from:NSNumber(value: perPersonmoney))
        
    }
    
    @objc func donePressed () {
        billAmountTextField.resignFirstResponder()
    }
    
    
    
    @objc func reload1(){
        perPersonlabel.text = "Per Person (Up)"
        let perPersonmoney = ceil(Money.perPersonMoney)
        perPerson.text = numberFormatter.string(from:NSNumber(value: perPersonmoney))
        
     }
    @objc func reload2(){
        perPersonlabel.text = "Per Person (Down)"
        let perPersonmoney = floor(Money.perPersonMoney)
        
        perPerson.text = numberFormatter.string(from:NSNumber(value: perPersonmoney))
     }
    @objc func reload3(){
        perPersonlabel.text = "Per Person"
        let perPersonmoney = Money.perPersonMoney
        
        perPerson.text = numberFormatter.string(from:NSNumber(value: perPersonmoney))
     }
    @objc func reload4(){
        if Setting.currencyPick == 0 {
            numberFormatter.currencySymbol = currentSymbol
        }else if Setting.currencyPick == 1 {
            numberFormatter.currencySymbol = "$"
        }else if Setting.currencyPick == 2 {
            numberFormatter.currencySymbol = "€"
        }else if Setting.currencyPick == 3 {
            numberFormatter.currencySymbol = "¥"
        }else if Setting.currencyPick == 4 {
            numberFormatter.currencySymbol = "£"
        }else if Setting.currencyPick == 5 {
            numberFormatter.currencySymbol = "¥"
        }
        
     }
  
}
