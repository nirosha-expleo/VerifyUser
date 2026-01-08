# 🔧 IMMEDIATE FIX - GitHub Pages 404 Error

**Problem:** GitHub Pages is enabled but showing 404 error  
**Solution:** Deploy files manually to gh-pages branch

---

## ⚡ Quick Fix (5 minutes)

### Option 1: Run the Automated Script (Easiest)

```bash
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser
./DEPLOY_MANUAL.sh
```

This script will:
1. ✅ Build your Flutter app
2. ✅ Create/update gh-pages branch
3. ✅ Copy all files
4. ✅ Push to GitHub
5. ✅ Guide you to configure GitHub Pages

**Then:**
1. Go to: https://github.com/nirosha-expleo/VerifyUser/settings/pages
2. Set Source to: **Deploy from a branch**
3. Set Branch to: **gh-pages**
4. Set Folder to: **/ (root)**
5. Click **Save**
6. Wait 2-3 minutes

---

### Option 2: Manual Steps (If script doesn't work)

#### Step 1: Build Flutter App

```bash
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser

flutter clean
flutter pub get
flutter build web --base-href "/VerifyUser/" --release
```

#### Step 2: Create gh-pages Branch

```bash
# Switch to main first
git checkout main

# Create orphan branch (or switch if exists)
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

# Push
git push origin gh-pages --force

# Switch back to main
git checkout main
```

#### Step 3: Configure GitHub Pages

1. Go to: https://github.com/nirosha-expleo/VerifyUser/settings/pages
2. Under **"Source"**:
   - Select: **"Deploy from a branch"**
   - Branch: **gh-pages**
   - Folder: **/ (root)**
3. Click **"Save"**
4. Wait 2-3 minutes

---

## 🔍 Why This Works

The issue is that GitHub Pages is enabled but there are no files deployed. By:
1. Building the Flutter app locally
2. Creating a `gh-pages` branch with the build files
3. Configuring GitHub Pages to use that branch

GitHub Pages will have the actual files it needs to serve.

---

## ✅ Verify It's Working

After 2-3 minutes:

1. Visit: https://nirosha-expleo.github.io/VerifyUser/
2. You should see your app loading
3. If still 404, wait another 2-3 minutes (GitHub can be slow)

---

## 🐛 Still Not Working?

### Check 1: Repository Settings
- Repository must be **Public**
- GitHub Pages must be **enabled**
- Source must be set to **gh-pages** branch

### Check 2: Files Exist
After running the script, check:
```bash
git checkout gh-pages
ls -la
```

You should see:
- `index.html`
- `main.dart.js`
- `flutter.js`
- Other files

### Check 3: Base Href
Make sure build command uses:
```bash
flutter build web --base-href "/VerifyUser/" --release
```

The `/VerifyUser/` must match your repository name exactly!

---

## 🎯 After Fixing

Your app will be live at:
```
https://nirosha-expleo.github.io/VerifyUser/
```

**For future updates:**
- Just run `./DEPLOY_MANUAL.sh` again
- Or push to main and let GitHub Actions handle it

---

## 📞 Quick Troubleshooting

**"Permission denied" when running script:**
```bash
chmod +x DEPLOY_MANUAL.sh
./DEPLOY_MANUAL.sh
```

**"Build failed":**
- Make sure Flutter is installed: `flutter doctor`
- Check for errors in the build output

**"Still 404 after 5 minutes":**
- Clear browser cache (Ctrl+Shift+R)
- Try incognito/private window
- Check GitHub Pages settings again

---

**Run the script now and your app will be live in 5 minutes! 🚀**

