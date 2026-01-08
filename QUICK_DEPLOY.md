# ⚡ Quick Deploy Guide - VerifyUser

**Fastest way to deploy your Flutter app to GitHub Pages!**

---

## 🎯 Quick Steps (5 minutes)

### 1️⃣ Create GitHub Repository

```bash
# On GitHub.com, create a new repository named "verifyuser"
# Make it PUBLIC (required for free GitHub Pages)
```

### 2️⃣ Build Your App

```bash
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser

# Build with your repository name
flutter build web --base-href "/verifyuser/" --release
```

**⚠️ IMPORTANT:** Replace `verifyuser` with your actual GitHub repository name!

### 3️⃣ Initialize Git & Push

```bash
# Initialize git (if not already)
git init
git branch -M main

# Add all files
git add .

# Commit
git commit -m "Initial commit - VerifyUser app"

# Add remote (replace YOUR_USERNAME and verifyuser)
git remote add origin https://github.com/YOUR_USERNAME/verifyuser.git

# Push
git push -u origin main
```

### 4️⃣ Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** → **Pages**
3. Under **Source**:
   - Select **GitHub Actions**
4. Click **Save**

### 5️⃣ Wait & Access! 🎉

After 2-3 minutes, your app will be live at:
```
https://YOUR_USERNAME.github.io/verifyuser/
```

---

## 🔄 For Future Updates

Just push to main branch:
```bash
git add .
git commit -m "Update app"
git push
```

GitHub Actions will automatically rebuild and deploy! ✨

---

## 🐛 Troubleshooting

**Blank screen?**
- Check base href matches your repo name exactly
- Clear browser cache (Ctrl+Shift+R)

**404 errors?**
- Verify repository name in base href
- Check GitHub Pages is enabled

**Need more help?**
- See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) for detailed instructions

---

**That's it! Your app is now live! 🚀**

