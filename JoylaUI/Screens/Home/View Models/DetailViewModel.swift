//
//  DetailViewModel.swift
//  JoylaUI
//
//  Created by Firdavs Boltayev on 04/11/21.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var pageProducts: PageData?
    @Published var moreLike = [MoreLikeModel]().split()
    
    init(id: Int) {
        self.apiPageList(id: id)
    }
    func apiPageList(id: Int) {
        AFHttp.get(url: AFHttp.API_GET_DETAIL + String(id), params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result{
            case .success:
                let pro = try? JSONDecoder().decode( PageData.self, from: response.data!)
                guard let model = pro else {return}
                self.pageProducts = model
                self.apiMoreLikeThis(id: model.category?.id ?? 0)
            case let .failure(error):
                print(error)
            }
        })
    }
    
    func apiMoreLikeThis(id:Int) {
        AFHttp.get(url: "api/products?user_lat=41.310804&user_lang=69.280934&more_like_this=true&category_id=\(id)&size=18" , params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result{
            case .success:

                let more = try? JSONDecoder().decode([MoreLikeModel].self, from: response.data!)
                guard let more = more else { return }
                let like = more.split()
                self.moreLike = like
                
            case let .failure(error):
                print(error)
            }
        })
    }
}
