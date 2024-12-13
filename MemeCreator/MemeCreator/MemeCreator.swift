/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

/*
 Making the Meme Creator
 
 Step 1
 MemeCreator is where you bring everything together to make panda memes. As the top-level view of your app, this is where you’ll
 display the panda image along with tools for adding and editing text.
 */
struct MemeCreator: View, Sendable {
    /*
     Step 2
     In MemeCreatorApp, you passed in a PandaCollectionFetcher as an environment object to the top level view.
     Here, you access that environment object by defining a fetcher variable with the @EnvironmentObject property wrapper.
     */
    @EnvironmentObject var fetcher: PandaCollectionFetcher
    
    @State private var memeText = ""
    @State private var textSize = 60.0
    @State private var textColor = Color.white
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            /*
             Step 5
             In the UI for this view, you’ll use LoadableImage to asynchronously load an image based on the data fetcher’s currentPanda.
             Even if your JSON data hasn’t loaded yet, the app provides a default currentPanda to load as the first image.
             */
            LoadableImage(imageMetadata: fetcher.currentPanda)
            /*
             Step 6
             The image also has a text overlay, which you can add as a modifier.
             This overlay shows the meme text. The text field uses three state variables, memeText, textSize, and textColor
             to dynamically change the data of the text field in response to user editing actions.
             The text field can become focused by passing the @FocusState variable into the .focused modifier.
             */
                .overlay(alignment: .bottom) {
                    TextField(
                        "Meme Text",
                        text: $memeText,
                        prompt: Text("")
                    )
                    .focused($isFocused)
                    .font(.system(size: textSize, weight: .heavy))
                    .shadow(radius: 10)
                    .foregroundColor(textColor)
                    .padding()
                    .multilineTextAlignment(.center)
                }
                .frame(minHeight: 150)
            
            Spacer()
            
            if !memeText.isEmpty {
                /*
                 Step 9
                 Finally, you can modify the state variables textSize and textColor using the slider and color picker at the bottom of the UI.
                 These controls modify the values of those state variables to automatically update the meme text appearance.
                 */
                VStack {
                    HStack {
                        Text("Font Size")
                            .fontWeight(.semibold)
                        Slider(value: $textSize, in: 20...140)
                    }
                    
                    HStack {
                        Text("Font Color")
                            .fontWeight(.semibold)
                        ColorPicker("Font Color", selection: $textColor)
                            .labelsHidden()
                            .frame(width: 124, height: 23, alignment: .leading)
                        Spacer()
                    }
                }
                .padding(.vertical)
                .frame(maxWidth: 325)
                
            }
            
            HStack {
                /*
                 Step 7
                 To change the image, you can push a button that retrieves a random Panda from the PandaCollection and sets it as the currentPanda.
                 Because currentPanda is a published value, the LoadableImage view automatically updates to use the latest currentPanda data whenever it changes.
                 */
                Button {
                    if let randomImage = fetcher.imageData.sample.randomElement() {
                        fetcher.currentPanda = randomImage
                    }
                } label: {
                    VStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.largeTitle)
                            .padding(.bottom, 4)
                        Text("Shuffle Photo")
                    }
                    .frame(maxWidth: 180, maxHeight: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                /*
                 Step 8
                 To add text, use a button that changes the focus state of the text field to true.
                 This automatically inserts the cursor in the text field so you can add text.
                 */
                Button {
                    isFocused = true
                } label: {
                    VStack {
                        Image(systemName: "textformat")
                            .font(.largeTitle)
                            .padding(.bottom, 4)
                        Text("Add Text")
                    }
                    .frame(maxWidth: 180, maxHeight: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxHeight: 180, alignment: .center)
        }
        .padding()
        /*
         Step 3
         Before you start loading panda images, the fetcher needs to retrieve the JSON data.
         The .task modifier defines a task to complete when the view first appears.
         This is where you’ll call fetcher.fetchData() to retrieve the JSON data.
         */
        .task {
            /*
             Step 4
             In the closure, you’ll insert try? await before calling fetcher.fetchData().
             These words correspond to how you defined fetchData() with async throws.
             Because the function is asynchronous, await means that you’ll wait for the results of the async function to return,
             and try followed by a question mark - try? - means you’ll try calling the function, but ignore any error that it throws.
             */
            try? await fetcher.fetchData()
        }
        .navigationTitle("Meme Creator")
    }
}
