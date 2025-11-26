# Profile API Implementation

## Overview
This document outlines the implementation of profile-related API calls including fetching profile data, uploading profile images, and logout functionality.

## API Endpoints

### 1. GET Profile
- **Endpoint**: `{{URL}}/profile`
- **Method**: GET
- **Headers**: 
  - Authorization: Bearer {token}
  - Content-Type: application/json
  - Accept: application/json
- **Response**:
```json
{
  "data": {
    "id": "1",
    "name": "Ahwan Muhamad Abdullah",
    "email": "admin@demo.com",
    "phone_number": "+9647502748575",
    "image_url": null
  },
  "message": "Profile retreived successfully."
}
```

### 2. POST Upload Profile Image
- **Endpoint**: `{{URL}}/profile`
- **Method**: POST
- **Headers**: 
  - Authorization: Bearer {token}
  - Accept: application/json
- **Body**: multipart/form-data
  - image: [File]
- **Response**: Same as GET Profile

### 3. POST Logout
- **Endpoint**: `{{URL}}/logout`
- **Method**: POST
- **Headers**: 
  - Authorization: Bearer {token}
  - Content-Type: application/json
  - Accept: application/json
- **Response**: Success message

## Implementation Details

### Files Created/Modified

#### 1. Profile Model
**File**: `lib/features/Profile/data/model/profile_model.dart`
- Parses profile data from API response
- Includes getter for user initials
- Handles nullable image URL

#### 2. Profile Repository
**File**: `lib/features/Profile/data/repository/profile_repository.dart`
- `getProfile()`: Fetches profile data from API
- `uploadProfileImage(File)`: Uploads profile image with multipart request
- `logout()`: Calls logout API and clears local storage

#### 3. Profile Service
**File**: `lib/features/Profile/data/service/profile_service.dart`
- ChangeNotifier for state management
- Handles loading states
- Manages profile data
- Provides methods for all profile operations

#### 4. Updated Profile Screen
**File**: `lib/features/Profile/view/profile_screen.dart`
- Fetches profile data on init
- Displays user name, phone, and profile image
- Image upload with camera/gallery options
- Shows loading states and shimmer effects
- Updated logout to call API

#### 5. Updated MyApp
**File**: `lib/features/MyApp/view/my_app.dart`
- Added ProfileService to provider list

## Features

### Profile Display
- ✅ Fetches profile data from API on screen load
- ✅ Displays user name from API response
- ✅ Displays phone number from API response
- ✅ Shows profile image if available, otherwise shows initials
- ✅ Loading state while fetching data

### Image Upload
- ✅ Tap on profile image to upload
- ✅ Choose from gallery option
- ✅ Take photo with camera option
- ✅ Image optimization (max 1024x1024, 85% quality)
- ✅ Upload progress indicator
- ✅ Success/error notifications
- ✅ Auto-refresh profile after upload

### Logout
- ✅ Confirmation dialog
- ✅ Calls logout API with token
- ✅ Clears local storage (token, user data)
- ✅ Resets AuthService state
- ✅ Navigates to splash/login screen
- ✅ Handles API errors gracefully
- ✅ Shows loading indicator during logout

## Usage

### Access Profile Service
```dart
final profileService = Provider.of<ProfileService>(context, listen: false);
```

### Load Profile
```dart
await profileService.loadProfile();
```

### Upload Image
```dart
File imageFile = File('path/to/image.jpg');
bool success = await profileService.uploadProfileImage(imageFile);
```

### Logout
```dart
await profileService.logout();
```

### Access Profile Data
```dart
Consumer<ProfileService>(
  builder: (context, profileService, child) {
    final profile = profileService.profile;
    return Text(profile?.name ?? 'Guest');
  },
)
```

## Error Handling

- All API calls include try-catch blocks
- Errors are stored in service and displayed to users
- Local storage is always cleared on logout, even if API fails
- Image upload failures show error snackbar
- Network errors are logged to console

## Testing

To test the implementation:

1. **Profile Load**: Navigate to Profile screen, verify data loads
2. **Image Upload**: Tap profile image, select image, verify upload
3. **Logout**: Tap logout, confirm, verify navigation to login

## Dependencies

- `http`: For API calls
- `image_picker`: For selecting/capturing images
- `cached_network_image`: For displaying profile images
- `provider`: For state management
- `shared_preferences`: For local storage (via LocalStorage class)

## Notes

- Token is automatically retrieved from LocalStorage
- Profile data is cached in ProfileService
- Image uploads use multipart/form-data
- All endpoints require Bearer token authentication
- Base URL is configured in `lib/core/config/constant/api.dart`


