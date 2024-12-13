/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

/*
 This is the Panda model object. It’s structured to mirror the JSON data returned from this URL.
 */
struct Panda: Codable {
    /*
     Each panda contains a text description as well as an imageUrl, which points to a panda image.
     This is the data you’ll use to download a panda image.
     */
    var description: String
    var imageUrl: URL?
    
    static let defaultPanda = Panda(description: "Cute Panda",
                                    imageUrl: URL(string: "https://assets.devpubs.apple.com/playgrounds/_assets/pandas/pandaBuggingOut.jpg"))
}

/*
 A PandaCollection is composed of an array of Panda model objects. This mirrors the format of the JSON data,
 which enables you to easily decode URLs and descriptive text from your JSON data into a PandaCollection instance.
 */
struct PandaCollection: Codable {
    var sample: [Panda]
}
