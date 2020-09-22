import SwiftUI

struct SampleCardView: View {
    private enum Segment {
        case preview, json
    }

    @State private var segment: Segment = .preview

    let sampleCard: SampleCard

    var body: some View {
        #if os(iOS)
            _body.navigationBarTitleDisplayMode(.inline)
        #else
            _body
        #endif
    }

    private var _body: some View {
        Group {
            switch segment {
            case .preview:
                ScrollView {
                    SampleCardPreview(resourceName: sampleCard.resourceName)
                }
            case .json:
                JSONView(resourceName: sampleCard.resourceName)
            }
        }
        .toolbar {
            Picker(selection: $segment, label: EmptyView()) {
                Text("Preview").tag(Segment.preview)
                Text("JSON").tag(Segment.json)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .navigationTitle(sampleCard.title)
    }
}
