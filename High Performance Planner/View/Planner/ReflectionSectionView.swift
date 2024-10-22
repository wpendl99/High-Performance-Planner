//
//  TextSection.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/14/24.
//

import SwiftUI

struct ReflectionQuestionView: View {
    @Binding var question: EditableQuestion<ReflectionQuestion>

    var body: some View {
        VStack(alignment: .leading) {
            Text(question.question.question)
                .foregroundStyle(.secondary)
            TextField(question.question.placeholder, text: $question.question.answer, axis: .vertical)
        }
        .padding(.vertical, 5)
    }
}

struct ReflectionSectionView: View {
    var header: String
    @Binding var questions: [EditableQuestion<ReflectionQuestion>]
    
    var body: some View {
        Section(header: Text(header)) {
            VStack(alignment: .leading) {
                ForEach(questions.indices, id:\.self) { index in
                    ReflectionQuestionView(question: $questions[index])
                    
                    // Add a divider unless it's the last item
                    if index < questions.count - 1 {
                        Divider()
                    }
                }
            }
        }
    }
}
