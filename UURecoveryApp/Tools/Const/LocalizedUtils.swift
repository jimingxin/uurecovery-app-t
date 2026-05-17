import Foundation

extension String {
  var localized: String { return NSLocalizedString(self, comment: self) }
/*
  Localizable.strings
  CXMerchant

  Created by zainguo on 2020/7/30.
  Copyright © 2020 zainguo. All rights reserved.
*/

  static var localized_帮助中心: String { return "帮助中心".localized }

}
