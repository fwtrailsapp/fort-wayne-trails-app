//
//  AboutViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/14/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

/**
 Displays the necessary MIT licensing information.
 */
class AboutViewController: DraweredViewController {
    @IBOutlet weak var licenseLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let licenseString = "<br>Copyright &#169; 2016 Jared Perry, Jaron Somers, Warren Barnes, Scott Weidenkopf, and Grant Grimm<br><br>&nbsp;&nbsp;&nbsp;&nbsp;Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute,sublicense,and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;The above copyright notice and this permission notice shall be included in all copies<br>or substantial portions of the Software.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
        
        var attrStr = try! NSAttributedString(
            data: licenseString.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil
        )
        // NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 18.0)!
        licenseLabel.attributedText = attrStr
    }

}
