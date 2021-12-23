//
//  ProfileJ.swift
//  JoylaUI
//
//  Created by Firdavs Boltayev on 22/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileJ: View {
    
    // MARK: Offsets...
    @State var offset: CGFloat = 0
    // MARK: Start Offsets...
    @State var startOffset: CGFloat = 0
    // MARK: to move title to center were getting the title Width...
    @State var imageOffset: CGFloat = 0
    @State private var isFlipped = false
    @EnvironmentObject var useritemsModel: DetailViewModel
    @StateObject var model : ProfileviewModel
    @State  var favouriteButton: Bool = false
    let gridItem = GridItem(.adaptive(minimum: 200))
    @State var prodId = 0
    @State  var showSheet = false
    var userName = ""
    init(userId: Int, userName: String) {
        _model = StateObject(wrappedValue: ProfileviewModel(id: userId))
        self.userName = userName
    }
    @Environment(\.presentationMode) var presentation
    var body: some View {
        
        VStack{
            User
                .edgesIgnoringSafeArea(.top)
                .padding(.bottom,-45)
            userProfileItems
        }
        .navigationBarHidden(true)
    }
}

extension ProfileJ{
    private var User: some View {
        
        VStack(spacing:3){
            ZStack(){
                if offset <= 125{
                    VStack{
                        Rectangle()
                            .foregroundColor(Color("Color-1"))
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 4.5) )
                } else {
                    VStack{
                        Rectangle()
                            .foregroundColor(Color("Color-1"))
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 5.5) )
                }
                HStack(alignment: .top){
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.white)
                    })
                    Spacer()
                    VStack(alignment: .center) {
                        Circle()
                            .frame(width: 80, height: 80, alignment: .center)
                            .overlay(RoundedRectangle(cornerRadius: 70).stroke(Color.gray, lineWidth: 5))
                            .foregroundColor(Color("Color"))
                            .padding(.trailing)
                            .offset(x: offset > 0 ? (offset <= 115 ? -offset : -115) : 0)
                        
                        Text(userName )
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .bold()
                            .offset(y: offset > 63 ? (offset <= 125 ? -offset + 63 : -125 + 63) : 0)
                    }
                    Spacer()
                }.padding(.top,20).padding()
            }
            HStack{
                Rectangle()
                    .fill(Color.gray.opacity(0.6))
                    .frame(height: 0.5)
                Text("Items Count")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Rectangle()
                    .fill(Color.gray.opacity(0.6))
                    .frame(height: 0.5)
            }
        }
    }
    private var userProfileItems: some View {
        
        ScrollView {
            HStack(alignment: .top, spacing: 20) {
                LazyVGrid(columns: [gridItem], content: {
                    ForEach(model.profiles.right ) { item in
                        VStack{
                            scrollView(model: item)
                                .onTapGesture(perform: {
                                    prodId = item.id!
                                    showSheet = true
                                })
                                .padding(.bottom)
                        }
                    }
                })
                LazyVGrid(columns: [gridItem], content: {
                    ForEach(model.profiles.left){ item in
                        VStack{
                            scrollView(model: item)
                                .onTapGesture(perform: {
                                    prodId = item.id!
                                    showSheet = true
                                })
                                .padding(.bottom)
                        }
                    }
                } )
            }
            .padding(.horizontal)
            .overlay(
                GeometryReader{ proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    DispatchQueue.main.async {
                        // to get orginal offset
                        // it from 0
                        // just minus start offset...
                        if startOffset == 0 {
                            startOffset = minY
                        }
                        offset = startOffset - minY + 510
                        print(offset)
                    }
                    return Color.clear
                }
                    .frame(width: 0, height: 0), alignment: .top
            )
            if showSheet {
                NavigationLink(destination: DetailView(produId: prodId), isActive: $showSheet) {}
            }
        }
    }
    func scrollView(model: ProfileModel) -> some View {
        
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
                
                    .frame(width: 24, height: 24)
                    .padding(.top,3).padding(.trailing,3)
            }) .foregroundColor(favouriteButton ? Color(.red) : Color(.white))
        }
    }
    
    
}
