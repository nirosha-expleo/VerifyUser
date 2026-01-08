# 🔧 Fix 404 Error on GitHub Pages

**Error:** "The site configured at this address does not contain the requested file"

This means GitHub Pages can't find your `index.html` file. Let's fix it!

---

## 🎯 Solution 1: Trigger GitHub Actions (Recommended)

Your GitHub Actions workflow should automatically build and deploy. Let's make sure it runs:

### Step 1: Check GitHub Actions

1. Go to: https://github.com/nirosha-expleo/VerifyUser
2. Click on **"Actions"** tab
3. Check if there's a workflow run:
   - ✅ If you see a workflow running/completed → Wait for it to finish
   - ❌ If no workflow → Continue to Step 2

### Step 2: Trigger Workflow Manually

1. In the **"Actions"** tab
2. Click on **"Deploy to GitHub Pages"** workflow (on the left)
3. Click **"Run workflow"** button (top right)
4. Select branch: **main**
5. Click **"Run workflow"**
6. Wait 3-5 minutes for it to complete

### Step 3: Verify Deployment

1. Go to **"Actions"** tab
2. Click on the latest workflow run
3. You should see:
   - ✅ Build job completed
   - ✅ Deploy job completed
4. Check the deployment URL shown in the workflow

---

## 🎯 Solution 2: Manual Deployment (If GitHub Actions Fails)

If GitHub Actions isn't working, deploy manually:

### Step 1: Build Locally

Open Terminal and run:

```bash
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser

# Clean and build
flutter clean
flutter pub get
flutter build web --base-href "/VerifyUser/" --release
```

### Step 2: Create gh-pages Branch

```bash
# Create and switch to gh-pages branch
git checkout --orphan gh-pages

# Remove all files
git rm -rf .

# Copy build files
cp -r build/web/* .

# Create .nojekyll file
touch .nojekyll

# Add all files
git add .

# Commit
git commit -m "Deploy VerifyUser to GitHub Pages"

# Push gh-pages branch
git push origin gh-pages --force
```

### Step 3: Configure GitHub Pages

1. Go to: https://github.com/nirosha-expleo/VerifyUser/settings/pages
2. Under **"Source"**:
   - Select: **"Deploy from a branch"**
   - Branch: **gh-pages**
   - Folder: **/ (root)**
3. Click **"Save"**
4. Wait 2-3 minutes

---

## 🎯 Solution 3: Deploy from Main Branch (Simplest)

If you want to deploy directly from main branch:

### Step 1: Build and Copy Files

```bash
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser

# Build
flutter clean
flutter pub get
flutter build web --base-href "/VerifyUser/" --release

# Copy build files to root
cp -r build/web/* .

# Create .nojekyll
touch .nojekyll
```

### Step 2: Commit and Push

```bash
# Add files
git add .

# Commit
git commit -m "Deploy VerifyUser web build"

# Push
git push origin main
```

### Step 3: Configure GitHub Pages

1. Go to: https://github.com/nirosha-expleo/VerifyUser/settings/pages
2. Under **"Source"**:
   - Select: **"Deploy from a branch"**
   - Branch: **main**
   - Folder: **/ (root)**
3. Click **"Save"**

---

## 🔍 Verify Your Setup

### Check 1: Repository Name
- Your repository name is: **VerifyUser**
- Base href must be: `/VerifyUser/`
- URL will be: `https://nirosha-expleo.github.io/VerifyUser/`

### Check 2: Files Exist
After building, you should have:
- `index.html` in the root (or in build/web/)
- `main.dart.js`
- `flutter.js`
- Other asset files

### Check 3: GitHub Pages Settings
1. Repository must be **Public**
2. Pages must be enabled
3. Source must be set correctly

---

## 🐛 Common Issues & Fixes

### Issue 1: "Workflow not found"
**Fix:** Make sure `.github/workflows/deploy.yml` exists and is committed

### Issue 2: "Build failed"
**Fix:** 
- Check Flutter version compatibility
- Make sure `pubspec.yaml` is valid
- Check Actions tab for error messages

### Issue 3: "Still showing 404"
**Fix:**
- Wait 5-10 minutes (GitHub Pages can be slow)
- Clear browser cache (Ctrl+Shift+R)
- Check the exact URL matches your repo name

### Issue 4: "Blank screen"
**Fix:**
- Verify base href: `/VerifyUser/` (case-sensitive!)
- Check browser console for errors (F12)

---

## ✅ Quick Fix Checklist

- [ ] Repository is **Public**
- [ ] Flutter web app is **built** (`flutter build web`)
- [ ] Files are in the **correct location** (root or build/web/)
- [ ] `.nojekyll` file exists (if deploying from branch)
- [ ] Base href is `/VerifyUser/` (matches repo name)
- [ ] GitHub Pages is **enabled** in Settings
- [ ] Source is set to **GitHub Actions** or **branch**
- [ ] Waited **3-5 minutes** after enabling

---

## 🚀 Recommended Approach

**Best:** Use GitHub Actions (Solution 1)
- Automatic deployment on every push
- No need to commit build files
- Cleaner repository

**Quick Fix:** Use Solution 3 (Deploy from main)
- Fastest to get it working
- Simple and straightforward

---

## 📞 Still Having Issues?

1. Check the **Actions** tab for error messages
2. Verify your repository name is exactly **VerifyUser**
3. Make sure repository is **Public**
4. Try accessing: `https://nirosha-expleo.github.io/VerifyUser/` (case-sensitive!)

---

**After fixing, your app should be live at:**
```
https://nirosha-expleo.github.io/VerifyUser/
```

