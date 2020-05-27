//
//  ConfigViewController.swift
//  NQumicaInorganica
//
//  Created by Melba Consuelos on 22/04/20.
//  Copyright © 2020 Humberto Gonzalez Sanchez. All rights reserved.
//

import UIKit

class ConfigViewController: ViewController {

    @IBOutlet weak var swAcidos: UISwitch!
    @IBOutlet weak var swIbin: UISwitch!
    @IBOutlet weak var swIPoli: UISwitch!
    @IBOutlet weak var swMol: UISwitch!
    @IBOutlet weak var swCVar: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btGuardar(_ sender: Any) {
    }
    
}
