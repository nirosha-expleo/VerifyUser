#!/bin/bash

# Deploy Flutter Web App to GitHub Pages
# Usage: ./deploy.sh [repository-name]
# Example: ./deploy.sh verifyuser

set -e

REPO_NAME=${1:-"verifyuser"}
GITHUB_USER=${GITHUB_USER:-"YOUR_GITHUB_USERNAME"}

echo "🚀 Starting deployment for VerifyUser..."
echo "📦 Repository: $REPO_NAME"
echo ""

# Step 1: Build Flutter Web
echo "📱 Building Flutter web application..."
flutter clean
flutter pub get
flutter build web --base-href "/$REPO_NAME/" --release

# Step 2: Create deployment directory
echo "📁 Preparing deployment files..."
rm -rf deploy
mkdir -p deploy
cp -r build/web/* deploy/

# Step 3: Update base href in index.html (backup)
echo "🔧 Updating base href..."
cd deploy
sed -i.bak "s|<base href=\"\$FLUTTER_BASE_HREF\">|<base href=\"/$REPO_NAME/\">|g" index.html
rm -f index.html.bak
cd ..

# Step 4: Create .nojekyll file (important for GitHub Pages)
echo "📝 Creating .nojekyll file..."
touch deploy/.nojekyll

# Step 5: Instructions
echo ""
echo "✅ Build completed successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Review the files in the 'deploy' directory"
echo "2. Initialize git in deploy directory (if not already):"
echo "   cd deploy"
echo "   git init"
echo "   git branch -M gh-pages"
echo ""
echo "3. Add your GitHub remote:"
echo "   git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git"
echo ""
echo "4. Commit and push:"
echo "   git add ."
echo "   git commit -m 'Deploy VerifyUser to GitHub Pages'"
echo "   git push -u origin gh-pages --force"
echo ""
echo "5. Enable GitHub Pages in repository settings:"
echo "   Settings → Pages → Source: gh-pages branch → / (root)"
echo ""
echo "🌐 Your app will be available at:"
echo "   https://$GITHUB_USER.github.io/$REPO_NAME/"
echo ""

