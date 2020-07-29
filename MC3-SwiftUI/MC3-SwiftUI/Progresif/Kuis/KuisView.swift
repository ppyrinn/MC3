//
//  KuisView.swift
//  MC3-SwiftUI
//
//  Created by Poppy on 21/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI
import Combine
import Speech


struct KuisView: View {
//    @Binding var showKuisView: Bool
    
    var namaMurid = "Agus"
    var levelMurid = 2
    var soalKuis = SoalKuis()
    
    @State var soalEjaan = SoalEjaan()
    @State var resultString : String = ""
    @State var isRecording : Bool = false
    @State var showEjaan : Bool = false
    @State var idxEjaan : Int = 0
    @State var soal : String = "Lari"
    @State var ejaan = ["la","ri"]
    @State var isAnswered : Bool = false
    @State var answeredEjaan = Ejaan()
    @State var soalIdx = 0
    @State var tempCorrect = false
    @State var finalVerdict = false
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var soundClassification = SoundClassification()
    
    func showResultLevel2(resultString:String, soal:String, soalEjaan : SoalEjaan) {
        if(resultString.uppercased() == soal.uppercased()){
            answeredEjaan.sukuKata = ejaan
            for _ in ejaan{
                answeredEjaan.isCorrect.append(true)
            }
            finalVerdict = true
        }
        else if(resultString.count == soal.count){
            soalIdx = 0
            for eja in ejaan{
                tempCorrect = false
                idxEjaan = 0
                for alfabet in eja{
                    if(alfabet.uppercased() == resultString[resultString.index(resultString.startIndex, offsetBy: soalIdx)].uppercased()){
                        print("bener di \(alfabet)")
                        if(idxEjaan == 0){
                            tempCorrect = true
                        }else{
                            if(!tempCorrect){
                                tempCorrect = false
                            }else{
                                tempCorrect = true
                            }
                        }
                    }else{
                        print("salah di \(alfabet)")
                        if(idxEjaan == 0){
                            tempCorrect = false
                        }else{
                            if(tempCorrect){
                                tempCorrect = false
                            }else{
                                tempCorrect = true
                            }
                        }
                    }
                    soalIdx+=1
                    idxEjaan+=1
                }
                answeredEjaan.sukuKata.append(eja)
                answeredEjaan.isCorrect.append(tempCorrect)
            }
        }
        else{
            answeredEjaan.sukuKata = ejaan
            for _ in ejaan{
                answeredEjaan.isCorrect.append(false)
            }
            finalVerdict = false
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack{
                Rectangle()
                    .foregroundColor(Color(red: 1.00, green: 0.81, blue: 0.42))
                RoundedRectangle(cornerRadius: 80)
                    .foregroundColor(.white)
                    .frame(height: screenHeight)
                    .position(x: screenWidth / 2, y: screenHeight / 3)
                VStack{
                    HStack{
                        Button(action: {
//                            self.showKuisView = false
                        }) {
                            HStack{
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                                Text("Keluar Kuis")
                                    .font(.custom("SF Compact Text", size: 17))
                                    .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                            }
                            .accessibility(label: Text("Keluar kuis"))
                            
                        }
                        Spacer()
                        Text(namaMurid)
                            .fontWeight(.bold)
                            .font(.system(size: 17))
                            .font(.custom("SF Compact Text", size: 17))
                            .foregroundColor(.black)
                        .accessibility(label: Text(namaMurid))
                        Spacer()
                        Button(action: {
                            //
                        }) {
                            HStack{
                                Text("Lewati Murid")
                                    .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                                    .fontWeight(.bold)
                                    .font(.system(size: 17))
                                    .font(.custom("SF Compact Text", size: 17))
                                .accessibility(label: Text("Lewati murid"))
                            }
                            
                        }
                    }
                    .padding(20)
                    
                    Spacer()
                    
                    Image(soal.lowercased()).padding(.top, -90)
                    
                    Text(soal.uppercased())
                        .fontWeight(.bold)
                        .font(.system(size: 57))
                        .font(.custom("SF Compact Text", size: 57))
                        .foregroundColor(.black)
                    
                    if(self.showEjaan == true){
                        if(self.finalVerdict){
                            HStack{
                                ForEach(ejaan, id :\.self){ eja in
                                    Text("\(eja) •")
                                        .font(.system(size: 28))
                                        .font(.custom("SF Compact Text", size: 28))
                                        .foregroundColor(.black)
                                        .accessibility(label: Text(self.soal.lowercased()))
                                }
                                Image("ceklis").resizable()
                                    .frame(width: 28, height: 28, alignment: .center)
                                    .opacity(1)
                                    .accessibility(label: Text(soal.lowercased()))
                            }
                            .padding(.top, -20)
                        }else{
                            HStack{
                                ForEach(answeredEjaan.sukuKata.indices){ i in
                                    if(self.answeredEjaan.isCorrect[i]){
                                        Text("\(self.answeredEjaan.sukuKata[i]) •")
                                        .font(.system(size: 28))
                                        .font(.custom("SF Compact Text", size: 28))
                                        .foregroundColor(.black)
                                        .accessibility(label: Text(self.soal.lowercased()))
                                    }else{
                                        Text("\(self.answeredEjaan.sukuKata[i]) •")
                                        .font(.system(size: 28))
                                        .font(.custom("SF Compact Text", size: 28))
                                        .foregroundColor(.red)
                                        .accessibility(label: Text(self.soal.lowercased()))
                                    }
                                }
                                Image("ceklis").resizable()
                                    .frame(width: 28, height: 28, alignment: .center)
                                    .opacity(0)
                            }
                            .padding(.top, -20)
                        }
                    }else{
                        HStack{
                            
                            Text(" ")
                                .font(.system(size: 28))
                                .font(.custom("SF Compact Text", size: 28))
                                .foregroundColor(.black)
                            
                            Image("ceklis").resizable()
                                .frame(width: 28, height: 28, alignment: .center)
                                .opacity(0)
                        }
                        .padding(.top, -20)
                    }
                    
                    if(self.isAnswered == false){
                        if(self.isRecording == true){
                            Button(action: {
                                self.resultString =  self.soundClassification.stopRecording()
                                self.isRecording = false
                                self.showEjaan = true
                                self.isAnswered = true
                                self.showResultLevel2(resultString: self.resultString, soal: self.soal, soalEjaan: self.soalEjaan)
                            }){
                                Image("stop-button")
                            }
                            .accessibility(label: Text("Hentikan Rekaman"))
                        }else{
                            Button(action: {
                                
                                self.soundClassification.recordAndRecognizeSpeech()
                                self.isRecording = true
                                self.showEjaan = false
                                self.answeredEjaan = Ejaan()
                                self.finalVerdict = false
                            }){
                                Image("record-button")
                            }
                            .accessibility(label: Text("Mulai Rekam"))
                            
                        }
                    }else{
                        Button(action: {
                            self.isAnswered = false
                            self.soalEjaan = self.soalKuis.randomizeSoalStruct(level: 2)
                            self.soal = self.soalEjaan.soal
                            self.ejaan = self.soalEjaan.ejaan.sukuKata
                            self.showEjaan = false
                        }){
                            Image("ejaanselanjutnya-button")
                        }
                        .accessibility(label: Text("Ejaan Selanjutnya"))
                    }
                    
                    Spacer()
                }
            }
        }
    }
}


struct KuisView_Previews: PreviewProvider {
    @State static var showKuisView = true
    
    static var previews: some View {
//        KuisView(showKuisView: $showKuisView)
        KuisView()
    }
}

extension KuisView: SoundClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            print("Recognition: \(identifier)\nConfidence \(confidence)")
        }
    }
}

extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}
