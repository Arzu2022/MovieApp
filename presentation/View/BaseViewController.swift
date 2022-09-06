//
//  BaseViewController.swift
//  presentation
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import UIKit

public class BaseViewController<VM>:UIViewController {
    var vm :VM? = nil
    var router:RouterProtocol? = nil
    
}
