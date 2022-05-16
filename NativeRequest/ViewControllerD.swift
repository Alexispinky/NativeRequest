//
//  ViewControllerD.swift
//  NativeRequest
//
//  Created by DISMOV on 14/05/22.
//

import UIKit
	
class ViewControllerD: UIViewController {
    
    @IBOutlet weak var imag: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var especie: UILabel!
    @IBOutlet weak var edad: UILabel!
    var personaje = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        imag.image = UIImage(named: "default")
        
        nombre.text = personaje["name"] as? String ?? "Un personaje"
        
        especie.text = personaje["species"] as? String ?? "Un personaje"
        edad.text = personaje["status"] as? String ?? "Un personaje"
        
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

}
