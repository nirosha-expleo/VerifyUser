# 🚀 How to Run the Deployment Script

## Step-by-Step Instructions

### Step 1: Open Terminal

**On Mac:**
- Press `Command + Space` (opens Spotlight)
- Type: `Terminal`
- Press Enter

**Or:**
- Go to Applications → Utilities → Terminal

---

### Step 2: Navigate to Your Project Folder

Copy and paste this command in Terminal:

```bash
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser
```

Press **Enter**

You should see your prompt change to show you're in that directory.

---

### Step 3: Verify the Script Exists

Type this command:

```bash
ls -la DEPLOY_MANUAL.sh
```

Press **Enter**

You should see something like:
```
-rwxr-xr-x  1 nirosha  staff  2371 Jan  8 18:59 DEPLOY_MANUAL.sh
```

If you see this, the script exists and is ready to run!

---

### Step 4: Run the Script

Type this command:

```bash
./DEPLOY_MANUAL.sh
```

Press **Enter**

---

### Step 5: Watch It Work! 

The script will:
1. ✅ Clean previous builds
2. ✅ Get Flutter dependencies
3. ✅ Build your web app
4. ✅ Create gh-pages branch
5. ✅ Copy files
6. ✅ Push to GitHub

**This will take 2-5 minutes.** You'll see progress messages.

---

## 📋 Complete Command Sequence

Copy and paste these commands one by one:

```bash
# 1. Go to project folder
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser

# 2. Run the script
./DEPLOY_MANUAL.sh
```

That's it! Just these two commands.

---

## ❓ Troubleshooting

### Error: "Permission denied"

If you see this error, run:

```bash
chmod +x DEPLOY_MANUAL.sh
./DEPLOY_MANUAL.sh
```

### Error: "No such file or directory"

Make sure you're in the right folder:

```bash
pwd
```

Should show: `/Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser`

If not, run:
```bash
cd /Users/nirosha/Documents/Expleo/VerifyUser/VerifyUser
```

### Error: "flutter: command not found"

Flutter is not installed or not in your PATH. Check:
```bash
flutter doctor
```

---

## 🎯 What You'll See

When the script runs successfully, you'll see output like:

```
🚀 Starting Manual Deployment to GitHub Pages...

📱 Step 1: Building Flutter web application...
Running "flutter pub get"...
Building web application...
✅ Build completed successfully!

📍 Current branch: main

📦 Step 2: Preparing gh-pages branch...
   Creating new gh-pages branch...

📋 Step 3: Copying build files...
📝 Step 4: Creating .nojekyll file...
💾 Step 5: Committing files...
📤 Step 6: Pushing to GitHub...

✅ Deployment completed!

📋 Next steps:
1. Go to: https://github.com/nirosha-expleo/VerifyUser/settings/pages
...
```

---

## ✅ After Script Completes

1. Go to GitHub Settings → Pages (as explained before)
2. Configure to use `gh-pages` branch
3. Wait 2-3 minutes
4. Your app will be live!

---

**That's all! Just open Terminal and run those two commands! 🚀**

