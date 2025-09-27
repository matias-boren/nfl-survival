# AdMob Setup Guide for NFL Survival Pool

This guide will help you set up Google AdMob for real ad revenue in your NFL Survival Pool app.

## 🚀 **Step 1: Create AdMob Account**

1. Go to [AdMob Console](https://apps.admob.com/)
2. Sign in with your Google account
3. Create a new AdMob account if you don't have one
4. Accept the AdMob terms and conditions

## 📱 **Step 2: Create AdMob App**

1. In AdMob Console, click **"Apps"** in the sidebar
2. Click **"Add app"**
3. Choose **"Add your app manually"**
4. Fill in the details:
   - **App name**: NFL Survival Pool
   - **Platform**: Android (create separate entry for iOS)
   - **Package name**: `com.yourcompany.nfl_survival` (must match your app's package name)

## 🔑 **Step 3: Get Ad Unit IDs**

### **Banner Ads**
1. In your app, go to **"Ad units"**
2. Click **"Add ad unit"**
3. Choose **"Banner"**
4. Name it: "NFL Survival Banner"
5. Copy the **Ad Unit ID** (format: `ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx`)

### **Interstitial Ads**
1. Create another ad unit
2. Choose **"Interstitial"**
3. Name it: "NFL Survival Interstitial"
4. Copy the **Ad Unit ID**

### **Rewarded Ads**
1. Create another ad unit
2. Choose **"Rewarded"**
3. Name it: "NFL Survival Rewarded"
4. Copy the **Ad Unit ID**

## 🔧 **Step 4: Update App Configuration**

### **Android Configuration**
1. Open `android/app/src/main/AndroidManifest.xml`
2. Replace the test App ID with your real App ID:
   ```xml
   <meta-data
       android:name="com.google.android.gms.ads.APPLICATION_ID"
       android:value="ca-app-pub-xxxxxxxxxxxxxxxx~xxxxxxxxxx"/>
   ```

### **iOS Configuration**
1. Open `ios/Runner/Info.plist`
2. Replace the test App ID with your real App ID:
   ```xml
   <key>GADApplicationIdentifier</key>
   <string>ca-app-pub-xxxxxxxxxxxxxxxx~xxxxxxxxxx</string>
   ```

### **Flutter Code Configuration**
1. Open `lib/core/services/ad_service.dart`
2. Replace the test Ad Unit IDs with your real ones:
   ```dart
   // Replace these with your real Ad Unit IDs
   static const String _bannerAdUnitIdAndroid = 'ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx';
   static const String _bannerAdUnitIdIOS = 'ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx';
   static const String _interstitialAdUnitIdAndroid = 'ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx';
   static const String _interstitialAdUnitIdIOS = 'ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx';
   static const String _rewardedAdUnitIdAndroid = 'ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx';
   static const String _rewardedAdUnitIdIOS = 'ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx';
   ```

## 🧪 **Step 5: Test Ads**

### **Test Device Setup**
1. In AdMob Console, go to **"Test devices"**
2. Add your test device:
   - **Android**: Use the device's advertising ID
   - **iOS**: Use the device's advertising ID
3. This ensures you see test ads during development

### **Test Ad Unit IDs**
- The current configuration uses Google's test ad unit IDs
- These show test ads and don't generate revenue
- Replace with your real Ad Unit IDs before production

## 📊 **Step 6: Revenue Optimization**

### **Ad Placement Strategy**
- **Banner Ads**: Bottom of screens, between content
- **Interstitial Ads**: Between major actions (after making picks, before viewing results)
- **Rewarded Ads**: For premium features (unlock temporary premium access)

### **Ad Frequency**
- Don't show ads too frequently (user experience)
- Show interstitial ads after meaningful actions
- Use rewarded ads for value exchange

### **A/B Testing**
- Test different ad placements
- Test different ad sizes
- Monitor user engagement and revenue

## 🚨 **Important Notes**

### **App Store Compliance**
- **Google Play Store**: AdMob is required for apps with ads
- **App Store**: Must comply with Apple's advertising guidelines
- **GDPR/CCPA**: Implement proper consent management

### **Revenue Expectations**
- **Banner Ads**: $0.10 - $2.00 per 1000 impressions (CPM)
- **Interstitial Ads**: $1.00 - $5.00 per 1000 impressions (CPM)
- **Rewarded Ads**: $2.00 - $10.00 per 1000 impressions (CPM)

### **Real Ad Unit IDs Required**
- Test ads don't generate revenue
- You must replace test IDs with real ones
- Real ads only show after app store approval

## 🔄 **Step 7: Production Deployment**

1. **Replace all test Ad Unit IDs** with real ones
2. **Test thoroughly** on real devices
3. **Submit to app stores** with real ad configuration
4. **Monitor revenue** in AdMob Console
5. **Optimize** based on performance data

## 📈 **Revenue Tracking**

### **AdMob Console Metrics**
- **Impressions**: Number of ad views
- **Clicks**: Number of ad clicks
- **CTR**: Click-through rate
- **eCPM**: Effective cost per 1000 impressions
- **Revenue**: Total earnings

### **App Analytics**
- Track user engagement with ads
- Monitor app retention after ad implementation
- A/B test ad frequency and placement

## 🛠 **Troubleshooting**

### **Common Issues**
1. **Ads not showing**: Check Ad Unit IDs and network connection
2. **Test ads in production**: Ensure real Ad Unit IDs are used
3. **Low revenue**: Optimize ad placement and frequency
4. **App rejection**: Ensure compliance with store policies

### **Support Resources**
- [AdMob Help Center](https://support.google.com/admob/)
- [Flutter AdMob Plugin](https://pub.dev/packages/google_mobile_ads)
- [Google AdMob Policies](https://support.google.com/admob/answer/6121213)

---

## 🎯 **Next Steps**

1. **Create AdMob account** and get real Ad Unit IDs
2. **Update configuration** with real IDs
3. **Test thoroughly** on real devices
4. **Submit to app stores** for approval
5. **Monitor revenue** and optimize performance

Remember: Test ads don't generate revenue. You need real Ad Unit IDs from your AdMob account for production revenue.
