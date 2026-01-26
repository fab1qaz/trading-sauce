# Trading Sauce - Local Development Guide

Hey Fabian! 👋 This guide will get you set up to edit your site locally, understand the codebase, and make changes yourself.

---

## Table of Contents
1. [Prerequisites](#1-prerequisites)
2. [Setting Up Your Code Editor](#2-setting-up-your-code-editor)
3. [Cloning the Repository](#3-cloning-the-repository)
4. [Installing Dependencies & Running the Site](#4-installing-dependencies--running-the-site)
5. [Understanding the Codebase](#5-understanding-the-codebase)
6. [Making Changes](#6-making-changes)
7. [Git Basics](#7-git-basics)
8. [Deploying Your Changes](#8-deploying-your-changes)
9. [Troubleshooting](#9-troubleshooting)

---

## 1. Prerequisites

Before we start, you need a few things installed:

### Install Node.js
1. Go to https://nodejs.org
2. Download the **LTS version** (the green button)
3. Run the installer, accept all defaults

### Install pnpm (package manager)
Open Terminal (Mac) or Command Prompt (Windows) and run:
```bash
npm install -g pnpm
```

### Install Git
- **Mac:** Open Terminal and type `git --version`. If it's not installed, it'll prompt you to install it.
- **Windows:** Download from https://git-scm.com/downloads

---

## 2. Setting Up Your Code Editor

I recommend either **Cursor** or **Zed**. Both are modern and have AI features.

### Option A: Cursor (Recommended for beginners)
1. Go to https://cursor.com
2. Download and install
3. It's like VS Code but with built-in AI that can help you code

### Option B: Zed
1. Go to https://zed.dev
2. Download and install
3. Very fast, minimal, great for Mac users

### First-Time Setup
Once installed, open your editor and familiarize yourself with:
- **File Explorer** (left sidebar) - browse project files
- **Terminal** (usually bottom panel) - run commands
- **Editor** (main area) - edit files

---

## 3. Cloning the Repository

A "repository" (repo) is where all your code lives. Yours is on GitHub.

### Step 1: Open Terminal in your editor
- **Cursor/VS Code:** Press `` Ctrl+` `` (backtick) or go to View → Terminal
- **Zed:** Press `Ctrl+~`

### Step 2: Navigate to where you want the project
```bash
cd ~/Documents
```
(This puts it in your Documents folder. Change if you prefer elsewhere.)

### Step 3: Clone the repo
```bash
git clone https://github.com/fab1qaz/trading-sauce.git
```

### Step 4: Open the project
```bash
cd trading-sauce
```
Then open this folder in your editor:
- **Cursor:** File → Open Folder → select `trading-sauce`
- **Zed:** File → Open → select `trading-sauce`

---

## 4. Installing Dependencies & Running the Site

### Install all the packages
In your terminal, run:
```bash
pnpm install
```
This downloads all the libraries the project needs. Takes a minute.

### Start the development server
```bash
pnpm dev
```

You should see something like:
```
  🚀 astro dev
  
  Local: http://localhost:4321/
```

Open http://localhost:4321 in your browser. That's your site running locally! 🎉

**To stop the server:** Press `Ctrl+C` in the terminal.

---

## 5. Understanding the Codebase

Here's what each file/folder does:

```
trading-sauce/
├── src/                     ← 🔥 MOST IMPORTANT - your actual code
│   ├── pages/
│   │   └── index.astro      ← Your entire homepage
│   └── styles/
│       └── global.css       ← All your styling (colors, fonts, animations)
├── public/                  ← Static files (images, favicon)
│   ├── logo.png
│   ├── logo-full.png
│   └── favicon.ico
├── astro.config.mjs         ← Astro settings (rarely need to touch)
├── package.json             ← Project metadata and dependencies
└── pnpm-lock.yaml           ← Dependency lock file (never edit manually)
```

### The Two Files You'll Edit Most

#### 1. `src/pages/index.astro`
This is your ENTIRE homepage. It's written in Astro, which is basically HTML with some extra features.

The file has three parts:
```astro
---
// This section is JavaScript (runs on the server)
// Variables, data, imports go here
const services = [...]
const socials = [...]
---

<html lang="en">
  <!-- This is your HTML - the structure of the page -->
</html>
```

**Key sections in your index.astro:**
- Lines 1-27: Data (services, socials)
- Lines 30-50: `<head>` - meta tags, title
- Lines 52-80: Header/navbar
- Lines 82-120: Hero section ("Trading Sauce" big heading)
- Lines 122-175: About section (your photo + bio)
- Lines 177-245: Treehouse section
- Lines 247-310: 1-on-1 Coaching section
- Lines 312-360: Contact section
- Lines 362-420: YouTube section
- Lines 422-470: Footer

#### 2. `src/styles/global.css`
This defines your visual identity:
- **Color palette** (the neon cyber colors)
- **Fonts** (Orbitron for headings, Inter for body)
- **Glow effects** (.glow-cyan, .glow-sauce)
- **Button styles** (.btn-cyber, .btn-sauce)
- **Card styles** (.card-cyber)
- **Animations** (glitch, pulse)

---

## 6. Making Changes

### Changing Text
1. Open `src/pages/index.astro`
2. Find the text you want to change
3. Edit it and save
4. Your browser will auto-refresh!

**Example:** To change your tagline:
```astro
<!-- Find this line (around line 100): -->
<p class="text-lg text-shadow max-w-2xl mx-auto mb-12 leading-relaxed">
  Solve your trading execution errors by overcoming mental biases...
</p>

<!-- Change the text inside the <p> tags -->
```

### Changing Colors
Open `src/styles/global.css` and look at the `@theme` section:
```css
@theme {
  --color-sauce: #94c595;     ← Your green accent
  --color-cyan: #00f0ff;      ← The blue/cyan glow
  --color-magenta: #ff00ff;   ← Pink/magenta
}
```

### Changing Images
1. Add new images to the `public/` folder
2. Reference them in your HTML: `src="/your-image.png"`

**Example:**
```astro
<img src="/my-new-photo.jpg" alt="Description" />
```

### Changing Prices
Find the `services` array at the top of `index.astro`:
```javascript
const services = [
  {
    name: "Traders' Treehouse",
    price: "$200/month",  // ← Change this
    ...
  },
]
```

---

## 7. Git Basics

Git tracks changes to your code. Think of it like "versions" of a document.

### The Basic Workflow

#### 1. Check what changed
```bash
git status
```
Shows you which files have been modified.

#### 2. Stage your changes
```bash
git add .
```
The `.` means "add everything." You can also add specific files:
```bash
git add src/pages/index.astro
```

#### 3. Commit (save a snapshot)
```bash
git commit -m "Updated pricing to $250/month"
```
The message should describe what you changed.

#### 4. Push to GitHub
```bash
git push
```
This uploads your changes to GitHub, which triggers a new deployment.

### Common Scenarios

**"I want to undo my changes to a file"**
```bash
git checkout -- src/pages/index.astro
```

**"I want to see what I changed"**
```bash
git diff
```

**"I want to see the history"**
```bash
git log --oneline
```

---

## 8. Deploying Your Changes

Your site is hosted on **Vercel**. When you push to GitHub, Vercel automatically:
1. Detects the new code
2. Builds the site
3. Deploys it to production

**Workflow:**
1. Make changes locally
2. Test at http://localhost:4321
3. When happy, commit and push:
   ```bash
   git add .
   git commit -m "Your change description"
   git push
   ```
4. Wait ~1-2 minutes for Vercel to deploy
5. Check your live site!

---

## 9. Troubleshooting

### "pnpm: command not found"
Run `npm install -g pnpm` again, then restart your terminal.

### "The site looks broken locally"
Make sure the dev server is running (`pnpm dev`).

### "My changes aren't showing up"
- Did you save the file?
- Is the dev server running?
- Hard refresh your browser: `Ctrl+Shift+R` (Windows) or `Cmd+Shift+R` (Mac)

### "Git says I have conflicts"
This happens when the remote has changes you don't have locally. Run:
```bash
git pull
```
If there are actual conflicts, you'll need to resolve them in the file (look for `<<<<<<<` markers).

### "I broke everything!"
Don't panic. You can always:
```bash
git stash          # Temporarily hide your changes
git checkout main  # Go back to the last working state
```

---

## Quick Reference

| Task | Command |
|------|---------|
| Start dev server | `pnpm dev` |
| Stop dev server | `Ctrl+C` |
| Install dependencies | `pnpm install` |
| Check changes | `git status` |
| Stage all changes | `git add .` |
| Commit | `git commit -m "message"` |
| Push to GitHub/deploy | `git push` |

---

## Need Help?

Hit me up on Telegram or just ping me in the chat. I can also make changes for you if you get stuck.

Happy coding! 🚀
