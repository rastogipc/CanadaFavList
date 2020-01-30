//
//  SelCellDetail.swift
//  CanadaFavList
//
//  Created by Prakash Rastogi on 27/01/20.
//  Copyright © 2020 Prakash Rastogi. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelCellDetail: View {
    
    var cellDataObj: ListDataModel
    
    var body: some View {
        
        VStack () {
            
            WebImage(url: URL(string: cellDataObj.imageRef!))
            .onSuccess { image, cacheType in
                // Success
            }
            .resizable() // Resizable like SwiftUI.Image
            .placeholder(Image(systemName: "photo")) // Placeholder Image
            // Supports ViewBuilder as well
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity) // Activity Indicator
            .animation(.easeInOut(duration: 0.5)) // Animation Duration
            .transition(.fade) // Fade Transition
            .scaledToFit()
                .frame(width: 200.0, height: 200.0, alignment: .center)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            
            VStack(alignment: .leading) {
                Text(cellDataObj.description!)
            }
            .padding()

            Spacer()
            
        }
        
        .navigationBarTitle(Text(cellDataObj.title!))
        
    }
}

struct SelCellDetail_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            SelCellDetail(cellDataObj: cellDataList[0])
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
