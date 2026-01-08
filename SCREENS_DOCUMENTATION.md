# VerifyUser - Screens Documentation

Based on the provided images, here are all the screens that need to be implemented:

## Screen Flow Overview

1. **Apply Now Screen** → 2. **OTP Verification** → 3. **PAN/DOB Selection** → 4. **Personal Details** → 5. **Address Details** → 6. **Email Verification** → 7. **Success/Completion**

---

## Detailed Screen Specifications

### 1. Apply Now Screen
**Route:** `/apply-now`
**Description:** Initial screen for loan application
- **Logo:** HDB FINANCIAL SERVICES (red square with "HDB" + blue "FINANCIAL SERVICES" text)
- **Title:** "Apply Now" (large, bold, dark gray)
- **Form Fields:**
  - Mobile Number* (input field with pre-filled number: "9984384097")
  - Checkbox: "I have read and agree to all the Terms & Conditions" (green checkmark)
- **Button:** "GET OTP" (dark blue background, white text, rounded corners)
- **Theme:** White background, centered content

---

### 2. OTP Verification Screen
**Route:** `/otp-verification`
**Description:** Six-digit OTP input with resend timer
- **Logo:** HDB FINANCIAL SERVICES
- **Title:** "OTP Verification" (large, bold)
- **Instruction Text:** "We have sent a six digit code to your mobile number [number]"
- **OTP Input:** Six square input boxes arranged horizontally
- **Resend Timer:** "Resend OTP in [MM:SS]" (countdown timer, clickable link)
- **Note:** "You are just few steps away from getting a Loan. *T&C apply" (small text at bottom)
- **Button:** "Verify & Continue" (purple/blue background, white text)
- **Loading State:** Circular spinner overlay when verifying

---

### 3. PAN or Date of Birth Selection Screen
**Route:** `/pan-dob-selection`
**Description:** User selects verification method
- **Logo:** HDB FINANCIAL SERVICES
- **Title:** "PAN or Date of Birth" (large, bold, black)
- **Radio Buttons:**
  - **PAN Option:**
    - Radio button with "PAN" label
    - Icon: ID card/document with person silhouette (blue/grey)
  - **Date of Birth Option:**
    - Radio button with "Date of Birth" label
    - Icon: Calendar with clock (blue/grey)
- **Conditional Input (when DOB selected):**
  - Label: "DOB*"
  - Input field: "Enter your DOB (DD/MM/YYYY)"
  - Placeholder format: DD/MM/YYYY
- **Checkbox (when DOB selected):** "Willing to use the data for processing your loan application"
- **Button:** "Submit" (dark blue background, white text)
- **Theme:** White background, blue accent for selected radio buttons

---

### 4. Personal Details Form Screen
**Route:** `/personal-details`
**Description:** Form for collecting personal information
- **Logo:** HDB FINANCIAL SERVICES
- **Title:** "Personal Details" (implied)
- **Form Fields:**
  - Full name* (pre-filled: "DHARMENDRA KUMAR CHAUDHARY")
  - PAN number (pre-filled: "AJEPC3578N")
  - Date of Birth (pre-filled: "01/07/1982")
  - Name As Per PAN* (pre-filled: "hariharan")
  - Father Name As Per PAN* (pre-filled: "Chaudhary")
  - Email ID (pre-filled: "rekha.ravi@expleogroup.com")
- **Button:** "Continue" (dark blue/purple background, white text)
- **Theme:** White background, light grey input fields, dark text

---

### 5. Address Details Screen
**Route:** `/address-details`
**Description:** Form for address information
- **Logo:** HDB FINANCIAL SERVICES
- **Title:** "Address details" (large, bold)
- **Form Fields:**
  - Address Line 1* (pre-filled: "VILL ARKHAPUR")
  - Address Line 2* (pre-filled: "PO CHILMA BAZAR")
  - Address Line 3 (pre-filled: "GAUSPUR" or empty)
  - Pincode* (pre-filled: "272301")
  - City* (pre-filled: "BASTI")
  - State* (pre-filled: "UTTAR PRADESH")
- **Buttons:**
  - "Edit" (grey, inactive/secondary)
  - "Continue" (blue, primary action)
- **Loading Overlay:** Blue dialog with "Please wait while we fetch your pincode." and white spinner
- **Theme:** White background, light grey input fields

---

### 6. Edit Address Screen
**Route:** `/edit-address`
**Description:** Document selection for address proof
- **Header:** Back arrow + "Edit Address" title
- **Instruction:** "Choose any one of these documents that has your current address proof."
- **Radio Button Options:**
  - Aadhaar Card (with icon/document representation)
  - (Potentially more options)
- **Button:** "Get Address" (blue background, white text, appears when option selected)
- **Theme:** White background, blue accent for selected state

---

### 7. Email Verification Link Sent Screen
**Route:** `/email-verification-sent`
**Description:** Confirmation that email verification link has been sent
- **Logo:** HDB FINANCIAL SERVICES (implied)
- **Icon:** Large blue envelope icon (closed, flap up)
- **Message Lines:**
  1. "Email verification link has been sent to"
  2. "[email address]" (highlighted/emphasized)
  3. "Please verify the same to get your loan approved."
- **Disclaimer:** "TnC's applicable." (small, centered text)
- **Theme:** White background, blue envelope icon, centered content

---

### 8. Email Verified Successfully Screen
**Route:** `/email-verified`
**Description:** Success confirmation after email verification
- **Breadcrumbs:** "Home > Email verification"
- **Date:** "Tue, 23 Dec 2025" (left side)
- **Success Message:**
  - Large "SUCCESS" text (bold, black)
  - Large green checkmark icon
  - "Email Verified successfully." (smaller text)
- **Theme:** White background, green success indicator

---

### 9. Loading Screen (Countdown)
**Route:** `/loading` (or overlay)
**Description:** Processing/waiting screen with countdown
- **Background:** Dark blue rectangle
- **Spinner:** White circular spinner with number inside (countdown: 59, 51, etc.)
- **Message:** "Please wait! This might take a while." (white text)
- **Theme:** Dark blue background (#1a1a2e or similar), white text and spinner

---

### 10. Error/Loading Screen (Branch Contact)
**Route:** `/error-branch-contact` (or overlay)
**Description:** Error message requiring branch contact
- **Background:** White
- **Spinner:** Light blue circular loading spinner (radiating dashes)
- **Message:** "Kindly contact the nearby branch to clear the overdue amount and then proceed with your application." (blue text)
- **Theme:** White background, blue spinner and text

---

### 11. DigiLocker Sign-in Screen (External/Integration)
**Route:** `/digilocker-signin` (if needed)
**Description:** Integration with DigiLocker for document verification
- **Header:** Indian government emblem + "DigiLocker" logo + "Document Wallet to Empower Citizens"
- **Title:** "Sign In to your account!"
- **Tabs:** "Mobile" (active, blue), "Username", "Aadhaar"
- **Mobile Number Input:** "Enter your registered Mobile Number"
- **Button:** "Next" (green background, white text)
- **Link:** "Do not have an account? Sign Up" (blue)
- **Account Selection:** Radio buttons for multiple accounts (if applicable)
- **Security PIN Input:** "6 digit security PIN*" with eye icon for visibility toggle
- **Link:** "Forgot security PIN?" (blue)
- **Theme:** White background, blue/green accents

---

## Color Scheme Reference

Based on the images:
- **Primary Blue/Purple:** `#732ED4` (or similar - for buttons, selected states)
- **Dark Blue:** For headers, some buttons
- **Red:** HDB logo square outline
- **Green:** Success indicators, some action buttons (DigiLocker)
- **White:** Main background
- **Light Grey:** Input field backgrounds, borders
- **Dark Grey/Black:** Text, labels
- **Dark Blue (Loading):** `#1a1a2e` or similar for loading screens

---

## UI Components Needed

1. **Logo Component:** HDB FINANCIAL SERVICES with red square and blue text
2. **OTP Input:** Six individual input boxes
3. **Countdown Timer:** For OTP resend
4. **Loading Spinner:** Multiple variants (circular, with number, radiating)
5. **Radio Buttons:** Custom styled with icons
6. **Form Input Fields:** With labels and asterisks for required fields
7. **Checkboxes:** Custom styled
8. **Buttons:** Primary (blue/purple), Secondary (grey), Success (green)
9. **Loading Overlay:** Modal-style overlay with spinner
10. **Success Screen:** With checkmark icon
11. **Breadcrumbs:** Navigation breadcrumbs
12. **Back Button:** Arrow icon in header

---

## Navigation Flow

```
Apply Now
  ↓
OTP Verification
  ↓
PAN/DOB Selection
  ↓
Personal Details
  ↓
Address Details
  ↓
Edit Address (optional)
  ↓
Email Verification Sent
  ↓
Email Verified Successfully
```

**Alternative/Error Flows:**
- Loading screens (countdown or spinner)
- Error screens (branch contact required)
- DigiLocker integration (if needed)

---

## Responsive Design Notes

- All screens should be centered with max-width constraint
- Mobile-first approach
- Content adapts to screen size
- Touch-friendly buttons and inputs
- Proper spacing for mobile devices

---

## Next Steps

1. Update `app_colors.dart` to match the exact color scheme from images
2. Create individual screen files for each screen listed above
3. Create reusable UI components (Logo, OTP Input, etc.)
4. Implement navigation flow
5. Add loading states and error handling
6. Test responsive design on mobile and desktop

