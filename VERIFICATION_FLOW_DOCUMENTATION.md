# 🔐 Verification Flow Documentation

## Overview

The application now includes comprehensive verification flows for PAN, Aadhaar, and DigiLocker with 5-section popups and web redirects to 3rd party services.

---

## ✅ Implemented Features

### 1. **PAN Verification Flow**

**Route:** `/verification-flow/pan?pan=XXXXX1234X`

**5-Step Process:**
1. Enter PAN Details - Provide your PAN number for verification
2. Redirect to Verification Service - Redirected to Income Tax portal
3. Complete Verification - Follow instructions on verification portal
4. Authorize Data Access - Grant permission to fetch PAN details
5. Verification Complete - PAN verified successfully

**Integration:**
- Triggered from PAN/DOB Selection screen when PAN option is selected
- Redirects to: `https://incometaxindia.gov.in/pan/`
- Opens in new browser window/tab

---

### 2. **Aadhaar Verification Flow**

**Route:** `/verification-flow/aadhaar`

**5-Step Process:**
1. Enter Aadhaar Number - Provide your 12-digit Aadhaar number
2. OTP Verification - Enter OTP sent to registered mobile
3. Redirect to UIDAI - Redirected to UIDAI portal
4. Fetch Address - Address fetched from Aadhaar
5. Verification Complete - Address fetched successfully

**Integration:**
- Triggered from Edit Address screen when Aadhaar Card is selected
- Redirects to: `https://uidai.gov.in/`
- Opens in new browser window/tab
- Fetches address details after verification

---

### 3. **DigiLocker Verification Flow**

**Route:** `/verification-flow/digilocker`

**5-Step Process:**
1. Sign In to DigiLocker - Enter mobile number or Aadhaar
2. OTP Verification - Verify with OTP sent to mobile
3. Select Account - Choose DigiLocker account if multiple exist
4. Authorize Access - Grant permission to access documents
5. Fetch Documents - Documents fetched from DigiLocker

**Integration:**
- Triggered from Personal Details screen (DigiLocker card)
- Redirects to: `https://accounts.digitallocker.gov.in/signin/oauth_partner`
- Opens in new browser window/tab
- Fetches documents after connection

---

## 🎯 Verification Popup Widget

**File:** `lib/widgets/verification_popup.dart`

**Features:**
- Shows all 5 verification steps
- Step-by-step progress indicator
- Redirect button to 3rd party service
- Success callback after verification
- Cancel option

**Usage:**
```dart
VerificationPopup(
  title: 'PAN Verification',
  description: 'Verify your PAN number',
  icon: Icons.badge,
  iconColor: AppColors.appButtonColor,
  redirectUrl: 'https://example.com',
  steps: verificationSteps,
  onSuccess: () {
    // Handle success
  },
)
```

---

## 🔄 Application Flow

### Complete User Journey:

1. **Apply Now** (`/apply-now`)
   - Enter mobile number (+91 prefix)
   - Accept Terms & Conditions
   - Get OTP

2. **OTP Verification** (`/otp-verification`)
   - Enter 6-digit OTP
   - Verify and continue

3. **PAN/DOB Selection** (`/pan-dob-selection`)
   - Select PAN or DOB
   - If PAN selected → **PAN Verification Flow** (`/verification-flow/pan`)
   - If DOB selected → Personal Details

4. **Personal Details** (`/personal-details`)
   - Fill personal information
   - Optional: Connect DigiLocker → **DigiLocker Flow** (`/verification-flow/digilocker`)
   - Continue to Address

5. **Address Details** (`/address-details`)
   - View/Edit address
   - Edit button → Edit Address screen

6. **Edit Address** (`/edit-address`)
   - Select Aadhaar Card → **Aadhaar Verification Flow** (`/verification-flow/aadhaar`)
   - Get Address button

7. **Email Verification Sent** (`/email-verification-sent`)
   - Confirmation message

8. **Email Verified** (`/email-verified`)
   - Success screen

---

## 📱 Verification Screens

### PAN Verification Screen
- **File:** `lib/screens/pan_verification_screen.dart`
- **Features:**
  - Displays PAN number
  - Verification popup with 5 steps
  - Web redirect to Income Tax portal
  - Success dialog

### Aadhaar Verification Screen
- **File:** `lib/screens/aadhaar_verification_screen.dart`
- **Features:**
  - Aadhaar card display
  - Verification popup with 5 steps
  - Web redirect to UIDAI portal
  - Address fetching

### DigiLocker Verification Screen
- **File:** `lib/screens/digilocker_verification_screen.dart`
- **Features:**
  - DigiLocker branding
  - Connection popup with 5 steps
  - Web redirect to DigiLocker OAuth
  - Document fetching

### Verification Flow Screen (Unified)
- **File:** `lib/screens/verification_flow_screen.dart`
- **Features:**
  - Unified screen for all verification types
  - Shows 5-step process
  - Step-by-step progress
  - Popup with all steps
  - Web redirect functionality

---

## 🔗 Web Redirects

All verification flows redirect to 3rd party services:

1. **PAN:** `https://incometaxindia.gov.in/pan/`
2. **Aadhaar:** `https://uidai.gov.in/`
3. **DigiLocker:** `https://accounts.digitallocker.gov.in/signin/oauth_partner`

**Implementation:**
```dart
html.window.open(redirectUrl, '_blank');
```

Opens in new browser tab/window for user to complete verification.

---

## 📋 5-Section Popup Structure

Each verification popup shows 5 sections:

### PAN Verification:
1. ✅ Enter PAN Details
2. ✅ Redirect to Verification Service
3. ✅ Complete Verification
4. ✅ Authorize Data Access
5. ✅ Verification Complete

### Aadhaar Verification:
1. ✅ Enter Aadhaar Number
2. ✅ OTP Verification
3. ✅ Redirect to UIDAI
4. ✅ Fetch Address
5. ✅ Verification Complete

### DigiLocker Verification:
1. ✅ Sign In to DigiLocker
2. ✅ OTP Verification
3. ✅ Select Account
4. ✅ Authorize Access
5. ✅ Fetch Documents

---

## 🎨 UI Components

### Verification Popup Widget
- Modal dialog
- Step indicators (numbered circles)
- Progress visualization
- Redirect button
- Cancel option

### Verification Flow Screen
- Step preview
- Progress tracking
- Start verification button
- Processing state
- Success confirmation

---

## 🔄 Integration Points

### PAN Verification:
- **Trigger:** PAN/DOB Selection screen (when PAN selected and submitted)
- **Route:** `/verification-flow/pan?pan=XXXXX1234X`
- **Next:** Personal Details screen

### Aadhaar Verification:
- **Trigger:** Edit Address screen (when Aadhaar Card selected)
- **Route:** `/verification-flow/aadhaar`
- **Next:** Address Details screen (with fetched address)

### DigiLocker Verification:
- **Trigger:** Personal Details screen (DigiLocker card)
- **Route:** `/verification-flow/digilocker`
- **Next:** Personal Details screen (with fetched documents)

---

## 🚀 Usage Examples

### Access PAN Verification:
```dart
context.go('/verification-flow/pan?pan=ABCDE1234F');
```

### Access Aadhaar Verification:
```dart
context.go('/verification-flow/aadhaar');
```

### Access DigiLocker Verification:
```dart
context.go('/verification-flow/digilocker');
```

---

## 📝 Notes

1. **Web Redirects:** All verification services open in new browser tabs
2. **Simulation:** Currently simulates verification (3-second delay)
3. **Production:** Replace with actual API calls and OAuth flows
4. **Error Handling:** Errors redirect to error screen
5. **Back Navigation:** All screens have back buttons

---

## ✅ Testing Checklist

- [ ] PAN verification flow works
- [ ] Aadhaar verification flow works
- [ ] DigiLocker verification flow works
- [ ] 5-step popups display correctly
- [ ] Web redirects open in new tabs
- [ ] Success dialogs appear after verification
- [ ] Navigation flows correctly
- [ ] Back buttons work on all screens

---

**All verification flows are now integrated and ready for use! 🎉**

