//
//  ProfileViewModel.swift
//  JoylaUI
//
//  Created by Firdavs Boltayev on 24/11/21.
//

import Foundation

class ProfileviewModel: ObservableObject {
    
    @Published var profiles = [ProfileModel]().split() // []
    
    init(id: Int) {
        self.profileGet(id: id)
    }  
    private func profileGet(id: Int){
        AFHttp.get(url: "api/products?user_lat=41.45345&user_lang=69.4543534&created_by=\(id)", params: AFHttp.paramsEmpty()) { response in
            switch response.result{
            case .success:
                print(response.result)
                do {
                    let pro = try JSONDecoder().decode([ProfileModel].self, from: response.data!)
                    let profil  = pro.split()
                    self.profiles = profil
                    // Bizga serverdan nima kelayotganligini ko'rsatib beradi
//                    let pro = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: .allowFragments)
                   
                } catch {
                    // bizga qanday eroor kelayotganligi aytib beradi
                    print(error.localizedDescription)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
