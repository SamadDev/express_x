# Store Shopping Bag Feature

## Overview
This feature allows users to browse online stores (Amazon, eBay, Zara) within the app using a webview, add products to a shopping bag with product name and photo, and save them locally for later reference.

## Features Implemented

### 1. Store List Screen (`lib/Screens/Store/store_list_screen.dart`)
- Displays available stores (Amazon, eBay, Zara)
- Shows store logo, name, and description
- Shopping bag icon with item count badge in app bar
- Tap any store to open in webview

### 2. Store WebView Screen (`lib/Screens/Store/store_webview.dart`)
- Opens the selected store in an in-app webview
- **Floating "Add to Bag" button** - Pink button at bottom right
- Shopping bag icon with item count badge in app bar
- Navigation controls (back, refresh, forward)
- Loading indicator while page loads

### 3. Add to Bag Dialog (`lib/Screens/Store/add_to_bag_dialog.dart`)
- **Product Name field** - Text input for product name
- **Product Photo picker** - Tap to select image from gallery
- Beautiful dialog UI with green success icon
- Cancel and Add buttons
- Form validation (product name required)
- Shows success/error messages

### 4. Bag Screen (`lib/Screens/Store/bag_screen.dart`)
- Displays all saved products
- Shows product name, photo, store name, date added
- Each item shows mock price ($29.99)
- Total price calculation
- Remove individual items
- Clear all items
- Empty state when no items
- Checkout button (demo only)

### 5. Bag Service (`lib/Services/Bag/bag_service.dart`)
- **Local Storage**: Uses SharedPreferences to persist data
- Saves bag items across app restarts
- Manages add/remove/clear operations
- Notifies UI of changes using ChangeNotifier
- Stores product name, image path, store name, and timestamp

## How to Use

### For Users:
1. **Browse Stores**: 
   - Open the Store List Screen
   - Tap on any store (Amazon, eBay, or Zara)

2. **Add Products**:
   - Browse the store in the webview
   - When you find a product you like, tap the **pink "Add to Bag" button** (bottom right)
   - Enter the product name
   - Tap the image area to select a product photo from your gallery
   - Tap "Add to Bag" to save

3. **View Your Bag**:
   - Tap the shopping bag icon in the app bar (shows item count)
   - See all your saved products
   - Remove items or clear all

4. **Data Persistence**:
   - All items are saved locally
   - Items remain even after closing the app
   - Images are stored on device

## Technical Details

### Architecture:
- **State Management**: Provider (ChangeNotifier)
- **Local Storage**: SharedPreferences
- **Image Handling**: image_picker package
- **WebView**: flutter_inappwebview package

### Data Flow:
```
User taps store → Opens WebView → Taps "Add to Bag" button → 
Shows Dialog → User enters name & photo → Saves to BagService → 
Stores in SharedPreferences → Updates UI
```

### Storage Format:
```json
{
  "id": "timestamp",
  "name": "Product Name",
  "imagePath": "/path/to/image",
  "storeName": "Amazon",
  "addedAt": "2025-10-09T12:00:00.000Z"
}
```

## File Structure
```
lib/
├── Screens/
│   └── Store/
│       ├── store_list_screen.dart      # List of stores
│       ├── store_webview.dart          # WebView for browsing
│       ├── add_to_bag_dialog.dart      # Add product dialog
│       └── bag_screen.dart             # View saved items
└── Services/
    └── Bag/
        └── bag_service.dart            # Business logic & storage
```

## UI Highlights

### Consistent Design:
- **Primary Color**: Pink (#E91E63) - like Amazon's add to cart
- **White backgrounds** with subtle shadows
- **Rounded corners** (12px border radius)
- **Icon badges** showing item count
- **Smooth animations** and transitions

### User Experience:
- ✅ Clear visual feedback (success/error messages)
- ✅ Loading states
- ✅ Empty states with helpful messages
- ✅ Confirmation dialogs for destructive actions
- ✅ Responsive to screen sizes

## Dependencies
- `flutter_inappwebview: ^6.1.5` - For webview
- `image_picker: ^1.0.7` - For selecting photos
- `shared_preferences: ^2.2.2` - For local storage
- `provider` - For state management

## Future Enhancements (Optional)
- [ ] Add product URL field
- [ ] Add product price field
- [ ] Export bag to order form
- [ ] Share products with others
- [ ] Add product categories/tags
- [ ] Search within bag
- [ ] Sort/filter bag items
- [ ] Add product notes

## Testing Checklist
- [x] Open store in webview
- [x] Add product with name and photo
- [x] Add product with name only (no photo)
- [x] Validate required fields
- [x] View products in bag
- [x] Remove single product
- [x] Clear all products
- [x] Verify data persists after app restart
- [x] Check item count badge updates
- [x] Test with multiple stores

---

**Status**: ✅ Fully Implemented and Working
**Last Updated**: October 9, 2025

