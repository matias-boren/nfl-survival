# Pick1 Logo Resize Guide

## 🎯 Quick Setup Instructions

### Option 1: Automated Script (Recommended)

1. **Save your logo** as: `assets/images/logo/pick1_logo_source.png`
2. **Run the script**: `./scripts/resize_logo.sh`
3. **Done!** All sizes will be generated automatically

### Option 2: Online Tools (Manual)

Use any of these free online image resizers:
- **Canva** (canva.com) - Has batch resize feature
- **Photopea** (photopea.com) - Free Photoshop alternative
- **Squoosh** (squoosh.app) - Google's image optimizer
- **ResizeImage.net** - Simple batch resizer

## 📏 Required Sizes

### Horizontal Logos (16:9 aspect ratio)
```
pick1_logo_horizontal.png     → 400×120px
pick1_logo_horizontal@2x.png  → 800×240px  
pick1_logo_horizontal@3x.png  → 1200×360px
```

### White Versions (for dark backgrounds)
```
pick1_logo_white.png     → 400×120px (inverted colors)
pick1_logo_white@2x.png  → 800×240px (inverted colors)
pick1_logo_white@3x.png  → 1200×360px (inverted colors)
```

### Square Versions (1:1 aspect ratio)
```
pick1_logo_square.png     → 400×400px (cropped to center)
pick1_logo_square@2x.png  → 800×800px (cropped to center)
pick1_logo_square@3x.png  → 1200×1200px (cropped to center)
```

### Icons (small sizes)
```
pick1_icon.png     → 64×64px
pick1_icon@2x.png  → 128×128px
pick1_icon@3x.png  → 192×192px
```

### Web Favicon
```
web/favicon.png → 32×32px
```

## 🎨 Design Tips

### For Horizontal Logos:
- Maintain the 16:9 aspect ratio from your original
- Ensure text is readable at smallest size (400×120px)
- Keep important elements away from edges

### For Square Logos:
- Focus on the most important part (likely the "1" or main symbol)
- Consider creating a simplified square version if cropping doesn't work well
- Test readability at 64×64px (smallest icon size)

### For White Versions:
- Simply invert colors of your original
- Or create a version specifically designed for dark backgrounds
- Ensure good contrast against dark grey (#222831)

## 🚀 Testing

After creating the files, test in your app:
1. **Sign-in screen**: Should show horizontal logo
2. **Home header**: Should show horizontal logo in app bar
3. **Loading screen**: Should show horizontal logo with animation

## 📱 Future: App Store Icons

For app store submission, you'll also need:
- iOS: 1024×1024px app store icon
- Android: 512×512px Play Store icon
- Various launcher icon sizes

But the current setup covers all in-app usage!
