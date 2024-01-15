// NextViewController.swift

import UIKit

class NextViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var gifArray: [[String]] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifArray.isEmpty ? 0 : gifArray[0].count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hwTableViewCell = tableView.dequeueReusableCell(withIdentifier: hwTableViewCellIdentifier, for: indexPath) as! HWTableViewCell
        hwTableViewCell.gifImage.image = UIImage.gifImageWithName(name: gifArray[0][indexPath.row])
        return hwTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let fourthViewController = self.storyboard?.instantiateViewController(withIdentifier: "FourthViewController") as! FourthViewController
    
        fourthViewController.container = gifArray[0][indexPath.row]
          navigationController?.pushViewController(fourthViewController, animated: true)
      }
    
    var chestArray : [[String]] = [["chest1","chest2","chest3","chest4","chest5","chest6"]]
    
    var backArray: [[String]] = [["back1", "back2", "back3", "back4", "back5", "back6"]]

    var bicepArray: [[String]] = [["bicep1", "bicep2", "bicep3", "bicep4", "bicep5", "bicep6"]]

    var calorieArray: [[String]] = [["calorie1","calorie2","calorie3","calorie4","calorie5","calorie6"]]

    var shoulderArray: [[String]] = [["shoulder1", "shoulder2", "shoulder3", "shoulder4", "shoulder5", "shoulder6"]]
    var legArray: [[String]] = [["leg1", "leg2", "leg3", "leg4", "leg5", "leg6"]]

    
    @IBOutlet weak var ExerciseDayImage: UIImageView!
    @IBOutlet weak var hwTableView: UITableView!
    
    var selectedCategory: String?
    var selectedSession: String?
    var hwTableViewCellIdentifier = "HWTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedCategory = selectedCategory {
            
            switch selectedCategory {
            case "chest":
                gifArray = chestArray
            case "back":
                gifArray = backArray
            case "bicep":
                gifArray = bicepArray
            case "shoulder":
                gifArray = shoulderArray 
            case "leg":
                gifArray = legArray
            case "cardio":
                gifArray = calorieArray
            default:
                break
            }
        }
        
        if let selectedSession = selectedSession {
            ExerciseDayImage.image = UIImage(named: selectedSession)
        } else {
            ExerciseDayImage.image = UIImage(named: "defaultImage")
        }
        
        initializeStudentTableView()
        registerXIBWithStudentTableView()
    }
    
    func initializeStudentTableView() {
        hwTableView.dataSource = self
        hwTableView.delegate = self
    }
    
    func registerXIBWithStudentTableView() {
        let uiNib = UINib(nibName: hwTableViewCellIdentifier, bundle: nil)
        self.hwTableView.register(uiNib, forCellReuseIdentifier: hwTableViewCellIdentifier)
    }
}

extension UIImage {
    class func gifImageWithName(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif"),
              let imageData = try? Data(contentsOf: bundleURL) else {
            return nil
        }

        let source = CGImageSourceCreateWithData(imageData as CFData, nil)
        let count = CGImageSourceGetCount(source!)

        var images = [UIImage]()

        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source!, i, nil) {
                let uiImage = UIImage(cgImage: cgImage)
                images.append(uiImage)
            }
        }

        return UIImage.animatedImage(with: images, duration: Double(images.count) * 0.1)
    }
}

