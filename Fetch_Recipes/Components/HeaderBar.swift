//
//  ContentView.swift
//  Transition Practice
//
//  Created by Eric Weideman on 10/26/24.
//

import SwiftUI

struct HeaderBar: View {
    
    @State var showSearchBar: Bool = false
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            if showSearchBar {
                ZStack {
                    HStack{
                        
                        TextField("Search Recipes", text: $searchText)
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .padding(7)
                              .padding(.horizontal, 10)
                              .cornerRadius(8)
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                            .animation(.spring(), value: showSearchBar)
                        Button {
                            searchText.removeAll()
                            showSearchBar.toggle()
                        } label: {
                            Image(systemName: "x.circle")
                                .padding(.trailing, 10)
                                .foregroundStyle(Color.black)
                        }
                    }
                    .background(Color(.systemGray6))
                }
                .frame(maxWidth: .infinity, maxHeight: 40)
                .cornerRadius(15)
                .padding(.leading, 10)
                
            }  else {
                Text("Fetch Recipes")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading, 10)
                Spacer()
            }
            Button {
                showSearchBar.toggle()
            } label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .padding()
                    .foregroundStyle(Color.black)
            }
        }
        .animation(.spring(duration: 0.25), value: showSearchBar)
        .cornerRadius(20)
    }
}
