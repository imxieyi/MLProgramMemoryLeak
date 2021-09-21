//
//  ContentView.swift
//  MLProgramLeak
//
//  Created by Yi Xie on 2021/9/21.
//

import SwiftUI
import CoreML

struct ContentView: View {
    var body: some View {
        Button("Leak 100KB") {
            let config = MLModelConfiguration()
            config.computeUnits = .all
            let model = try! MLModel(contentsOf: Bundle.main.url(forResource: "Model", withExtension: "mlmodelc")!, configuration: config)
            let array = try! MLMultiArray(shape: [NSNumber(1), NSNumber(100), NSNumber(100), NSNumber(3)], dataType: .float32)
            let inProvider = GenericCMLInput("input_1", input: array)
            _ = try! model.prediction(from: inProvider)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

fileprivate class GenericCMLInput : MLFeatureProvider {
    
    let name: String

    var input: MLMultiArray

    var featureNames: Set<String> {
        get {
            return [name]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == name) {
            return MLFeatureValue(multiArray: input)
        }
        return nil
    }
    
    init(_ name: String, input: MLMultiArray) {
        self.name = name
        self.input = input
    }
}
