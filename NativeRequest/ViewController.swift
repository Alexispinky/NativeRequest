//
//  ViewController.swift
//  NativeRequest
//
//  Created by DISMOV on 13/05/22.
//

import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personajes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:ri, for:indexPath)
        let dict = personajes[indexPath.row]
        cell.textLabel?.text = dict["name"] as? String ?? "Un personaje"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detalle", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nuevoVC = segue.destination as! ViewControllerD
        if let indePath = tablev.indexPathForSelectedRow{
            let personaje = personajes[indePath.row]
            nuevoVC.personaje = personaje
        }
    }
}

class ViewController: UIViewController {

    var personajes = [[String:Any]]()
    var ri = "recicler"
    var tablev = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = InternetStatus.instance
        tablev.frame = self.view.bounds
                self.view.addSubview(tablev)
                tablev.register(UITableViewCell.self, forCellReuseIdentifier:ri )
                tablev.dataSource = self
                tablev.delegate = self

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if InternetStatus.instance.internetType == .none{
            let alert = UIAlertController(title: "ERRRRORRR!!", message: "Sin conexion a internet", preferredStyle: .alert)
            let boton = UIAlertAction(title: "Ok", style: .default){
                alert in exit(666)
            }
            alert.addAction(boton)
            self.present(alert, animated: true)
        }
        else if InternetStatus.instance.internetType == .cellular {
                    let alert = UIAlertController(title: "Confirme", message: "Solo hay conexión a internet por datos celulares", preferredStyle: .alert)
                    let boton1 = UIAlertAction(title: "Continuar", style: .default) { alert in
                        self.descargar()
                    }
                    let boton2 = UIAlertAction(title: "Cancelar", style: .cancel)
                    alert.addAction(boton1)
                    alert.addAction(boton2)
                    self.present(alert, animated:true)
                }
                else {
                    self.descargar()
                }
    }
    
    func descargar(){
        if let url = URL(string: "https://rickandmortyapi.com/api/character"){
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "GET"
            let sesion = URLSession.shared
            let tarea = sesion.dataTask(with: request as URLRequest, completionHandler: {
                datos, respuesta, error in
                if error != nil {
                    print("algo salio mal \(error?.localizedDescription)")
                }
                else{
                    do{
                        let json = try JSONSerialization.jsonObject(with: datos!,options: .fragmentsAllowed) as! [String:Any]
                        print (json)
                        self.personajes = json["results"] as! [[String:Any]]
                                                DispatchQueue.main.async {
                                                    self.tablev.reloadData()
                                                }
                    }
                    catch{
                        print("algo salio mal")
                    }                }
                
            })
            tarea.resume()
        }
    }

}

