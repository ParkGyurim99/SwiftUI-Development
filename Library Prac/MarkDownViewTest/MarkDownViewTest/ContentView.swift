//
//  ContentView.swift
//  MarkDownViewTest
//
//  Created by Park Gyurim on 2022/03/29.
//

import SwiftUI
import MarkdownView
import MarkdownUI

struct ContentView: View {
    @State var seeMore = false
    
//    let source = "## Hello, this is SwoYamBhu Pyeongtaek!\n\n**SwoYamBhu**, ***an Indian and Nepalese restaurant*** tailored to Koreans' tastes, has newly opened **in front of Pyeongtaek station**.\n\nThis is a place **run by Nepalese locals**, where you can experience the unique culture and deep taste of food from India and Nepal, and **experience Indian style interior!**. \n\n---\n\n### Menu\n\n* **Curry**, where you can feel the deep taste of curry, is a dish tailored to the taste of Koreans and can be tasted at an affordable price. \n\n* Chewy **tandoori chicken** grilled in a brazier is also excellent when wrapped in Indian food.\n\n#### You can also meet a variety of Indian and Nepalese specialty dishes. \n\n---\n\n#### I hope you can experience India and Nepal's unique culture and food comfortably in SwoYamBhu!\n\n> **Running Hour** <br>\n> **Everyday** 11:00 - 22:00\n"
    
    let source = "## Warm greeting from Lily Piercing!\n\nWe specialize in piercing and it is located **near PyeongTaek Station.**\n\nWe're trying to learn more and develop with more than 10 years of experience.\n\n#### We are doing our best to satisfy those who want to get piercings!\n\n---\n\n|Part|Price|\n|:-----:|:----:|\n|Ear Lobe | 5,000 won|\n|Cartilage| 8,000 won|\n|Special Parts| 15,000 won ~ 25,000 won|\n|Lip, Nose, Eyebrows|30,000 won|\n\n\n#### If you have any inflammation or pain after piercing it, please visit our store.\n\nWe will check the condition for free and take care of it. (only for our store products)\n\n---\n\n#### Always, we're hygienically and pay attention to safety!\n\n* We are not doing service for dangerous or sexual parts such as tongue, chest(nipple), reproductive organs instruments, and dermis.\n\n* Minors can also wear piercings after obtaining consent from their parents or guardians (visit together or on the phone for agreement.).\n\n* Minors cannot get it without the consent of their guardians.\n\n### Welcome!\n\n> **Running Hour** <br>\n> **Monday** off <br>\n> **Tuesday - Saturday** 11:00 - 21:00 <br>\n> **Sunday** 11:00 - 20:00\n\nInstagram : [@lilypiercing_pyeongtaek](https://www.instagram.com/lilypiercing_pyeongtaek/)"
    
    var body: some View {
        ScrollView {
            Markdown(source
                        .replacingOccurrences(of: "<br>", with: "\n")
                        .replacingOccurrences(of: "<p>", with: "")
                        .replacingOccurrences(of: "</p>", with: "\n")
            ).onTapGesture { seeMore.toggle() }
            .lineLimit(seeMore ? .max : 3)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
