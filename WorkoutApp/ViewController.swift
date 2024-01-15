//
//  ViewController.swift
//  WorkoutApp
//
//  Created by Rushikesh Dahale on 22/11/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var dietArray : [[String]] =
    [["chest", "back","bicep","shoulderjpeg","tricepp", "leg"],
     ["chestTitle", "backTitle","bicepTitle","shoulderTitle","tricepTitle", "legTitle"]]
   
    var workoutArray : [[String]] =
    [["chestTitle", "backTitle","bicepTitle","shoulderTitle","tricepTitle", "legTitle"],
     ["chestworkout", "backworkout","bicepworkout", "shoulderworkout", "bicepworkout", "legworkout", "cardioworkout"]]
   
    @IBOutlet weak var workoutTableView: UITableView!
    @IBOutlet weak var workoutCollectionView: UICollectionView!
    
    var daysArray : [Session] = []
    
    
    let dayTableViewcellIdentifier : String = "DayTableViewCell"
    let workoutCollectionViewcellIdentifier : String = "workoutCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        initializeTableView()
        registerXIBWithPostTableView()
        register()
        initialize()
        
    }
    
    func initializeTableView(){
        workoutTableView.dataSource = self
        workoutTableView.delegate = self
    }
    
    func registerXIBWithPostTableView(){
        let uiNib = UINib(nibName: dayTableViewcellIdentifier, bundle: nil)
        workoutTableView.register(uiNib, forCellReuseIdentifier: dayTableViewcellIdentifier)
        
    }
    
    func register() {
        let uiNib = UINib(nibName: workoutCollectionViewcellIdentifier, bundle: nil)
        workoutCollectionView.register(uiNib, forCellWithReuseIdentifier: workoutCollectionViewcellIdentifier)
    }

    func initialize() {
        workoutCollectionView.dataSource = self
        workoutCollectionView.delegate = self
    }
    
    func fetchData(){
        let url = URL(string: "https://mocki.io/v1/a7a257e1-4ad1-410c-a0d3-3b7037b5b9be")

        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        
        let urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession.dataTask(with: urlRequest){data,response,error in
            let apiResponse = try! JSONSerialization.jsonObject(with: data!) as! [String : Any]
            _ = apiResponse["total"]as! String
            let session = apiResponse["session"]as! [[String:Any]]
            for eachday in session{
                let day = eachday["day"]as!String
                let workout = eachday["workout"]as! String
                let title = eachday["title"]as! String
                let Instruction = eachday["Instruction"] as!String
                let image = eachday["image"]as! String
                let imageUrl = URL(string: image)
                let newSessionObject = Session(day: day,
                                               workout: workout,
                                               title: title,
                                               Instruction: Instruction,
                                               image: image,
                                               imageUrl: imageUrl)
                self.daysArray.append(newSessionObject)
            }
            DispatchQueue.main.async{
            self.workoutTableView.reloadData()
            }
        }
        dataTask.resume()
    }
}
extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        daysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dayTableViewCell = tableView.dequeueReusableCell(withIdentifier: dayTableViewcellIdentifier,for: indexPath) as! DayTableViewCell
        dayTableViewCell.sessionDay.text = daysArray[indexPath.row].day
        dayTableViewCell.sessionWorkout.text = daysArray[indexPath.row].workout
//      dayTableViewCell.sessionTitle.text = daysArray[indexPath.row].title
        dayTableViewCell.sessionInstruction.text = daysArray[indexPath.row].Instruction
        dayTableViewCell.sessionImage.image = UIImage(named: dietArray[0][indexPath.row])
       
        return dayTableViewCell
        
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NextViewController") as! NextViewController
        NextViewController.selectedCategory = dietArray[0][indexPath.row]
        NextViewController.selectedSession = dietArray[1][indexPath.row]
        navigationController?.pushViewController(NextViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225.0
    }
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workoutArray[0].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let WorkoutCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: workoutCollectionViewcellIdentifier, for: indexPath) as! workoutCollectionViewCell
        
        WorkoutCollectionViewCell.workoutImage.image = UIImage(named: workoutArray[0][indexPath.item])
        WorkoutCollectionViewCell.workoutImage.layer.cornerRadius = 50.0
        return WorkoutCollectionViewCell
        
    }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        secondViewController.containerr = workoutArray[1][indexPath.item]
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300.0, height: 150.0)

    }
}

