//
//  TextSection.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/14/24.
//

import SwiftUI

struct TextQuestion: Identifiable {
    let id: UUID = UUID()
    let question: String
    let placeholder: String
    var response: String = ""  // Adding default value
}

struct TextQuestionView: View {
    @Binding var question: TextQuestion

    var body: some View {
        VStack(alignment: .leading) {
            Text(question.question)
                .foregroundStyle(.secondary)
                .padding(.bottom, 5)
            TextField(question.placeholder, text: $question.response, axis: .vertical)
        }
        .padding(.vertical, 5)
    }
}

struct TextSectionView: View {
    var header: String
    @Binding var questions: [TextQuestion]  // Binding to modify the questions array
    
    var body: some View {
        Section(header: Text(header)) {
            VStack(alignment: .leading) {
                ForEach(questions.indices, id:\.self) { index in
                    TextQuestionView(question: $questions[index])
                    
//                    Add a divider unless it's the last item
                    if index < questions.count - 1 {
                        Divider()
                    }
                }
            }
        }
    }
}

