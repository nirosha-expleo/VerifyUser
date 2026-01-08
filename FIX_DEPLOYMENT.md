# 🔧 Fix: Only README.md Showing on GitHub Pages

If your GitHub Pages site is only showing the README.md file instead of your Flutter app, the build files weren't deployed correctly.

---

## ✅ Quick Fix: Redeploy Correctly

### Step 1: Make Sure Build Folder Exists

The script needs the `build/web` folder. Let's verify it exists:

```bash
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser

# Check if build folder exists
ls -la build/web/ | head -10
```

You should see files like:
- `index.html`
- `main.dart.js`
- `flutter.js`
- etc.

### Step 2: Run the Fixed Deployment Script

```bash
./DEPLOY_MANUAL.sh
```

The updated script now:
- ✅ Verifies build folder exists before copying
- ✅ Checks that index.html was copied
- ✅ Shows better error messages

---

## ✅ Manual Fix (If Script Still Fails)

If the script doesn't work, deploy manually:

### Step 1: Build the App

```bash
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser

flutter clean
flutter pub get
flutter build web --base-href "/VerifyUser/" --release
```

### Step 2: Verify Build

```bash
ls -la build/web/
```

You should see `index.html`, `main.dart.js`, etc.

### Step 3: Switch to gh-pages Branch

```bash
# Make sure we're on main first
git checkout main

# Switch to gh-pages (or create it)
git checkout gh-pages 2>/dev/null || git checkout --orphan gh-pages

# Remove all existing files
git rm -rf . 2>/dev/null || rm -rf * .[^.]* 2>/dev/null || true
```

### Step 4: Copy Build Files

```bash
# Copy all files from build/web
cp -r build/web/* .

# Create .nojekyll file
touch .nojekyll

# Verify index.html exists
ls -la index.html
```

### Step 5: Commit and Push

```bash
# Add all files
git add .

# Commit
git commit -m "Deploy VerifyUser app - $(date +%Y-%m-%d)"

# Push
git push origin gh-pages --force
```

### Step 6: Switch Back to Main

```bash
git checkout main
```

---

## 🔍 Verify Deployment

After deploying, check:

1. **On GitHub:**
   - Go to: https://github.com/nirosha-expleo/VerifyUser
   - Click on "gh-pages" branch
   - You should see files like:
     - `index.html`
     - `main.dart.js`
     - `flutter.js`
     - `manifest.json`
     - etc.

2. **On GitHub Pages:**
   - Go to: https://nirosha-expleo.github.io/VerifyUser/
   - You should see your Flutter app, not just README

---

## 🐛 Common Issues

### Issue 1: Build folder doesn't exist

**Fix:**
```bash
flutter build web --base-href "/VerifyUser/" --release
```

### Issue 2: Files not copying

**Fix:**
Make sure you're copying from the right location:
```bash
# From main branch, after building
cp -r build/web/* .
```

### Issue 3: GitHub Pages still showing README

**Fix:**
1. Check GitHub Pages settings:
   - Source: `gh-pages` branch
   - Folder: `/ (root)`
2. Wait 5 minutes (GitHub can be slow)
3. Clear browser cache (Ctrl+Shift+R)

---

## ✅ What Should Be in gh-pages Branch

After correct deployment, gh-pages branch should have:

```
gh-pages/
├── index.html          ← Must have this!
├── main.dart.js        ← Must have this!
├── flutter.js          ← Must have this!
├── manifest.json
├── favicon.png
├── .nojekyll
├── assets/
├── canvaskit/
└── icons/
```

**NOT:**
- ❌ README.md (shouldn't be the main file)
- ❌ lib/ folder
- ❌ pubspec.yaml

---

## 🎯 Quick Test

After deploying, check the gh-pages branch on GitHub:

1. Go to: https://github.com/nirosha-expleo/VerifyUser/tree/gh-pages
2. You should see `index.html` as one of the files
3. Click on `index.html` - it should show your app's HTML

If you only see README.md, the deployment didn't work correctly.

---

**Run the updated script: `./DEPLOY_MANUAL.sh` and it should work now! 🚀**

