//
//  DetailView.swift
//  JoylaUI
//
//  Created by Firdavs Boltayev on 02/11/21.
//
//@StateObject var viewModel: DetailViewModel
//


import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @Environment(\.presentationMode) var presentation
    @State var showProfileView = false
    init(produId: Int) { // 1277
        _viewModel = StateObject(wrappedValue: DetailViewModel(id: produId))
    }
    var body: some View {
        
        NavigationView{
            ZStack(alignment: .topLeading) {
                
                VStack{
                    ScrollView{
                        VStack{
                            if viewModel.pageProducts == nil {
                                ProgressView()
                            } else {
                                
                                // Image     // Horizontall Scrool
                                imageTop()
                                    .environmentObject(viewModel)
                                
                                // Text
                                VStack(alignment: .leading,spacing:1){
                                    
                                    Text(viewModel.pageProducts?.name ?? "No")
                                        .padding(.top)
                                    HStack(alignment:.bottom){
                                        Text("\(viewModel.pageProducts?.productPrice?.price?.kmFormatted ?? "0")")
                                            .font(.title3)
                                            .bold()
                                        Text(viewModel.pageProducts?.productPrice?.currencyType ?? "")
                                            .font(.subheadline)
                                        Spacer()
                                    }.padding(.top)
                                    HStack{
                                        Text("Today, 14:27")
                                            .font(.footnote)
                                        Spacer()
                                    }
                                    HStack(spacing: 7){
                                        Image("Vector-1").resizable()
                                            .frame(width: 13, height: 15)
                                        Text("1.8 km away")
                                        Spacer()
                                    }.padding(.top).padding(.bottom)
                                    Divider()
                                    
                                    Condition()
                                    
                                    Disription( showProfile: showProfileView).environmentObject(viewModel)
                                    Divider().padding(.top)
                                    
                                    //                                    Divider()
                                    
                                    Text("More Like This").bold()
                                        .padding(.top)
                                    if viewModel.moreLike == [MoreLikeModel]().split() {
                                        Text("NOTHING here")
                                    } else {
                                        MoreLikeThis()
                                            .environmentObject(viewModel)
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width - 20, alignment: .leading)
                                .padding(.top,5)
                            }
                            Spacer()
                        }
                        .navigationBarHidden(true)
                    }.ignoresSafeArea()
                    
                    //   Call Make an Offer
                    Spacer()
                    HStack(spacing: 12){
                        HStack{
                            Spacer()
                            Text("Call")
                                .frame(width: 170, height: 50)
                                .foregroundColor(.blue)
                                .background(Color.blue.opacity(0.3))
                            
                                .cornerRadius(10)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Text("Make an Offer")
                                .frame(width: 170, height: 50)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                            Spacer()
                        }
                    }.padding()
                }
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(
                            Circle()
                                .fill(Color.gray.opacity(0.4))
                        )
                })
                    .padding(.horizontal, 20)
            }
        }
        .navigationBarHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(produId: 7)
    }
}
struct imageTop: View{
    @EnvironmentObject var viewModel: DetailViewModel
    @State var showSheet: Bool = false
    @State var index = 0
    var body: some View{
        ZStack(alignment: .topTrailing){
            
            TabView(selection: $index){
                
                ForEach((0..<(viewModel.pageProducts?.images!.count)!), id:\.self){ index in
                    WebImage(url: URL(string: "http://18.189.232.65/mobile/\((viewModel.pageProducts?.images?[index].url ?? ""))")!)
                        .resizable()
                        .clipped()
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
            .tabViewStyle(.page(indexDisplayMode: .never))
            Button(action: {
                showSheet.toggle()
            }, label: {
                Image(systemName: "heart.fill")
                    .foregroundColor(showSheet ? Color(.red) : Color(.white))
                    .frame(width: 30, height: 30)
                    .background(
                        Circle()
                            .fill(Color.gray.opacity(0.4))
                    )
            })
                .padding(.top,50)
                .padding(.horizontal, 20)
        }
        
        ScrollView(.horizontal){
            HStack(spacing: 20){
                ForEach((0..<(viewModel.pageProducts?.images!.count)!), id: \.self){item in
                    Button(action: {
                        index = item
                    }, label: {
                        VStack(spacing: 5){
                            WebImage(url: URL(string: "http://18.189.232.65/mobile/\((viewModel.pageProducts?.images?[item].url ?? ""))")!)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                            
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: 60, height: 3)
                                .opacity((index == item) ? 1 : 0)
                        }
                    })
                }
            }
            .padding(.leading)
        }
    }
}

struct Condition: View{
    var body: some View{
        VStack{
            HStack{
                Text("Condition:")
                    .fontWeight(.ultraLight)
                Spacer()
                Text("New")
                    .fontWeight(.heavy)
                Spacer()
            }.padding()
            
            Divider()
            HStack{
                Text("Param: New")
                    .padding(.horizontal).padding(.vertical,5)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                Spacer()
                Text("Color: Black")
                    .padding(.horizontal).padding(.vertical,5)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                Spacer()
                Text("Parts: Yes")
                    .padding(.horizontal).padding(.vertical,5)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            HStack{
                Text("Model: MaxSV5")
                    .padding(.horizontal).padding(.vertical,5)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                Text("made of: Bamboo")
                    .padding(.horizontal).padding(.vertical,5)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                Spacer()
            }
        }.padding(.top)
    }
}

struct Disription: View{
    @EnvironmentObject var viewModel: DetailViewModel
    @State var showProfile  = false
    var mapModel = Mapkit()
    @State private var region: MKCoordinateRegion = MKCoordinateRegion()
    @State var pin = PinIteam(coordinate: CLLocationCoordinate2D())
    @State var moreText = true
    var body: some View{
        
        VStack(alignment: .leading){
            HStack{
                Text("Description")
                    .fontWeight(.ultraLight)
                    .font(.footnote)
                    .padding(.top)
                Spacer()
            }
            Divider()
            
            VStack(alignment: .leading, spacing: 2){
                Text(viewModel.pageProducts?.description ?? "")
                    .lineLimit( moreText ? 3: nil)
                Button(action: { self.moreText.toggle()} ) {
                    HStack(spacing:2){
                        Text("Read More").font(.system(size: 15))
                        Image(systemName: moreText ? "chevron.down" : "chevron.up")
                            .font(.system(size: 15))
                    }
                    .padding(.top,0.2)
                }
            }
            Divider()
            Text("Seller Information")
            User
                .environmentObject(viewModel)
            
            Divider()
            Text("Location")
                .padding(.top)
                .foregroundColor(.blue.opacity(0.7))
            HStack{
                VStack{
                    HStack(alignment: .top,spacing: 10){
                        Image("pin_drop")
                            .frame(width: 30, height: 30)
                        VStack{
                            Text(viewModel.pageProducts?.district?.regionName ?? "")
                                .foregroundColor(.white).bold()
                            Text(viewModel.pageProducts?.district?.name ?? "")
                                .foregroundColor(.white).bold()
                        }
                    }
                    HStack(spacing: 10){
                        Image("directions_run")
                            .frame(width: 30, height: 30)
                        Text("1.8 km away")
                            .foregroundColor(.white).bold()
                    }
                }.frame(width: 200, height: 200)
                    .background(Color.blue)
                VStack{
                    NavigationLink(destination: Mapkit().environmentObject(viewModel),
                                   label: {
                        Map(
                            coordinateRegion: $region,
                            showsUserLocation: true,
                            userTrackingMode: nil,
                            annotationItems: [pin]
                        ){item in
                            MapMarker(coordinate: item.coordinate)
                        }
                    })
                }.frame(width: 200, height: 200)
            }
        }
        .onAppear {
            region = MKCoordinateRegion(center: .init(latitude: (viewModel.pageProducts?.lat)!, longitude: (viewModel.pageProducts?.lang)!), latitudinalMeters: 300, longitudinalMeters: 300)
            pin = PinIteam(coordinate: .init(latitude:  (viewModel.pageProducts?.lat)!, longitude: (viewModel.pageProducts?.lang)!))
        }
        if showProfile{
            NavigationLink(destination: ProfileJ(userId: viewModel.pageProducts?.user?.id! ?? 0, userName: viewModel.pageProducts?.user?.firstName ?? ""), isActive: $showProfile) {}
        }
    }
    
    private var User: some View{
        
        HStack(alignment: .top, spacing: 30){
            Circle()
                .foregroundColor(Color("Color"))
                .frame(width: 80, height: 80)
                .overlay(RoundedRectangle(cornerRadius: 70)
                            .stroke(Color.gray, lineWidth: 3))
                .foregroundColor(Color("Color"))
            
            VStack(alignment: .leading, spacing: 3){
                Text(viewModel.pageProducts?.user?.firstName ?? "No Name")
                HStack(spacing: 0){
                    Image("star")
                    Image("star")
                    Image("star")
                    Image("star")
                    Image("star")
                }
                Text("Seller's other items")
            }
            Spacer()
        }.padding(.leading)
            .onTapGesture(perform: {
                showProfile = true
            })
    }
}


