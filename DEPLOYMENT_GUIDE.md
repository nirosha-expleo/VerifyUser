# 🚀 Deployment Guide - VerifyUser to GitHub Pages

This guide will help you deploy your Flutter web application to GitHub Pages.

---

## 📋 Prerequisites

1. ✅ Flutter SDK installed (3.0.0 or higher)
2. ✅ Git installed
3. ✅ GitHub account
4. ✅ Flutter Web enabled

---

## 🔧 Step 1: Enable Flutter Web

First, make sure Flutter Web is enabled:

```bash
flutter config --enable-web
flutter doctor
```

You should see **Chrome / Web** listed in the output.

---

## 📦 Step 2: Prepare Your Repository

### Option A: Create New Repository (Recommended)

1. Go to [GitHub](https://github.com) and create a new repository
2. Name it (e.g., `verifyuser` or `verifyuser-web`)
3. Set it to **Public** (required for free GitHub Pages)
4. **Don't** initialize with README, .gitignore, or license

### Option B: Use Existing Repository

If you already have a repository, skip to Step 3.

---

## 🏗️ Step 3: Build Flutter Web Application

### Manual Build (One-time deployment)

```bash
# Navigate to project directory
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build for web with correct base href
# Replace 'verifyuser' with your actual repository name
flutter build web --base-href "/verifyuser/" --release
```

**Important:** Replace `verifyuser` with your actual GitHub repository name!

### Using Deployment Script (Recommended)

1. Make the script executable:
   ```bash
   chmod +x deploy.sh
   ```

2. Run the deployment script:
   ```bash
   ./deploy.sh verifyuser
   ```
   (Replace `verifyuser` with your repository name)

3. The script will:
   - Build your Flutter web app
   - Create a `deploy` folder with all necessary files
   - Prepare files for GitHub Pages

---

## 📤 Step 4: Deploy to GitHub Pages

You have **two options** for deployment:

---

### ✅ Option A: Manual Deployment (Simple)

#### 1. Initialize Git (if not already done)

```bash
# If starting fresh
git init
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/verifyuser.git
```

#### 2. Copy build files to root (or use deploy folder)

```bash
# Option 1: Copy from build/web
cp -r build/web/* .

# Option 2: Copy from deploy folder (if using script)
cp -r deploy/* .
```

#### 3. Create .nojekyll file (Important!)

```bash
touch .nojekyll
```

This file tells GitHub Pages not to process files with Jekyll.

#### 4. Commit and push

```bash
git add .
git commit -m "Deploy VerifyUser to GitHub Pages"
git push -u origin main
```

#### 5. Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** → **Pages**
3. Under **Source**:
   - Branch: `main` (or `master`)
   - Folder: `/ (root)`
4. Click **Save**

#### 6. Wait and Access

After 1-2 minutes, your app will be available at:
```
https://YOUR_USERNAME.github.io/verifyuser/
```

---

### ✅ Option B: GitHub Actions Auto-Deployment (Recommended for Updates)

This method automatically deploys your app whenever you push to the main branch.

#### 1. The workflow file is already created

The file `.github/workflows/deploy.yml` is already set up for you!

#### 2. Push your code to GitHub

```bash
git init
git add .
git commit -m "Initial commit with GitHub Actions deployment"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/verifyuser.git
git push -u origin main
```

#### 3. Enable GitHub Pages

1. Go to **Settings** → **Pages**
2. Under **Source**:
   - Select **GitHub Actions**
3. The workflow will automatically:
   - Build your Flutter app
   - Deploy to GitHub Pages
   - Update on every push to main branch

#### 4. Access Your App

After the workflow completes (check Actions tab), your app will be at:
```
https://YOUR_USERNAME.github.io/verifyuser/
```

---

## 🔄 Step 5: Update Base Href for Your Repository

**IMPORTANT:** You need to update the base href to match your repository name.

### Method 1: Update in build command (Recommended)

Always use:
```bash
flutter build web --base-href "/YOUR_REPO_NAME/" --release
```

### Method 2: Update in GitHub Actions

Edit `.github/workflows/deploy.yml` and replace:
```yaml
run: flutter build web --base-href "/${{ github.event.repository.name }}/" --release
```

With:
```yaml
run: flutter build web --base-href "/verifyuser/" --release
```
(Replace `verifyuser` with your actual repo name)

---

## 🐛 Troubleshooting

### ❌ Blank Screen

**Problem:** App shows blank screen

**Solution:**
1. Check that base href matches your repository name
2. Open browser console (F12) and check for errors
3. Verify all files are in the root directory

### ❌ 404 on Page Refresh

**Problem:** Getting 404 when refreshing pages

**Solution:**
- This is expected with client-side routing
- Users should navigate using app buttons, not browser refresh
- Consider using hash routing if needed:
  ```dart
  // In app_router.dart, use hash routing
  GoRouter(
    initialLocation: '/apply-now',
    routes: [...],
    // Add this for hash routing
    urlPathStrategy: UrlPathStrategy.hash,
  )
  ```

### ❌ Assets Not Loading

**Problem:** Images/fonts not showing

**Solution:**
1. Check that assets are included in `pubspec.yaml`
2. Verify asset paths in code
3. Rebuild: `flutter clean && flutter build web`

### ❌ GitHub Actions Failing

**Problem:** Workflow fails

**Solution:**
1. Check Actions tab for error messages
2. Verify Flutter version compatibility
3. Ensure repository is public (for free GitHub Pages)

---

## 🔐 Custom Domain (Optional)

If you want to use a custom domain:

1. Add a `CNAME` file in your repository root:
   ```
   yourdomain.com
   ```

2. Update DNS settings:
   - Add CNAME record pointing to `YOUR_USERNAME.github.io`

3. Update base href:
   ```bash
   flutter build web --base-href "/" --release
   ```

---

## 📊 Deployment Checklist

- [ ] Flutter Web enabled
- [ ] Repository created on GitHub
- [ ] Base href updated to match repo name
- [ ] Flutter app built successfully
- [ ] .nojekyll file created
- [ ] Files pushed to GitHub
- [ ] GitHub Pages enabled
- [ ] App accessible at GitHub Pages URL
- [ ] All routes working correctly
- [ ] Assets loading properly

---

## 🎯 Quick Reference

### Build Command
```bash
flutter build web --base-href "/REPO_NAME/" --release
```

### Your App URL
```
https://YOUR_USERNAME.github.io/REPO_NAME/
```

### Repository Settings
- **Source:** GitHub Actions (for auto-deploy) or main branch
- **Branch:** main (or master)
- **Folder:** / (root)

---

## 📝 Notes

1. **Repository Name:** Make sure the base href matches your repository name exactly
2. **Public Repository:** Free GitHub Pages requires public repositories
3. **Build Time:** First deployment may take 2-5 minutes
4. **Updates:** With GitHub Actions, updates deploy automatically on push
5. **Cache:** Clear browser cache if you see old versions

---

## 🆘 Need Help?

If you encounter issues:

1. Check the [GitHub Pages documentation](https://docs.github.com/en/pages)
2. Review Flutter web deployment [best practices](https://docs.flutter.dev/deployment/web)
3. Check browser console for errors
4. Verify all files are in the correct location

---

**Happy Deploying! 🚀**

