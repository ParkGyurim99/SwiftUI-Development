//
//  ContentView.swift
//  coredataPractice
//
//  Created by 박규림 on 2021/02/03.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var showOrderSheet : Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Order.entity(), sortDescriptors: [], predicate: NSPredicate(format: "status != %@",  Status.completed.rawValue))
    
    var orders: FetchedResults<Order>
    var body: some View {
        NavigationView {
            List {
                ForEach(orders) { order in
                    HStack {
                        VStack(alignment : .leading) {
                            Text("\(order.pizzaType) - \(order.numberOfSlices) slices")
                                .font(.headline)
                            Text("Table \(order.tableNumber)")
                                .font(.subheadline)
                        }
                        Spacer()
                        Button {
                            //print("Update order")
                            updateOrder(order : order)
                        } label : {
                            Text(order.orderStatus == .pending ? "Prepare" : "Complete")
                                .foregroundColor(.blue)
                        }
                    }.frame(height : 50)
                }
                //We can’t apply this modifier to Lists. This is why we inserted a ForEach loop inside the List.
                .onDelete {indexSet in
                    for index in indexSet {
                        viewContext.delete(orders[index])
                    }
                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("My Orders")
            .navigationBarItems(trailing:
                Button {
                    print("Open order sheet")
                    showOrderSheet = true
                } label: {
                    Image(systemName: "plus.circle")
                    .imageScale(.large)
                }
            )
            .sheet(isPresented: $showOrderSheet) {
                OrderSheet()
            }
        }
    } // body
    
    func updateOrder(order : Order) {
        let newStatus = order.orderStatus == .pending ? Status.preparing : Status.completed
        viewContext.performAndWait {
            order.orderStatus = newStatus
            try? viewContext.save()
        }
    }
}

struct OrderSheet: View {
    let pizzaTypes = ["Pizza Margherita", "Greek Pizza", "Pizza Supreme", "Pizza California", "New York Pizza"]
    
    @State var selectedPizzaIndex = 0
    @State var numberOfSlices = 1
    @State var tableNumber = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pizza Details")) {
                    Picker(selection: $selectedPizzaIndex, label: Text("Pizza Type")) {
                        ForEach(0 ..< pizzaTypes.count) {
                                Text(self.pizzaTypes[$0]).tag($0)
                        }
                    }
                    
                    Stepper("\(numberOfSlices) Slices", value: $numberOfSlices, in: 1...12)
                }
                
                Section(header: Text("Table")) {
                    TextField("Table Number", text: $tableNumber)
                        .keyboardType(.numberPad)
                }
                
                Button {
                    guard self.tableNumber != "" else {return}
                    
                    let newOrder = Order(context: viewContext)
                    newOrder.pizzaType = self.pizzaTypes[self.selectedPizzaIndex]
                    newOrder.orderStatus = .pending
                    newOrder.tableNumber = self.tableNumber
                    newOrder.numberOfSlices = Int16(self.numberOfSlices)
                    newOrder.id = UUID()
                    do {
                        try viewContext.save()
                        print("Order saved.")
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                } label : {
                    Text("Add Order")
                } // button
            } // form
            .navigationTitle("Add Order")
        } // navigationView
    }
}
