#!/bin/bash

# Quick Fix Script for GitHub Pages 404 Error
# This script will help you deploy your Flutter app to GitHub Pages

echo "🔧 Fixing GitHub Pages 404 Error..."
echo ""

# Step 1: Build Flutter Web
echo "📱 Step 1: Building Flutter web app..."
flutter clean
flutter pub get
flutter build web --base-href "/VerifyUser/" --release

if [ ! -d "build/web" ]; then
    echo "❌ Build failed! Please check for errors above."
    exit 1
fi

echo "✅ Build completed!"
echo ""

# Step 2: Ask user what they want to do
echo "Choose deployment method:"
echo "1) Use GitHub Actions (Recommended - automatic)"
echo "2) Deploy manually to main branch"
echo "3) Deploy to gh-pages branch"
read -p "Enter choice (1/2/3): " choice

case $choice in
    1)
        echo ""
        echo "✅ GitHub Actions workflow updated!"
        echo ""
        echo "📋 Next steps:"
        echo "1. Commit and push the updated workflow:"
        echo "   git add .github/workflows/deploy.yml"
        echo "   git commit -m 'Fix GitHub Actions deployment'"
        echo "   git push origin main"
        echo ""
        echo "2. Go to GitHub → Actions tab → Run workflow manually"
        echo "3. Wait 3-5 minutes for deployment"
        ;;
    2)
        echo ""
        echo "📦 Deploying to main branch..."
        cp -r build/web/* .
        touch .nojekyll
        
        echo ""
        echo "✅ Files ready! Now run:"
        echo "   git add ."
        echo "   git commit -m 'Deploy VerifyUser to GitHub Pages'"
        echo "   git push origin main"
        echo ""
        echo "Then in GitHub Settings → Pages:"
        echo "   Source: Deploy from a branch"
        echo "   Branch: main"
        echo "   Folder: / (root)"
        ;;
    3)
        echo ""
        echo "📦 Creating gh-pages branch..."
        git checkout --orphan gh-pages
        git rm -rf .
        cp -r build/web/* .
        touch .nojekyll
        git add .
        git commit -m "Deploy VerifyUser to GitHub Pages"
        
        echo ""
        echo "✅ Ready to push! Run:"
        echo "   git push origin gh-pages --force"
        echo ""
        echo "Then in GitHub Settings → Pages:"
        echo "   Source: Deploy from a branch"
        echo "   Branch: gh-pages"
        echo "   Folder: / (root)"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "🌐 Your app will be available at:"
echo "   https://nirosha-expleo.github.io/VerifyUser/"
echo ""

