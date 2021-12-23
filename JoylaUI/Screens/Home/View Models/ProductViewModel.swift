//
//  ProductViewModel.swift
//  JoylaUI
//
//  Created by Firdavs Boltayev on 03/11/21.
//

import Foundation


class ProductViewModel: ObservableObject {
    
    @Published var products = [Product]().split()
    func apiProductList(currentPage: Int){
        AFHttp.get(url: "api/products?user_lat=41.310804&user_lang=69.280934&page=\(currentPage)&size=10", params: AFHttp.paramsEmpty(), handler: {response in
            
            switch response.result {
            case .success:
                let pro = try? JSONDecoder().decode([Product].self, from: response.data!)
                guard let model = pro else {return}
                let myModel = model.split()
                DispatchQueue.main.async {
                    self.products.right += myModel.right
                    self.products.left += myModel.left
                }
            case let .failure(error):
                print(error)
            }
        })
    }
    func getList(page: Int = 0) {
        apiProductList(currentPage: page)
        
    }
}

