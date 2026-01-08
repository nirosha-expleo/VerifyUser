# 🚀 Deploy VerifyUser to GitHub Pages - Step by Step

**Your Repository:** `https://github.com/nirosha-expleo/VerifyUser.git`  
**Repository Name:** `VerifyUser`  
**Your GitHub Pages URL will be:** `https://nirosha-expleo.github.io/VerifyUser/`

---

## 📋 Step-by-Step Instructions

### Step 1: Build Flutter Web App

Open your terminal and run these commands:

```bash
# Navigate to your project directory
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build for web with correct base href
flutter build web --base-href "/VerifyUser/" --release
```

✅ This will create the `build/web/` folder with all necessary files.

---

### Step 2: Prepare Files for GitHub Pages

```bash
# Create .nojekyll file (important for GitHub Pages)
touch .nojekyll

# Verify build was successful
ls -la build/web/
```

You should see files like `index.html`, `main.dart.js`, `flutter.js`, etc.

---

### Step 3: Add All Files to Git

```bash
# Add all files (including the new ones)
git add .

# Check what will be committed
git status
```

You should see files like:
- `.github/workflows/deploy.yml`
- `.gitignore`
- `DEPLOYMENT_GUIDE.md`
- `build/web/` (if you want to commit build files)
- etc.

---

### Step 4: Commit and Push

```bash
# Commit all changes
git commit -m "Deploy VerifyUser to GitHub Pages"

# Push to GitHub
git push origin main
```

✅ Your code is now on GitHub!

---

### Step 5: Enable GitHub Pages (IMPORTANT!)

1. **Go to your GitHub repository:**
   ```
   https://github.com/nirosha-expleo/VerifyUser
   ```

2. **Click on "Settings"** (top menu)

3. **Scroll down to "Pages"** (left sidebar)

4. **Under "Source":**
   - Select **"GitHub Actions"** (recommended for auto-deployment)
   - OR select **"Deploy from a branch"** → Branch: `main` → Folder: `/ (root)`

5. **Click "Save"**

6. **Wait 2-3 minutes** for GitHub to build and deploy

---

### Step 6: Access Your Live App! 🎉

After GitHub Pages is enabled, your app will be available at:

```
https://nirosha-expleo.github.io/VerifyUser/
```

**Note:** It may take 2-5 minutes for the first deployment to complete.

---

## 🔄 Option A: Use GitHub Actions (Recommended)

If you selected "GitHub Actions" in Step 5:

1. The `.github/workflows/deploy.yml` file will automatically:
   - Build your Flutter app
   - Deploy to GitHub Pages
   - Update on every push to main branch

2. **Check deployment status:**
   - Go to your repository
   - Click on "Actions" tab
   - You'll see the deployment workflow running

3. **Future updates:**
   - Just push to main branch
   - GitHub Actions will automatically rebuild and deploy!

---

## 🔄 Option B: Manual Deployment (If GitHub Actions doesn't work)

If you need to deploy manually:

```bash
# Copy build files to root (if needed)
cp -r build/web/* .

# Add and commit
git add .
git commit -m "Update deployment"
git push origin main
```

Then in GitHub Settings → Pages, select:
- **Source:** `main` branch
- **Folder:** `/ (root)`

---

## ✅ Verify Deployment

1. **Check GitHub Actions:**
   - Go to "Actions" tab in your repository
   - You should see a workflow running or completed

2. **Check GitHub Pages:**
   - Go to Settings → Pages
   - You should see: "Your site is live at https://nirosha-expleo.github.io/VerifyUser/"

3. **Open in Browser:**
   - Visit: `https://nirosha-expleo.github.io/VerifyUser/`
   - Your app should load!

---

## 🐛 Troubleshooting

### ❌ Blank Screen

**Fix:**
```bash
# Rebuild with correct base href
flutter build web --base-href "/VerifyUser/" --release
git add build/web/
git commit -m "Fix base href"
git push
```

### ❌ 404 Error

**Fix:**
- Verify base href is exactly `/VerifyUser/` (case-sensitive)
- Check repository name matches exactly

### ❌ GitHub Actions Failing

**Fix:**
1. Check "Actions" tab for error messages
2. Verify repository is **Public**
3. Make sure `.github/workflows/deploy.yml` exists

### ❌ Assets Not Loading

**Fix:**
```bash
flutter clean
flutter pub get
flutter build web --base-href "/VerifyUser/" --release
```

---

## 📝 Quick Reference

**Repository:** `nirosha-expleo/VerifyUser`  
**Base Href:** `/VerifyUser/`  
**Live URL:** `https://nirosha-expleo.github.io/VerifyUser/`

**Build Command:**
```bash
flutter build web --base-href "/VerifyUser/" --release
```

**Push Updates:**
```bash
git add .
git commit -m "Update app"
git push origin main
```

---

## 🎯 Next Steps After Deployment

1. ✅ Test all routes in your app
2. ✅ Test on mobile devices
3. ✅ Share the URL with others
4. ✅ Bookmark your app URL

---

**That's it! Your app is now live on GitHub Pages! 🚀**

If you encounter any issues, check the troubleshooting section above or the detailed `DEPLOYMENT_GUIDE.md`.

