//
//  eksplorasiDetil.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 03/08/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct eksplorasiDetil: View {
        @Environment(\.managedObjectContext) var moc
        
        @ObservedObject var eksplorasi: Eksplorasi
        var eksplorasiView: SusunKataView
        
        init(eksplorasi: Eksplorasi, eksplorasiView: SusunKataView) {
            self.eksplorasi = eksplorasi
            self.eksplorasiView = eksplorasiView
        }
        
        var body: some View {
            ZStack{
                Image(self.eksplorasi.isSelected ? "fonik-aktif" : "fonik-default")
                    .resizable()
                .frame(width: 80, height: 80, alignment: .center)

                     
                Text("\(eksplorasi.sukuKata)")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .foregroundColor(.black)
                    .offset(x: 2)
             }
                .onTapGesture {
                    if self.eksplorasiView.queue.count < 5{
                        self.eksplorasi.isSelected = true
                        if self.eksplorasiView.textField == ""{
                            self.eksplorasiView.textField += "\(self.eksplorasi.sukuKata)"
    
                        }else{
                            self.eksplorasiView.textField += " - \(self.eksplorasi.sukuKata)"
                        }
                        self.eksplorasiView.queue.append(self.eksplorasi.sukuKata)
                    }
                 }
            
            .accessibility(label: Text("\(eksplorasi.sukuKata)"))
    }
}

//struct eksplorasiDetil_Previews: PreviewProvider {
//    static var previews: some View {
//        eksplorasiDetil()
//    }
//}
