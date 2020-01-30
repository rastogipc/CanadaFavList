//
//  ListTable.swift
//  CanadaFavList
//
//  Created by Prakash Rastogi on 27/01/20.
//  Copyright © 2020 Prakash Rastogi. All rights reserved.
//

import SwiftUI
import Combine

struct ListTable: View {
    
    @ObservedObject var parseObj = ParseData()
    
    var body: some View {
        SwiftyHUDView(isShowing: .constant(self.parseObj.isLoading)) {
            NavigationView {
                List(self.parseObj.feedDataArray)
                { cellObj in
                    NavigationLink(destination: SelCellDetail(cellDataObj: cellObj)) {
                        ListCell(cellDataObj: cellObj)
                    }
                }
                .navigationBarTitle(Text(self.parseObj.feedTitle))
            }
        }
    }
}

struct ListTable_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            ListTable()
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
