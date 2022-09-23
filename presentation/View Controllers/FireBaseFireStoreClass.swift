//
//  FireBaseFireStoreClass.swift
//  presentation
//
//  Created by AziK's  MAC on 22.09.22.
//

import Foundation
import FirebaseFirestore
import UIKit

public class FireBaseFireStoreClass : UIViewController{
    let db = Firestore.firestore()
//    public init(){
//        super.init()
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
//    public let adult: Bool?
//    public let backdropPath: String?
//    public let genreIDS: [Int]?
//    public let id: Int
//    public let originalLanguage: String?
//    public let originalTitle, overview: String?
//    public let popularity: Double?
//    public let posterPath, releaseDate, title: String?
//    public let video: Bool?
//    public let voteAverage: Double?
//    public let voteCount: Int?
    
    
    
    
    public func saveToDB(idMovie:Int,idAuth:String,adult: Bool,backdropPath: String,genreIDS: [Int],id: Int,originalLanguage: String,originalTitle:String, overview: String,popularity: Double,posterPath:String, releaseDate:String, title: String,video: Bool,voteAverage: Double,voteCount: Int,time:Date){
        var ref: DocumentReference? = nil
            ref = db.collection("save_\(idMovie)_\(idAuth)").addDocument(data: [
                "adult": adult,
                "backdropPath": backdropPath,
                "genreIDS": genreIDS,
                "id": id,
                "originalLanguage": originalLanguage,
                "originalTitle": originalTitle,
                "overview": overview,
                "popularity": popularity,
                "posterPath": posterPath,
                "releaseDate": releaseDate,
                "title": title,
                "video": video,
                "voteAverage": voteAverage,
                "voteCount": voteCount,
                "time": Date.now
            ]) { err in
                if let err = err {
                    self.makeAlert(title: "Error", message: err.localizedDescription)
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
        }
        
    }
    func makeAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(btn)
        self.present(alert, animated: true)
    }
//    public func saveCommentToDB(idMovie:Int,idAuth:Int){
//        var ref: DocumentReference? = nil
//            ref = db.collection("users").addDocument(data: [
//                "first": "Ada",
//                "last": "Lovelace",
//                "born": 1815,
//                "time": Date.now
//            ]) { err in
//                if let err = err {
//                    print("Error adding document: \(err)")
//                } else {
//                    print("Document added with ID: \(ref!.documentID)")
//                }
//            }
//
//    }
    public func getSavedFromDB(type:String){
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
//    public func getCommentsFromDB(docName:String){
//
//        db.collection(docName).getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
//    }
    
}
