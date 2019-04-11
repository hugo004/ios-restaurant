//
//  StorageHelper.swift
//  ios-restaurant
//
//  Created by Hugo on 8/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

enum FoodType: String {
    case Firerice = "Firerice"
    case Firenoodle = "Firenoodle"
    case Sushi = "Sushi"
    case Noodle = "Noodle"
    case Desert = "Dessert"
    case Category = "Category"

}

enum FoodStatus: Int {
    case OnSale = 1
    case SoldOut = 0
}

struct Food: Codable {
    var name: String
    var price: Int
    var image: Data?
    var ingredient: String?
    var status: Int
    var type: String
    
    init(name: String, price: Int, image: UIImage, type: FoodType) {
        self.name = name;
        self.price = price;
        self.image = image.pngData()!;
        self.ingredient = "";
        self.type = type.rawValue;
        self.status = FoodStatus.OnSale.rawValue;
    }
    
    init(name: String, price: Int, image: UIImage, type: FoodType, status: FoodStatus, ingredient: String?) {
        self.name = name;
        self.price = price;
        self.image = image.pngData()!;
        self.ingredient = ingredient;
        self.type = type.rawValue;
        self.status = status.rawValue;
    }
    
    
    init(name: String, price: Int, type: FoodType) {
        self.name = name;
        self.price = price;
        self.image = nil;
        self.ingredient = "";
        self.type = type.rawValue;
        self.status = FoodStatus.OnSale.rawValue;
    }
    
    init(type: FoodType) {
        self.name = "";
        self.price = 1;
        self.image = nil;
        self.ingredient = "";
        self.type = type.rawValue;
        self.status = FoodStatus.OnSale.rawValue;
    }
}

struct FoodCategory: Codable {
    var category: String
    var image: Data
    
    init(category: FoodType, image:UIImage) {
        self.category = category.rawValue;
        self.image = image.pngData()!;
    }
}

struct UserInfo: Codable {
    var role: String
    var name: String
    var height: Int
    var weight: Int
    var dob: Date
    var icon: Data?
    
    init(name: String, height: Int, weight: Int, dob: Date, icon: UIImage, role: String) {
        self.name = name;
        self.height = height;
        self.weight = weight;
        self.dob = dob;
        self.icon = icon.pngData();
        self.role = role;
    }
    
    init() {
        self.name = "";
        self.height = 0;
        self.weight = 0;
        self.dob = Date();
        self.icon = nil;
        self.role = "";
    }
}

let User_Info_Key = "USER_INFO";

class StorageHelper {
    
    static func clearAllStorage() {
        let userDefault = UserDefaults.standard;
        let dic = userDefault.dictionaryRepresentation();
        dic.keys.forEach { (key) in
            userDefault.removeObject(forKey: key);
        }
    }
    
    static func setupFoodData(size: Int, name: String, price: Int, category: FoodType) {
        let prefix = category.rawValue.lowercased();
        var array: [Food] = [];
        
        for i in 1 ... size {
            array.append(Food(name: "\(category.rawValue)-\(i)",
                price: price,
                image: UIImage(named: "\(prefix)-\(i)")!,
                type: category));
        }
        
        saveFoods(data: array, type: category);
        
    }
    
    //MARK: - Food data
    //food category
    static func intiFoodData() {
        var category: [FoodCategory] = [];
        
        let sushi = FoodCategory(category: .Sushi, image: UIImage(named: "sushi-cover")!);
        setupFoodData(size: 10, name: "", price: 1, category: .Sushi);
        
        let noodle = FoodCategory(category: .Noodle, image: UIImage(named: "noodle-cover")!);
        setupFoodData(size: 10, name: "", price: 1, category: .Noodle);
        
        let firerice = FoodCategory(category: .Firerice, image: UIImage(named: "firerice-cover")!);
        setupFoodData(size: 10, name: "", price: 1, category: .Firerice);

        let firenoodle = FoodCategory(category: .Firenoodle, image: UIImage(named: "firenoodle-cover")!);
        setupFoodData(size: 10, name: "", price: 1, category: .Firenoodle);

        let desert = FoodCategory(category: .Desert, image: UIImage(named: "dessert-cover")!);
        setupFoodData(size: 10, name: "", price: 1, category: .Desert);


        category.append(sushi);
        category.append(noodle);
        category.append(firerice);
        category.append(firenoodle);
        category.append(desert);
        
        
        let encoded = try? PropertyListEncoder().encode(category); //custom object need encode first
        UserDefaults.standard.setValue(encoded, forKey: FoodType.Category.rawValue);
        UserDefaults.standard.synchronize();
        
    }
    
    static func getFoodCategetory() -> [FoodCategory] {
        var category: [FoodCategory]?;
        if let data = UserDefaults.standard.value(forKey: FoodType.Category.rawValue) as? Data {
            category = try? PropertyListDecoder().decode([FoodCategory].self, from: data);
        }
        
        return category ?? [];
    }
    
    static func addFoodCategory() {}
    
    //foods
    static func saveFoods(data: [Food], type: FoodType) {
        
        let encoded = try? PropertyListEncoder().encode(data); //custom object need encode first
        UserDefaults.standard.setValue(encoded, forKey: type.rawValue);
        UserDefaults.standard.synchronize();

    }

    static func retreiveFoods(type: FoodType) -> [Food] {
        var foods: [Food]?;
        if let data = UserDefaults.standard.value(forKey: type.rawValue) as? Data {
            foods = try? PropertyListDecoder().decode([Food].self, from: data);
        }

        return foods ?? [];
    }
    
    static func addFoods(data: Food) {
        let type = FoodType(rawValue: data.type)!;
        var foods = retreiveFoods(type: type);
        foods.append(data);
        saveFoods(data: foods, type: type);
    }
    
    static func updateFoods(old: Food, new: Food) {
        let type = FoodType(rawValue: old.type)!;
        var foods = retreiveFoods(type: type);
        var index = -1;
        
        index = foods.firstIndex { (food) -> Bool in
            //compare image data to find the index, image data should unique
            return food.image == old.image;
        }!
        
        if index != -1 {
            foods[index] = new;
            saveFoods(data: foods, type: type);
        }else {
            print("update food fail");
        }
        
    }
    
    //MARK: - User profile
    static func saveUserInfo(data: UserInfo) {
        let encoded = try? PropertyListEncoder().encode(data); //custom object need encode first
        UserDefaults.standard.setValue(encoded, forKey: User_Info_Key);
        UserDefaults.standard.synchronize();
    }
    
    static func getUserInfo() -> UserInfo {
        var userInfo: UserInfo?;
        if let data = UserDefaults.standard.value(forKey: User_Info_Key) as? Data {
            userInfo = try? PropertyListDecoder().decode(UserInfo.self, from: data);
        }
        
        return userInfo ?? UserInfo();
    }
    
    static func updateUserInfo(new: UserInfo) {
        saveUserInfo(data: new);
    }

}
