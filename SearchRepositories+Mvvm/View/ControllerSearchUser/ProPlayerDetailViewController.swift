//
//  ProPlayerDetailViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by nguyen.khai.hoan on 31/05/2022.
//

import UIKit
import Darwin

class ProPlayerDetailViewController: UIViewController {
    @IBOutlet weak var avaimage: UIImageView!
    
    @IBOutlet weak var nameplay: UILabel!
    @IBOutlet weak var personaname: UILabel!
    @IBOutlet weak var streamid: UILabel!
    @IBOutlet weak var team_name: UILabel!
    @IBOutlet weak var team_tag: UILabel!
    @IBOutlet weak var loccountrycode: UILabel!
    
    var user = UserModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        personaname.text = user.personaname
        streamid.text = user.steamid
        team_name.text = user.personaname
        team_tag.text = user.team_tag
        loccountrycode.text = user.loccountrycode
        nameplay.text = user.name
        avaimage.downloadImage(url: user.avafull)
       
    }


   

}
