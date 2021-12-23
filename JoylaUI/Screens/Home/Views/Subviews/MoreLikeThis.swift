//
//  MoreLikeThis.swift
//  JoylaUI
//
//  Created by Firdavs Boltayev on 11/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoreLikeThis: View {
    @EnvironmentObject var itemsModel: DetailViewModel
    @State  var favouriteButton: Bool = false
    @State  var showSheet = false
    let gridItem = GridItem(.adaptive(minimum: 200))
    @State var prodId = 0
    var body: some View {
        
        VStack{
            HStack (alignment: .top, spacing: 20) {
                LazyVGrid (columns: [gridItem], content: {
                    ForEach (itemsModel.moreLike.right) { item in
                        scrollView(model: item)
                            .onTapGesture(perform: {
                                prodId = item.id!
                                showSheet = true
                            })
                            .padding(.bottom)
                    }
                })
                LazyVGrid (columns: [gridItem], content: {
                    ForEach (itemsModel.moreLike.left) { item in
                        scrollView(model: item)
                            .onTapGesture(perform: {
                                prodId = item.id!
                                showSheet = true
                            })
                            .padding(.bottom)
                    }
                } )
            }.padding()
            if showSheet {
                NavigationLink(destination: DetailView(produId: prodId), isActive: $showSheet) {}
            }
        }
    }
    func scrollView(model: MoreLikeModel) -> some View{
        ZStack(alignment: .topTrailing) {
            VStack {
                WebImage(url: URL(string: "http://18.189.232.65/mobile/" + model.imageUrl!))
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                
                HStack {
                    Text(model.name ?? "No name")
                        .lineLimit(1)
                        .padding(.leading,5)
                    Spacer()
                }
                HStack {
                    Text(Double(model.price!)?.kmFormatted ?? "No Money").padding(.leading,5)
                        .lineLimit(1)
                    Text(model.currencyType ?? "").font(.headline)
                    Spacer()
                    HStack(spacing: 0){
                        Image("Vector").frame(width: 8, height: 10)
                        Text("2.7 km")
                            .font(.system(size: 15))
                            .foregroundColor(.blue)
                            .frame(width: 50, height: 18)
                    }.padding(.trailing,10)
                }.padding(.bottom,6)
            }
            .background(RoundedRectangle(cornerRadius: 20)
                            .fill(Color.yellow.opacity(0.4)))
            Button(action: {
                favouriteButton.toggle()
            }, label: {
                Image(systemName: "heart.fill")
                    .foregroundColor(favouriteButton ? Color(.red) : Color(.white))
                    .frame(width: 24, height: 24)
                    .padding(.top,3).padding(.trailing,3)
            })
        }
    }
}

struct MoreLikeThis_Previews: PreviewProvider {
    static var previews: some View {
        MoreLikeThis()
    }
}
