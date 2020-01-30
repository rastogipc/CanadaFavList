//
//  ListCell.swift
//  CanadaFavList
//
//  Created by Prakash Rastogi on 27/01/20.
//  Copyright © 2020 Prakash Rastogi. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListCell: View {
    
    var cellDataObj: ListDataModel    
    
    var body: some View {
        
        VStack (alignment: .leading) {
            HStack {
                WebImage(url: URL(string: cellDataObj.imageRef!))
                .onSuccess { image, cacheType in
                    // Success
                }
                .resizable() // Resizable like SwiftUI.Image
                .placeholder(Image(systemName: "photo")) // Placeholder Image
                // Supports ViewBuilder as well
                .indicator(.activity) // Activity Indicator
                .animation(.easeInOut(duration: 0.5)) // Animation Duration
                .transition(.fade) // Fade Transition
                .scaledToFit()
                .frame(width: 50.0, height: 50.0, alignment: .center)
                Text(cellDataObj.title!).font(.title)
            }
            Text(cellDataObj.description!)
        }
        .padding()
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            ForEach (cellDataList) { cellDataObj in
                ListCell(cellDataObj: cellDataObj)
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
