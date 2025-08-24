//
//  SidebarView.swift
//  Praanya
//
//  Created by Manikanta Nandam on 24/08/25.
//

import SwiftUI
import Utilities

// MARK: - Model

// Represents the status of an inventory item.
// It includes computed properties for display name and associated colors for the UI.
enum ItemStatus: String, CaseIterable {
    case good = "Good"
    case lowStock = "Low Stock"
    case outOfStock = "Out of Stock"
    case expired = "Expired"

    var displayName: String {
        return self.rawValue
    }

    var backgroundColor: Color {
        switch self {
        case .good:
            return Color.goodStatusBackground
        case .lowStock:
            return Color.lowStockStatusBackground
        case .outOfStock:
            return Color.outOfStockStatusBackground
        case .expired:
            return Color.expiredStatusBackground
        }
    }

    var foregroundColor: Color {
        switch self {
        case .good:
            return Color.goodStatusForeground
        case .lowStock:
            return Color.lowStockStatusForeground
        case .outOfStock:
            return Color.outOfStockStatusForeground
        case .expired:
            return Color.expiredStatusForeground
        }
    }
}

// Represents a single item in the inventory.
// Conforms to Identifiable to be used in SwiftUI lists.
struct InventoryItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let quantity: Int
    let unit: String
    let storageLocation: String
    let lastUpdated: Date
    var status: ItemStatus
}

// MARK: - Component Views

enum SidebarTab {
    case dashboard,
         inventory,
         menuPlanner,
         staffManagement,
         shopping,
         foodSafety,
         reports,
         users,
         settings
}

struct SidebarView: View {
    @Binding var selectedTab: SidebarTab

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "circle.grid.2x2.fill")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
                .padding(.bottom, 30)
                .padding(.leading, 20)

            SidebarButton(icon: "square.grid.2x2", title: "Dashboard", tab: .dashboard, selectedTab: $selectedTab)
            SidebarButton(icon: "archivebox", title: "Inventory", tab: .inventory, selectedTab: $selectedTab)
            SidebarButton(icon: "menucard", title: "Menu Planner", tab: .menuPlanner, selectedTab: $selectedTab)
            SidebarButton(icon: "person.2", title: "Staff Management", tab: .staffManagement, selectedTab: $selectedTab)
            SidebarButton(icon: "cart", title: "Shopping", tab: .shopping, selectedTab: $selectedTab)
            SidebarButton(icon: "fork.knife.circle", title: "Food Safety", tab: .foodSafety, selectedTab: $selectedTab)
            SidebarButton(icon: "chart.bar.xaxis", title: "Reports & Analysis", tab: .reports, selectedTab: $selectedTab)
            SidebarButton(icon: "person.3", title: "Users", tab: .users, selectedTab: $selectedTab)
            
            Spacer()
            
            SidebarButton(icon: "gear", title: "Settings", tab: .settings, selectedTab: $selectedTab)
        }
        .padding(.vertical, 30)
        .frame(width: 260)
        .background(Color.white)
    }
}

/*

import Foundation
import Combine

// MARK: - ViewModel

@MainActor
class InventoryViewModel: ObservableObject {
    @Published var inventoryItems: [InventoryItem] = []
    @Published var totalInStock: Int = 0
    @Published var lowStockCount: Int = 0
    @Published var expiredCount: Int = 0
    @Published var outOfStockCount: Int = 0
    @Published var selectedTab: SidebarTab = .inventory

    init() {
        fetchInventoryData()
    }

    // Simulates fetching data from a backend or database.
    func fetchInventoryData() {
        // Sample data matching the UI
        let sampleData: [InventoryItem] = [
            InventoryItem(name: "Tomatoes", imageName: "tomatoes", quantity: 120, unit: "kg", storageLocation: "Freezer", lastUpdated: Date(), status: .good),
            InventoryItem(name: "Chicken Breast", imageName: "chicken", quantity: 40, unit: "kg", storageLocation: "Freezer", lastUpdated: Date(), status: .lowStock),
            InventoryItem(name: "Egg", imageName: "eggs", quantity: 0, unit: "kg", storageLocation: "Freezer 2", lastUpdated: Date(), status: .outOfStock),
            InventoryItem(name: "Pasta", imageName: "pasta", quantity: 40, unit: "kg", storageLocation: "Pantry", lastUpdated: Date(), status: .expired),
            InventoryItem(name: "Oil", imageName: "oil", quantity: 120, unit: "kg", storageLocation: "Pantry", lastUpdated: Date(), status: .good),
            // Duplicating for a scrollable list
            InventoryItem(name: "Tomatoes", imageName: "tomatoes", quantity: 120, unit: "kg", storageLocation: "Freezer", lastUpdated: Date(), status: .good),
            InventoryItem(name: "Chicken Breast", imageName: "chicken", quantity: 40, unit: "kg", storageLocation: "Freezer", lastUpdated: Date(), status: .lowStock),
            InventoryItem(name: "Egg", imageName: "eggs", quantity: 0, unit: "kg", storageLocation: "Freezer 2", lastUpdated: Date(), status: .outOfStock),
            InventoryItem(name: "Pasta", imageName: "pasta", quantity: 40, unit: "kg", storageLocation: "Pantry", lastUpdated: Date(), status: .expired),
            InventoryItem(name: "Oil", imageName: "oil", quantity: 120, unit: "kg", storageLocation: "Pantry", lastUpdated: Date(), status: .good)
        ]
        
        self.inventoryItems = sampleData
        
        // Calculate summary statistics
        self.totalInStock = sampleData.filter { $0.status != .outOfStock }.map { $0.quantity }.reduce(0, +)
        self.lowStockCount = sampleData.filter { $0.status == .lowStock }.count
        self.expiredCount = sampleData.filter { $0.status == .expired }.count
        self.outOfStockCount = sampleData.filter { $0.status == .outOfStock }.count
    }
}

struct InventoryListView: View {
    let items: [InventoryItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            // Header actions
            HStack {
                Text("Inventory Overview")
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search Item", text: .constant(""))
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(8)
                .frame(width: 200)

                Button(action: {}) {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                        Text("Filter")
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2)))
                }
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Item")
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .buttonStyle(PlainButtonStyle())

            // List content
            VStack {
                InventoryListHeader()
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(items) { item in
                            InventoryRowView(item: item)
                        }
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
        }
    }
}


struct InventoryListHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "square").opacity(0) // For alignment
            Text("Item Name").frame(maxWidth: .infinity, alignment: .leading)
            Text("Image").frame(width: 80)
            Text("Quantity").frame(width: 100, alignment: .leading)
            Text("Storage").frame(width: 120, alignment: .leading)
            Text("Last Updated").frame(width: 150, alignment: .leading)
            Text("Status").frame(width: 120, alignment: .center)
            Text("Action").frame(width: 60)
        }
        .font(.system(size: 14, weight: .medium))
        .foregroundColor(.secondaryText)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}


struct InventoryRowView: View {
    let item: InventoryItem
    
    var body: some View {
        HStack {
            Image(systemName: "square")
                .foregroundColor(.gray.opacity(0.3))
            
            Text(item.name)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)

            Image(item.imageName) // Ensure images are in your assets
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .frame(width: 80)
            
            Text("\(item.quantity) \(item.unit)")
                .frame(width: 100, alignment: .leading)
            
            Text(item.storageLocation)
                .frame(width: 120, alignment: .leading)
            
            Text(item.lastUpdated, style: .date) + Text("\n") + Text(item.lastUpdated, style: .time)
                .frame(width: 150, alignment: .leading)
            
            StatusBadgeView(status: item.status)
                .frame(width: 120)
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
            .frame(width: 60)
            .buttonStyle(PlainButtonStyle())
        }
        .font(.system(size: 14))
        .foregroundColor(.primaryText)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct StatusBadgeView: View {
    let status: ItemStatus
    
    var body: some View {
        Text(status.displayName)
            .font(.system(size: 12, weight: .medium))
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background(status.backgroundColor)
            .foregroundColor(status.foregroundColor)
            .cornerRadius(15)
    }
}
*/
