# 📖 How to Configure GitHub Pages - Step by Step Guide

**You DON'T need to create the branch manually!** The script will create it for you. You just need to tell GitHub Pages to use it.

---

## 🎯 What Happens:

1. **Script creates the branch** → Pushes it to GitHub automatically
2. **You configure GitHub Pages** → Tell GitHub to use that branch (this is what you're asking about)

---

## 📋 Step-by-Step: Configure GitHub Pages

### Step 1: Run the Deployment Script First

```bash
./DEPLOY_MANUAL.sh
```

Wait for it to complete. It will create the `gh-pages` branch and push it to GitHub.

---

### Step 2: Go to GitHub Settings

1. **Open your browser**
2. **Go to your repository:**
   ```
   https://github.com/nirosha-expleo/VerifyUser
   ```

3. **Click on "Settings"** (top menu, next to "Code", "Issues", etc.)

   ![Settings location](https://i.imgur.com/example.png)
   - It's in the top menu bar of your repository

---

### Step 3: Find Pages Section

1. **In the left sidebar**, scroll down and click on **"Pages"**

   - It's under "Code and automation" section
   - Left side menu, scroll down

---

### Step 4: Configure the Source

You'll see a section that says **"Source"** or **"Build and deployment"**

1. **Click the dropdown** that says "None" or "Deploy from a branch"

2. **Select: "Deploy from a branch"**

3. **You'll see two more dropdowns:**

   **Branch:**
   - Click the dropdown
   - Select: **`gh-pages`**
   - (This branch was created by the script)

   **Folder:**
   - Click the dropdown  
   - Select: **`/ (root)`**

4. **Click "Save"** button

---

## 📸 Visual Guide (What You'll See):

```
GitHub Repository → Settings → Pages

┌─────────────────────────────────────┐
│ Source                              │
│ ┌─────────────────────────────────┐ │
│ │ Deploy from a branch        ▼  │ │ ← Click here
│ └─────────────────────────────────┘ │
│                                      │
│ Branch: [gh-pages ▼]                 │ ← Select "gh-pages"
│ Folder: [/ (root) ▼]                 │ ← Select "/ (root)"
│                                      │
│ [Save]                               │ ← Click Save
└─────────────────────────────────────┘
```

---

## ✅ After Clicking Save:

1. **Wait 2-3 minutes** (GitHub needs time to deploy)

2. **You'll see a message:**
   ```
   Your site is live at https://nirosha-expleo.github.io/VerifyUser/
   ```

3. **Visit that URL** - your app should be there!

---

## 🔍 How to Verify the Branch Exists:

If you want to check that the `gh-pages` branch was created:

1. Go to: https://github.com/nirosha-expleo/VerifyUser
2. Click on the branch dropdown (usually says "main")
3. You should see **`gh-pages`** in the list
4. Click on it to see the files

**But you don't need to do this!** The script already created it.

---

## ❓ Common Questions:

### Q: Do I need to create the branch manually?
**A:** No! The script `./DEPLOY_MANUAL.sh` creates it automatically.

### Q: What if I don't see "gh-pages" in the branch dropdown?
**A:** Run the script first: `./DEPLOY_MANUAL.sh`

### Q: What if the script fails?
**A:** Check the error message. Common issues:
- Flutter not installed: `flutter doctor`
- Not in the right directory: `cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser`

### Q: What if I see "gh-pages" branch but GitHub Pages still shows 404?
**A:** 
1. Make sure you selected the right branch in Settings → Pages
2. Wait 5 minutes (GitHub can be slow)
3. Clear browser cache (Ctrl+Shift+R)

---

## 🎯 Summary:

1. ✅ Run: `./DEPLOY_MANUAL.sh` (creates the branch)
2. ✅ Go to: GitHub → Settings → Pages
3. ✅ Select: "Deploy from a branch"
4. ✅ Choose: Branch = `gh-pages`, Folder = `/ (root)`
5. ✅ Click: "Save"
6. ✅ Wait: 2-3 minutes
7. ✅ Visit: https://nirosha-expleo.github.io/VerifyUser/

---

**That's it! You're just telling GitHub which branch to use for your website. The branch is already created by the script! 🚀**

