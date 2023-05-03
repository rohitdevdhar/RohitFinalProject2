//
//  SearchView.swift
//  RohitFinalProject2
//
//  Created by Rohit D on 4/29/23.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchString: String
    @State private var isEditing = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.blue)
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Search...", text: $searchString)
            }
            .foregroundColor(.gray)
            .padding()
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchString: .constant(""))
    }
}
