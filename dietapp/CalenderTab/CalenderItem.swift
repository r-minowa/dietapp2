//
//  CalenderItem.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/18.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import Parchment

struct CalendarItem: PagingItem, Hashable, Comparable {
  let date: Date
  let dateText: String
  let weekdayText: String
  
  init(date: Date) {
    self.date = date
    self.dateText = DateFormatters.dateFormatter.string(from: date)
    self.weekdayText = DateFormatters.weekdayFormatter.string(from: date)
  }
  
  static func < (lhs: CalendarItem, rhs: CalendarItem) -> Bool {
    return lhs.date < rhs.date
  }
}
