//
//  ContentView.swift
//  JoylaUI
//
//  Created by User on 30/10/21.
//
import SwiftUI
import Alamofire
import SDWebImageSwiftUI
struct ContentView: View {
    @StateObject var viewModel = ProductViewModel()
    @State var viewIdex = 0
    let tabBarmagesName = ["house.fill","heart.fill","plus.rectangle.fill","tag.fill","person"]
    var taBarName = ["Home", "Saved", "Add Item", "Offers", "Account"]
    let gridItem = GridItem(.adaptive(minimum: 200))
    @State  var showSheet = false
    @State  var favouriteButton: Bool = false
    @State private var isLoading: Bool = false
    @State private var page = 0
    @State var prodId = 0
    var body: some View {
        NavigationView {
            VStack {
                switch viewIdex {
                case 0:
                    VStack{
                        NavigationBar()
                        Sort()
                        ScrollView {
                            HStack(alignment: .top, spacing: 20) {
                                LazyVGrid(columns: [gridItem], content: {
                                    ForEach(viewModel.products.right ) { item in
                                        VStack{
                                            scrollView(model: item)
                                                .onTapGesture(perform: {
                                                    prodId = item.id
                                                    showSheet = true
                                                })
                                                .padding(.bottom)
                                            if isLoading && viewModel.products.right.isLastItem(item) {
                                                
                                                ProgressView()
                                            }
                                        }
                                        .onAppear{
                                            listItemAppears(item)
                                        }
                                    }
                                })
                                LazyVGrid(columns: [gridItem], content: {
                                    ForEach(viewModel.products.left){item in
                                        VStack{
                                            scrollView(model: item)
                                                .onTapGesture(perform: {
                                                    prodId = item.id
                                                    showSheet = true
                                                })
                                                .padding(.bottom)
                                            if isLoading && viewModel.products.left.isLastItem(item) {
                                                
                                                ProgressView()
                                            }
                                        }.onAppear{
                                            listItemAppears(item)
                                        }
                                    }
                                } )
                            }.padding()
                        }
                    }
                case 1:
                    Color.red
                        .edgesIgnoringSafeArea(.all)
                case 2:
                    Color.yellow
                        .edgesIgnoringSafeArea(.all)
                case 3:
                    Color.gray
                        .edgesIgnoringSafeArea(.all)
                default:
                    Color.blue
                        .edgesIgnoringSafeArea(.all)
                }
                Spacer()
                HStack{
                    ForEach(0..<5) { num in
                        Button(action: {
                            viewIdex = num
                        }, label: {
                            Spacer()
                            VStack(spacing: 3) {
                                Image(systemName: tabBarmagesName[num])
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(viewIdex == num ? Color.blue : Color.gray.opacity(0.5))
                                    .frame(width: 24, height: 24)
                                Text(taBarName[num])
                                    .bold()
                                    .foregroundColor(viewIdex == num ? Color.blue : Color.gray.opacity(0.5))
                                    .font(.system(size: 10))
                                    .frame(width: 56.36, height: 12.71)
                                    .foregroundColor(.black.opacity(0.6))
                                
                            }.frame(width: 56, height: 37)
                            Spacer()
                        })
                    }
                }
                if showSheet {
                    NavigationLink(destination: DetailView(produId: prodId), isActive: $showSheet) {}
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear{
            viewModel.getList()
        }
    }
    func scrollView(model: Product) -> some View{
        
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
//    MARK: Pagenation
    
    private func listItemAppears<Product: Identifiable>(_ item:  Product) {
        if viewModel.products.left.isThresholdItem(offset: 0, item: item) {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.page += 1
                viewModel.getList(page: page)
                print(page)
                
                self.isLoading = false
            }
        } else if viewModel.products.right.isThresholdItem(offset: 0, item: item) {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.page += 1
                viewModel.getList(page: page)
                print(page)
                self.isLoading = false
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NavigationBar: View{
    @State var searchtext = ""
    var body: some View{
        VStack {
            HStack {
                Spacer()
                Image("Logo")
                    .frame(width: 26, height: 26)
                Text("JOYLA")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.gray.opacity(0.6))
                    .frame(width: 20, height: 20)
                    .padding(.leading)
                TextField("Search for anything", text: $searchtext)
                    .frame(height: 35)
            }
            .background(Color.white)
            .cornerRadius(8)
            .padding(.leading).padding(.trailing).padding(.bottom)
        }.background(Color.blue.opacity(0.8))
    }
}
struct Sort: View{
    var body: some View{
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                Image("apps")
                    .frame(width: 32, height: 32)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                Text("Transport")
                    .font(.system(size: 15))
                    .frame(width: 100, height: 32)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                Text("Real Estate")
                    .font(.system(size: 15))
                    .frame(width: 100, height: 32)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                Text("Electronics")
                    .font(.system(size: 15))
                    .frame(width: 100, height: 32)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
            }.padding(.top,7)
        }.padding(.leading)
    }
}



