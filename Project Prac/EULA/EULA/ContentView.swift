//
//  ContentView.swift
//  EULA
//
//  Created by Park Gyurim on 2022/05/01.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack(alignment : .leading) {
            VStack(alignment : .leading) {
                Text(UserTermsTextSet.subTitle.rawValue)
                    .font(.callout)
                    .foregroundColor(.gray)
                Text(UserTermsTextSet.title.rawValue)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow) // maintheme
            }.padding(.horizontal)
            .padding(.top)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(UserTermsTextSet.getUserTerms(), id : \.self) {
                        Text($0[0])
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                        Text($0[1])
                    }
                }.font(.system(size : 12))
                .padding(.horizontal)
            }
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.yellow, lineWidth: 2)
                    .frame(width : UIScreen.main.bounds.width * 0.43, height: UIScreen.main.bounds.height * 0.06)
                    .overlay(Text(UserTermsTextSet.Decline.rawValue).foregroundColor(.yellow).fontWeight(.semibold))
                Spacer()
                RoundedRectangle(cornerRadius: 8)
                    .fill(.yellow)
                    .frame(width : UIScreen.main.bounds.width * 0.43, height: UIScreen.main.bounds.height * 0.06)
                    .overlay(Text(UserTermsTextSet.Accept.rawValue).foregroundColor(.white).fontWeight(.semibold))
                Spacer()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum UserTermsTextSet : String {
    case subTitle = "Agreement"
    case title = "Terms of Service"
    
    case Decline
    case Accept
    
    case TermTitle1 = "Bridge Privacy Policies"
    case TermTitle2 = "Use of Personal Information"
    case TermTitle3 = "Types of Personal Information collected"
    case TermTitle4 = "Duration of Data Storage"
    case TermTitle5 = "The way we collect the personal information"
    case TermTitle6 = "Personal information collected during usage of service"
    case TermTitle7 = "Share of Personal Information"
    case TermTitle8 = "Processing of our personal information by proxy"
    
    case TermDescription1 = "Based on the OECD standard privacy policies, Bridge will obey the rule that service provider should follow. We will do our best to protect user’s information and rights and interest. We will use user’s personal information within the scope of notification by below, and do not use it beyond the notification below without the user’s prior consent, or provide or entrust the user’s personal information to the outside.\n"
    case TermDescription2 = "1. To provide service’s basic function or specialized function\n2. To provide sign up process\n3. To provide personal service\n4. To provide various events and advertisements\n5. To block the actions that violate the rules of community use\n6. To fulfill the obligations stipulated in laws and regulations\n"
    case TermDescription3 = "1. Username\n2. Nickname\n3. E-mail address\n4. chat record using the chat in the app\n5. Pictures\n6. Device Information, IP Address, Cookie\n7. Information such as posts and other contents created by users in the process of using the service.\n8. Frequency and duration of user activity\n"
    case TermDescription4 = ""
    case TermDescription5 = "When user consents and puts their personal information while they are using the service.\n"
    case TermDescription6 = "Device information(OS, Phone size, Device id), IP address, Cookie can be created and collected.\n"
    case TermDescription7 = "Bridge doesn’t share personal information that user provided unless user agree to share their  information to third party.\n"
    case TermDescription8 = "1. Amazon Web Services, Inc\n- Amazon Web Service helps Bridge to save the user information.\n- Period of retention and use of personal information: Until user’s withdrawal or termination of contract with AWS.\n\n1. Google Cloud Platform\n- We store our data at Google cloud storage and use Google Analytics to analyze the user data.\n"
    
    static func getUserTerms() -> [[String]] {
        [[UserTermsTextSet.TermTitle1.rawValue, UserTermsTextSet.TermDescription1.rawValue],
            [UserTermsTextSet.TermTitle2.rawValue, UserTermsTextSet.TermDescription2.rawValue],
            [UserTermsTextSet.TermTitle3.rawValue, UserTermsTextSet.TermDescription3.rawValue],
            [UserTermsTextSet.TermTitle4.rawValue, UserTermsTextSet.TermDescription4.rawValue],
            [UserTermsTextSet.TermTitle5.rawValue, UserTermsTextSet.TermDescription5.rawValue],
            [UserTermsTextSet.TermTitle6.rawValue, UserTermsTextSet.TermDescription6.rawValue],
            [UserTermsTextSet.TermTitle7.rawValue, UserTermsTextSet.TermDescription7.rawValue],
            [UserTermsTextSet.TermTitle8.rawValue, UserTermsTextSet.TermDescription8.rawValue]]
    }
}
