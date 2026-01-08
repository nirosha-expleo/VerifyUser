#!/bin/bash

# Manual Deployment Script for GitHub Pages
# This will deploy your Flutter app directly to GitHub Pages

set -e

echo "🚀 Starting Manual Deployment to GitHub Pages..."
echo ""

# Step 1: Build Flutter Web
echo "📱 Step 1: Building Flutter web application..."
flutter clean
flutter pub get
flutter build web --base-href "/VerifyUser/" --release

if [ ! -d "build/web" ]; then
    echo "❌ Build failed! Please check for errors above."
    exit 1
fi

echo "✅ Build completed successfully!"
echo ""

# Verify build folder exists
if [ ! -d "build/web" ]; then
    echo "❌ Error: build/web directory not found!"
    echo "   The build must have failed. Please check the build output above."
    exit 1
fi

# Step 2: Save build files to temporary location (before switching branches)
echo ""
echo "📦 Step 2: Saving build files..."
TEMP_BUILD_DIR=$(mktemp -d)
cp -r build/web/* "$TEMP_BUILD_DIR/"
echo "   ✅ Build files saved to temporary location"

# Step 3: Check if we're on main branch
current_branch=$(git branch --show-current)
echo "📍 Current branch: $current_branch"

if [ "$current_branch" != "main" ]; then
    echo "⚠️  Warning: You're not on main branch. Switching to main..."
    git checkout main
fi

# Step 4: Create gh-pages branch or update it
echo ""
echo "📦 Step 3: Preparing gh-pages branch..."

# Commit any uncommitted changes on main branch first
echo "   Checking for uncommitted changes..."
if ! git diff-index --quiet HEAD --; then
    echo "   Found uncommitted changes, committing them..."
    git add .
    git commit -m "Save changes before deployment" || true
fi

# Check if gh-pages branch exists locally
if git show-ref --verify --quiet refs/heads/gh-pages; then
    echo "   gh-pages branch exists locally, switching to it..."
    # Force checkout to overwrite any conflicting files
    git checkout -f gh-pages 2>/dev/null || {
        echo "   Force cleaning and switching..."
        git clean -fd
        git checkout -f gh-pages
    }
    # Remove all files except .git
    git rm -rf . 2>/dev/null || true
    # Also remove any untracked files
    git clean -fd
else
    echo "   Creating new gh-pages branch..."
    git checkout --orphan gh-pages
    git rm -rf . 2>/dev/null || true
    git clean -fd
fi

# Step 5: Copy build files from temporary location
echo ""
echo "📋 Step 4: Copying build files to gh-pages branch..."

# Copy all files from temporary location
cp -r "$TEMP_BUILD_DIR"/* .

# Clean up temporary directory
rm -rf "$TEMP_BUILD_DIR"

# Verify index.html exists
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found after copying!"
    echo "   Something went wrong with the file copy."
    git checkout main
    exit 1
fi

echo "   ✅ Files copied successfully (found index.html)"

# Step 5: Create .nojekyll file
echo "📝 Step 4: Creating .nojekyll file..."
touch .nojekyll

# Step 6: Add and commit
echo ""
echo "💾 Step 5: Committing files..."
git add .
git commit -m "Deploy VerifyUser to GitHub Pages - $(date +%Y-%m-%d)" || echo "   (No changes to commit)"

# Step 7: Push to GitHub
echo ""
echo "📤 Step 6: Pushing to GitHub..."
git push origin gh-pages --force

echo ""
echo "✅ Deployment completed!"
echo ""
echo "📋 Next steps:"
echo "1. Go to: https://github.com/nirosha-expleo/VerifyUser/settings/pages"
echo "2. Under 'Source':"
echo "   - Select: 'Deploy from a branch'"
echo "   - Branch: 'gh-pages'"
echo "   - Folder: '/ (root)'"
echo "3. Click 'Save'"
echo "4. Wait 2-3 minutes"
echo ""
echo "🌐 Your app will be available at:"
echo "   https://nirosha-expleo.github.io/VerifyUser/"
echo ""
echo "🔄 Switching back to main branch..."
git checkout main

echo ""
echo "✅ Done! Check your GitHub Pages settings and wait a few minutes."

