//
//  SnailNotice.swift
//  Prework
//
//  Created by Ning on 7/13/21.
//

import Foundation
import UIKit

protocol ValueBackDelegate {
    func ValueBack(value: String)
}

  protocol Notifier {
      associatedtype Notification: RawRepresentable
      
  }

  extension Notifier where Notification.RawValue == String {
      
     static func nameFor(notification: Notification) -> String {

          return "\(notification.rawValue)"
      }
  }

  class SnailNotice: Notifier {
      
      /// 发送通知
      static func post(notification: Notification, object:AnyObject? = nil) {
          
          let name = nameFor(notification: notification)
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: object)
      }
      
      /// 增加观察 - 接收通知
      static func add(observer: AnyObject, selector: Selector, notification: Notification, object:AnyObject? = nil) {
          
          let name = nameFor(notification: notification)
          NotificationCenter.default
              .addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
      }
      
      /// 移除观察 - 移除通知
      static func remove(observer: AnyObject, notification: Notification, object:AnyObject? = nil) {
          
          let name = nameFor(notification: notification)
          NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: name), object: object)
      }
  }

  // 定义的通知名字
  extension SnailNotice {
      enum Notification: String {
          /// per person(up)
          case perPersonUp
          /// 伤心
          case perPersonDown
          /// 睡觉
          case perPersonDefault
          /// ....
        case currencyPick
        ///
        case changeNight
      }
  }
