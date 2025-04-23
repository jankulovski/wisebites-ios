import SwiftUI
import PhotosUI // For Photo Picker

struct CaptureUploadView: View {

    enum AnalysisType: String, CaseIterable, Identifiable {
        case dish = "Dish"
        case ingredients = "Ingredients"
        var id: String { self.rawValue }
    }

    // State for UI elements
    @State private var selectedAnalysisType: AnalysisType = .dish
    @State private var hintText: String = ""
    @State private var showPhotoPicker = false
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var isLoading = false // Mock loading state

    // Environment for dismissing the view
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 25) {

                // Image Preview / Selection Area
                imageSelectionArea
                    .padding(.top)

                // Analysis Type Picker
                Picker("Analyze as", selection: $selectedAnalysisType) {
                    ForEach(AnalysisType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // Hint Text Field
                VStack(alignment: .leading) {
                    Text("Optional Hint")
                        .font(.headline)
                    TextEditor(text: $hintText) // Use TextEditor for multi-line potential
                         .frame(height: 100)
                         .overlay(
                             RoundedRectangle(cornerRadius: 8)
                                 .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                         )
                         .accessibilityLabel("Optional hint for analysis")
                    Text("e.g., 'focus on the pasta dish', 'what can I make with these items?'")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                // Submit Button
                Button(action: submitForAnalysis) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Analyze Image")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.horizontal)
                .disabled(selectedImageData == nil || isLoading) // Disable if no image or loading
                .padding(.bottom)

            }
        }
        .navigationTitle("Capture or Upload")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea())
        .sheet(isPresented: $showPhotoPicker) {
            PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                // The sheet content itself doesn't need much, the picker handles it.
                 // You might add instructions here if needed.
            }
            .onChange(of: selectedPhotoItem) { newItem in
                 Task {
                     // Retrieve selected asset in the form of Data
                      if let data = try? await newItem?.loadTransferable(type: Data.self) {
                          selectedImageData = data
                      }
                 }
             }
        }
    }

    // MARK: - Image Selection Area View
    private var imageSelectionArea: some View {
        Group {
            if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 300) // Limit preview height
                    .cornerRadius(10)
                    .overlay(alignment: .topTrailing) {
                        Button {
                            // Clear selection
                            self.selectedPhotoItem = nil
                            self.selectedImageData = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .background(Color.white.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .padding(8)
                    }
                    .onTapGesture {
                        showPhotoPicker = true // Allow re-selecting
                    }
            } else {
                // Placeholder / Button to select image
                Button {
                    showPhotoPicker = true
                } label: {
                    VStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.largeTitle)
                            .padding(.bottom, 5)
                        Text("Tap to Select Photo")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .background(Color(uiColor: .secondarySystemGroupedBackground))
                    .cornerRadius(10)
                    .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
        }
    }

    // MARK: - Actions
    private func submitForAnalysis() {
        guard selectedImageData != nil else { return }

        print("Submitting for analysis...")
        print("Type: \(selectedAnalysisType.rawValue)")
        print("Hint: \(hintText)")
        print("Image Data Size: \(selectedImageData?.count ?? 0) bytes")

        // Simulate network request/analysis
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isLoading = false
            print("Analysis complete (mock).")
            // TODO: Handle analysis result - navigate to RecipeDetailView or show results
            
            // For now, just dismiss the view as a placeholder action
            dismiss()
        }
    }
}

#Preview {
    NavigationStack {
        CaptureUploadView()
    }
    .tint(Color.green)
} 