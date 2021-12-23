//
//  Mapkit.swift
//  JoylaUI
//
//  Created by Firdavs Boltayev on 07/11/21.
//

import SwiftUI
import MapKit
struct PinIteam: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
struct Mapkit: View {
    @EnvironmentObject var viewMap: DetailViewModel
    @Environment(\.presentationMode) var presentation
    @State private var region: MKCoordinateRegion = MKCoordinateRegion()
    @State var pin = PinIteam(coordinate: CLLocationCoordinate2D())
    
    var body: some View {
        
        VStack{
            HStack{
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .fill(Color.gray.opacity(0.4))
                                .frame(width: 30, height: 30))
                        .padding(.leading)
                })
                Spacer()
                Text("Map")
                    .bold()
                Spacer()
            }
            Spacer()
            Map(
                coordinateRegion: $region,
                showsUserLocation: true,
                userTrackingMode: nil,
                annotationItems: [pin]
            ){item in
                MapMarker(coordinate: item.coordinate)
            }
        }
        .navigationBarHidden(true)
        .onAppear{
            region = MKCoordinateRegion(center: .init(latitude: (viewMap.pageProducts?.lat)!, longitude: (viewMap.pageProducts?.lang)!), latitudinalMeters: 300, longitudinalMeters: 300)
            pin = PinIteam(coordinate: .init(latitude: (viewMap.pageProducts?.lat)!, longitude: (viewMap.pageProducts?.lang)!))
        }
    }
}

struct Mapkit_Previews: PreviewProvider {
    static var previews: some View {
        Mapkit()
    }
}
