/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

/*
 Creating Asynchronous Images
 Step 1
 When you have the JSON data, you can use it to load panda images.
 To accomplish this, compose your LoadableImage view from AsyncImage, a view that loads an image asynchronously.
 */
struct LoadableImage: View {
    /*
     Step 2
     To create an image, LoadableImage needs data about the Panda it’s loading.
     The metadata supplied here includes the image URL and the description.
     */
    var imageMetadata: Panda
    
    var body: some View {
        /*
         Step 3
         Inside the view body, create an AsyncImage and pass in the imageUrl to load the panda image.
         An AsyncImage view loads asynchronously, so you’ll need to show something in its place while the image loads,
         and show something else if image loading fails. You’ll handle all of this logic in the following if statement.
         */
        AsyncImage(url: imageMetadata.imageUrl) { phase in
            /*
             Step 4
             When you create an instance of AsyncImage, SwiftUI provides you with phase data, which updates you on the state of image loading. For example, phase.error provides you with errors that occur, while phase.image provides an image, if available. You can use the phase data to show the appropriate UI based on the phase state.

             Step 5
             Check to see if an image is available. If there is, great — this is the panda image you’ll display
             using the description as the accessibility text.
             */
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .accessibility(hidden: false)
                    .accessibilityLabel(Text(imageMetadata.description))
            /*
             Step 6
             Check to see if any errors occurred while loading the image. If so, you can provide a view
             that tells the user something went wrong.
             */
            }  else if phase.error != nil  {
                VStack {
                    Image("pandaplaceholder")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300)
                    Text("The pandas were all busy.")
                        .font(.title2)
                    Text("Please try again.")
                        .font(.title3)
                }
                
            } else {
                /*
                 Step 7
                 If you haven’t received an image and you don’t have an error, that means the image is loading.
                 To let people know that the image is downloading, use ProgressView to display an animation while the image loads.
                 */
                ProgressView()
            }
        }
    }
}

struct Panda_Previews: PreviewProvider {
    static var previews: some View {
        LoadableImage(imageMetadata: Panda.defaultPanda)
    }
}
