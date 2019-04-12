import UIKit

class TableViewController: UITableViewController {
    
    private static let CellIdentifier = "CellIdentifier"
    var fa: [FoodInfo] = []
    var mi: MenuItem!
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFood()


        initView()
    }
    
    func initView() -> Void {
        mi = MenuItem()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TableViewController.CellIdentifier)
        tableView.register(MenuItem.self, forCellReuseIdentifier: cellId)
    }
    func createFood() -> Void {
        fa.append(FoodInfo(indicator: "A", name: "Cheese, Canadian Lobster, Italian Rice", price: "55", available: true, type: 3))
        fa.append(FoodInfo(indicator: "B", name: "Hokkaido Belt Mind Beef Spaghetti with Salmon Seeds", price: "40", available: true, type: 4))
        fa.append(FoodInfo(indicator: "C", name: "Burning Spanish Black Pork Chop with Apple Crisp", price: "40", available: true, type: 3))
        fa.append(FoodInfo(indicator: "D", name: "Burning Spanish Black Pork Chop", price: "40", available: false, type: 1))
        fa.append(FoodInfo(indicator: "E", name: "Burning only Boston lobster", price: "55", available: true, type: 4))
        fa.append(FoodInfo(indicator: "F", name: "Amuse bouche", price: "55", available: true, type: 1))
        fa.append(FoodInfo(indicator: "G", name: "Apple Crisp", price: "40", available: true, type: 4))
        fa.append(FoodInfo(indicator: "H", name: "Amuse bouche", price: "70", available: true, type: 2))
        fa.append(FoodInfo(indicator: "I", name: "a", price: "40", available: false, type: 5))
        fa.append(FoodInfo(indicator: "J", name: "Signature Rose Ice Cream", price: "40", available: true, type: 6))
        fa.append(FoodInfo(indicator: "K", name: "Burning only Boston lobster", price: "40", available: true, type: 6))
        fa.append(FoodInfo(indicator: "L", name: "a", price: "35", available: true, type: 1))
        fa.append(FoodInfo(indicator: "M", name: "Apple Crisp", price: "40", available: false, type: 6))
        fa.append(FoodInfo(indicator: "N", name: "Signature Rose Ice Cream", price: "40", available: true, type: 1))
        fa.append(FoodInfo(indicator: "O", name: "Slow-cooked Kurobuta pork", price: "20", available: false, type: 2))
        fa.append(FoodInfo(indicator: "P", name: "Signature Rose Ice Cream", price: "40", available: false, type: 5))
        fa.append(FoodInfo(indicator: "Q", name: "Slow-cooked Kurobuta pork", price: "45", available: true, type: 1))
        fa.append(FoodInfo(indicator: "R", name: "Signature Rose Ice Cream", price: "40", available: true, type: 2))
        fa.append(FoodInfo(indicator: "S", name: "Slow-cooked Kurobuta pork", price: "60", available: true, type: 1))
        fa.append(FoodInfo(indicator: "T", name: "Slow-cooked Kurobuta pork", price: "60", available: true, type: 2))
        fa.append(FoodInfo(indicator: "U", name: "Slow-cooked Kurobuta pork", price: "40", available: true, type: 2))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fa.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 450 //or whatever you need
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuItem
//        cell.textLabel?.text = fa[indexPath.row].name
        if (!fa[indexPath.row].available) {
            cell.foodIndicator.textColor = UIColor.gray
            cell.foodName.textColor = UIColor.gray
            cell.priceLabel.textColor = UIColor.gray
        }
        cell.food = fa[indexPath.row]
        return cell
    }
    
}
