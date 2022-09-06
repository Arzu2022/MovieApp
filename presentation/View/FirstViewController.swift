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
    private var movieSubcribtion: Disposable? = nil
    private var disposeBag = DisposeBag()
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
//        self.vm?.getMovie().then({ MovieEntity in
//            print(MovieEntity.totalResults!)
//        })
//    }
//        self.vm?.syncMovie()
//        self.vm?.syncMovie()
//        self.vm?.syncMovie()
        self.vm?.getMovie().then({ m in
            print(m.results?[0].voteCount)
            print(m.results?[0].title)
        })
    }
    
//       public override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//           movieSubcribtion = self.vm?.observeMovie().subscribe({ recieved in
//               guard let data = recieved.element else {return}
//              // print(data.results?.capacity)
//           })
//           movieSubcribtion?.disposed(by: self.disposeBag)
//        }
//    public override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        movieSubcribtion?.dispose()
//    }
    
}
