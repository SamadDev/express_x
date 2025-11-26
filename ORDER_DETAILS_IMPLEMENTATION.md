# Order Details & Status Management Implementation

## Overview
Complete implementation of order details screen with full information display, status management, and approve/reject functionality with payment method selection.

## API Endpoints

### 1. GET Order Details
- **Endpoint**: `{{URL}}/orders/{orderId}`
- **Method**: GET
- **Headers**: Authorization: Bearer {token}
- **Response**:
```json
{
  "data": {
    "id": "21",
    "order_number": "ORD-00-19",
    "local_shipping": "$ 1",
    "international_shipping": "$ 2",
    "tax": "(3%) - $ 0.96",
    "customs_clearance": "$ 3",
    "service_fee": "$ 4",
    "subtotal": "$ 32",
    "total_amount": "$ 42.96",
    "note": null,
    "created_at": "2025-11-25 08:35 PM",
    "status": {
      "id": "25",
      "name": "customer approval",
      "color": "#6f42c1"
    },
    "status_changable": false,
    "items": [
      {
        "id": "59",
        "product_name": "https://www.amazon.com/",
        "link": "https://www.amazon.com/",
        "product_price": "$ 16",
        "quantity": 2,
        "store": null,
        "image": "http://localhost:8000/attachments/order_items/59/...",
        "color": "rug",
        "size": "XL",
        "note": "Order from"
      }
    ]
  },
  "message": "Order retrieved successfully."
}
```

### 2. GET Payment Methods
- **Endpoint**: `{{URL}}/payment-methods`
- **Method**: GET
- **Headers**: Authorization: Bearer {token}
- **Response**: List of payment methods with id, name, description, icon

### 3. Approve Order
- **Endpoint**: `{{URL}}/orders/{orderId}/change-status?status=approved&payment_method={paymentMethodId}`
- **Method**: GET
- **Headers**: Authorization: Bearer {token}
- **Example**: `/orders/21/change-status?status=approved&payment_method=2`

### 4. Reject Order
- **Endpoint**: `{{URL}}/orders/{orderId}/change-status?status=rejected&rejected_reason={reason}`
- **Method**: GET
- **Headers**: Authorization: Bearer {token}
- **Example**: `/orders/21/change-status?status=rejected&rejected_reason=test`

## Implementation Details

### Files Created

#### 1. Order Detail Model
**File**: `lib/features/Home/data/model/order_detail_model.dart`

Classes:
- `OrderDetailModel`: Main order details with all fields
- `OrderStatus`: Status object with id, name, color
- `OrderItem`: Individual order item with product details

#### 2. Payment Method Model
**File**: `lib/features/Order/data/model/payment_method_model.dart`
- Simple model for payment methods

#### 3. Order Repository
**File**: `lib/features/Order/data/repository/order_repository.dart`

Methods:
- `getOrderDetails(orderId)`: Fetch full order details
- `getPaymentMethods()`: Fetch available payment methods
- `approveOrder(orderId, paymentMethodId)`: Approve order with payment
- `rejectOrder(orderId, rejectedReason)`: Reject order with reason

#### 4. New Order Details Screen
**File**: `lib/features/Order/view/new_order_details_screen.dart`

Features:
- Fetches and displays complete order details
- Shows order header with number, date, and status
- Displays all order items with images and details
- Shows comprehensive order summary:
  - Subtotal
  - Local Shipping
  - International Shipping
  - Tax
  - Customs Clearance
  - Service Fee
  - Total Amount
- Shows order note if exists
- Conditionally shows Approve/Reject buttons based on `status_changable`

#### 5. Payment Methods Screen
**File**: `lib/features/Order/view/payment_methods_screen.dart`

Features:
- Displays all available payment methods
- Radio button selection
- Approve order button
- Returns to order details after approval

### Files Modified

#### Updated Order History Screen
**File**: `lib/features/Order/view/order_history_screen.dart`
- Changed to use `NewOrderDetailsScreen` instead of old one
- Passes `orderId` for fetching complete details

## Features

### Order Details Display

✅ **Order Header**
- Order number
- Creation date/time
- Status badge with dynamic color

✅ **Order Items List**
- Product image
- Product name
- Link
- Price per item
- Quantity
- Store name
- Color & Size attributes
- Item-specific notes

✅ **Order Summary**
- Subtotal
- Local Shipping
- International Shipping
- Tax (with percentage)
- Customs Clearance
- Service Fee
- **Total Amount** (highlighted)

✅ **Order Note**
- Displayed in separate card if exists

### Status Management

✅ **Conditional Actions**
- Approve/Reject buttons only show when `status_changable: true`
- Buttons hidden when order status cannot be changed

✅ **Approve Flow**
1. User taps "Approve Order"
2. Navigate to Payment Methods screen
3. User selects payment method
4. Tap "Approve Order" button
5. API call with selected payment method
6. Return to order details
7. Order details reload automatically

✅ **Reject Flow**
1. User taps "Reject Order"
2. Dialog appears requesting rejection reason
3. User enters reason (required)
4. Tap "Reject" button
5. API call with rejection reason
6. Order details reload automatically

### UI/UX Features

✅ **Loading States**
- Shimmer loading for initial load
- Button loading indicators
- Full-screen loading for operations

✅ **Error Handling**
- Error states with retry button
- Toast notifications for success/error
- Validation for rejection reason
- Validation for payment method selection

✅ **Visual Feedback**
- Status colors from API
- Success/error snackbars
- Highlighted selected payment method
- Disabled buttons during operations

## Usage Flow

### Viewing Order Details

```dart
// Navigate from order list
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => NewOrderDetailsScreen(orderId: '21'),
  ),
);
```

### User Journey

1. **View Orders** → Tap order card
2. **See Details** → Full order information displayed
3. **Check Status** → If `status_changable` is true:
   - **Option A: Approve**
     - Tap "Approve Order"
     - Select payment method
     - Confirm approval
     - See success message
   - **Option B: Reject**
     - Tap "Reject Order"
     - Enter rejection reason
     - Confirm rejection
     - See success message
4. **Updated Status** → Order details refresh with new status

## Data Structure

### Order Detail Response
```
OrderDetailModel
├── id, orderNumber, createdAt
├── Financial Info
│   ├── subtotal
│   ├── localShipping
│   ├── internationalShipping
│   ├── tax
│   ├── customsClearance
│   ├── serviceFee
│   └── totalAmount
├── status (OrderStatus)
│   ├── id
│   ├── name
│   └── color
├── statusChangable (boolean)
├── note (optional)
└── items[] (OrderItem)
    ├── id, productName, link
    ├── productPrice, quantity
    ├── store, image
    ├── color, size
    └── note
```

## Status Colors

Status badges dynamically parse hex colors from API:
- Format: `#6f42c1`
- Displayed with light background (30% opacity)
- Text in full color

## Error Scenarios Handled

1. **No Authentication**: Shows appropriate error
2. **Network Error**: Displays error with retry button
3. **Invalid Order ID**: Shows error message
4. **No Payment Method Selected**: Warning toast
5. **Empty Rejection Reason**: Warning toast
6. **API Failures**: Error snackbars with messages

## Testing Checklist

- [ ] Order details load correctly
- [ ] All financial fields display properly
- [ ] Order items show with images
- [ ] Status badge shows correct color
- [ ] Approve button navigates to payment methods
- [ ] Payment methods load and selectable
- [ ] Approve API call succeeds
- [ ] Reject dialog appears
- [ ] Reject API call succeeds with reason
- [ ] Order reloads after approve/reject
- [ ] Buttons hidden when status_changable is false
- [ ] Error states display correctly
- [ ] Loading indicators work

## Dependencies

- `http`: API calls
- `cached_network_image`: Product images
- `provider`: State management (for order service)

## Notes

- All API calls require Bearer token
- Order details are fetched fresh each time screen opens
- Approve/Reject operations reload the order details
- Payment method selection is persistent within the flow
- Status colors support hex format with # prefix


