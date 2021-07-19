//
//  SettingsViewController.swift
//  Prework
//
//  Created by Ning on 7/1/21.
//

import UIKit
import Comets
import Gradients
import SnapKit
import SwiftTheme
import RxSwift
import RxCocoa
import RxDataSources
import FaveButton

class  Setting{
     struct Variables {
        static var roundSegment = 0
        static var currencyPick = 0
        static var colourDark = false
     }
 }
extension Setting {
    class var roundSegment: Int {
        get {
            return Variables.roundSegment
        }
        set {
            Variables.roundSegment = newValue
        }
    }
    class var currencyPick: Int {
        get {
            return Variables.currencyPick
        }
        set {
            Variables.currencyPick = newValue
        }
    }
    class var colourDark: Bool {
        get {
            return Variables.colourDark
        }
        set {
            Variables.colourDark = newValue
        }
    }
   
 }
//9999999999999
func color(_ rgbColor: Int) -> UIColor{
    return UIColor(
        red:   CGFloat((rgbColor & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbColor & 0x00FF00) >> 8 ) / 255.0,
        blue:  CGFloat((rgbColor & 0x0000FF) >> 0 ) / 255.0,
        alpha: CGFloat(1.0)
    )
}

class SettingsViewController: UIViewController,FaveButtonDelegate {
    ///9999999999999
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
    }
    
   
    
  //  func numberOfComponents(in pickerView: UIPickerView) -> Int {
  //      return 1
  //  }
    
  //  var dataArray:Array<String>?
//9999999999
    @IBOutlet weak var starButton: FaveButton!
    @IBOutlet weak var zanButton: FaveButton!
    @IBOutlet weak var smileButton: FaveButton!
    @IBOutlet weak var heartButton: FaveButton!
    //99999
    @IBOutlet weak var rounded: UISegmentedControl!
    @IBOutlet weak var pickCurrency: UIPickerView!
    
    //111
    @IBOutlet weak var roundTitle: UILabel!
    @IBOutlet weak var nightTitle: UILabel!
    @IBOutlet weak var currencyTitle: UILabel!
    @IBOutlet weak var nightSwitch: UISwitch!
    //111
    
    
        //设置文字属性的pickerView适配器
  //  var pickerView:UIPickerView!
    
      private let attrStringPickerAdapter = RxPickerViewAttributedStringAdapter<[String]>(
          components: [],
          numberOfComponents: { _,_,_  in 1 },
          numberOfRowsInComponent: { (_, _, items, _) -> Int in
              return items.count}
          ){ (_, _, items, row, _) -> NSAttributedString? in
              return NSAttributedString(string: items[row],
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.systemBlue,//橙色文字
                        NSAttributedString.Key.textEffect:
                      NSAttributedString.TextEffectStyle.letterpressStyle
              ])
          }
       
      let disposeBag = DisposeBag()
    //
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rounded.selectedSegmentIndex  =  Setting.roundSegment
        pickCurrency.selectRow(Setting.currencyPick, inComponent: 0, animated:true)
        
        nightSwitch.isOn = Setting.colourDark
       MyThemes.switchNight(isToNight: Setting.colourDark)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Setting.currencyPick = pickCurrency.selectedRow(inComponent: 0)
        SnailNotice.post(notification: .currencyPick)
        
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
//9999999
        self.starButton?.setSelected(selected: true, animated: false)
        self.starButton?.setSelected(selected: false, animated: false)
        self.smileButton?.setSelected(selected: true, animated: false)
        self.smileButton?.setSelected(selected: false, animated: false)
        self.heartButton?.setSelected(selected: true, animated: false)
        self.heartButton?.setSelected(selected: false, animated: false)
        self.zanButton?.setSelected(selected: true, animated: false)
        self.zanButton?.setSelected(selected: false, animated: false)
       // pickCurrency.dataSource = self
       // pickCurrency.delegate = self
            //    dataArray = ["Default","USD($)","EUR(€)","CNY(¥)","GBP(£)","JPY(¥)"]
        
        //123
     //   pickerView = UIPickerView()
           //    self.view.addSubview(pickerView)
               //绑定pickerView数据
               Observable.just(["Default","USD($)","EUR(€)","CNY(¥)","GBP(£)","JPY(¥)"])
                   .bind(to: pickCurrency.rx.items(adapter: attrStringPickerAdapter))
                   .disposed(by: disposeBag)
        //123
        
        //111111111111111
        let state = UserDefaults.standard.bool(forKey: "switchState")
                nightSwitch.setOn(state, animated: true)
        
                    //1111111111
       view.theme_backgroundColor = GlobalPicker.backgroundColor
        
        updateTheme()
        roundTitle.theme_textColor = GlobalPicker.textColor
        currencyTitle.theme_textColor = GlobalPicker.textColor
        nightTitle.theme_textColor = GlobalPicker.textColor
    
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 0)
        let titleAttributes = GlobalPicker.barTextColors.map { hexString in
            return [
                NSAttributedString.Key.foregroundColor: UIColor(rgba: hexString),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.shadow: shadow
            ]
        }
        
        rounded.theme_setTitleTextAttributes(ThemeStringAttributesPicker.pickerWithAttributes(titleAttributes), forState: .normal)
        //pickCurrency.theme_backgroundColor = GlobalPicker.textColor
        pickCurrency.theme_tintColor = GlobalPicker.textColor

        updateNightSwitch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateNightSwitch), name: NSNotification.Name(rawValue: ThemeUpdateNotification), object: nil)
        
    
        // Customize your comet
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
    
        //111111111111111
        
        
        // Do any additional setup after loading the view.
      
        
    }
    
    
    @IBAction func roundChange(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        Setting.roundSegment = sender.selectedSegmentIndex
        if sender.selectedSegmentIndex == 1 {
        SnailNotice.post(notification: .perPersonUp)
        }else if sender.selectedSegmentIndex == 2 {
            SnailNotice.post(notification: .perPersonDown)
        }else{
        SnailNotice.post(notification: .perPersonDefault)
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
    
    @IBAction func changeNight(_ sender: UISwitch) {
        MyThemes.switchNight(isToNight: sender.isOn)
        Setting.colourDark = sender.isOn

        UserDefaults.standard.set(sender.isOn, forKey: "switchState")
    }
    @objc private func updateNightSwitch() {
        nightSwitch.isOn = MyThemes.isNight()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        
        updateTheme()
    }
    
    private func updateTheme() {
      
        switch traitCollection.userInterfaceStyle {
        case .light:
            MyThemes.switchNight(isToNight: false)
        case .dark:
            MyThemes.switchNight(isToNight: true)
        case .unspecified:
            break
        @unknown default:
            break
        }
    }
    
    
    let colors = [
        DotColors(first: color(0x7DC2F4), second: color(0xE2264D)),
        DotColors(first: color(0xF8CC61), second: color(0x9BDFBA)),
        DotColors(first: color(0xAF90F4), second: color(0x90D1F9)),
        DotColors(first: color(0xE9A966), second: color(0xF8C852)),
        DotColors(first: color(0xF68FA7), second: color(0xF6A2B8))
    ]
    
    
    func faveButtonDotColors(_ faveButton: FaveButton) -> [DotColors]?{
        if( faveButton === heartButton || faveButton === starButton || faveButton === smileButton || faveButton === zanButton){
            return colors
        }
        return nil
    }

}
