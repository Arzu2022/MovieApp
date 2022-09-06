//
//  FirstViewController.swift
//  presentation
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import UIKit
import RxSwift

public class FirstViewController:BaseViewController<FirstViewModel> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.vm?.getMovie().then({ m in
            print(m.results?[0].voteCount ?? "")
            print(m.results?[0].title ?? "")
        }).catch({ Error in
            print(Error)
        })
    }
}
