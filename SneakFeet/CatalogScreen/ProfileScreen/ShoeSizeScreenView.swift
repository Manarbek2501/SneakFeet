//
//  ShoeSizeScreenView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI

struct ShoeSizeScreenView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var shoeSize: StoreModal
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(style: .init(lineWidth: 2))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                        .padding(2)
                    TextField("41.5", text: $shoeSize.shoeSizeText)
                        .keyboardType(.decimalPad)
                        .padding()
                }
                .frame(height: 48)
                .padding(.top, 26)
                Spacer()
                CustomButton(title: "Save changes")
                    .padding(.bottom, 16)
                    .onTapGesture {
                        dismiss()
                    }
            }
            .padding([.leading, .trailing], 16)
                .navigationTitle("Shoe Size")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .medium))
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
        }
    }
}

struct ShoeSizeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ShoeSizeScreenView()
            .environmentObject(StoreModal())
    }
}
