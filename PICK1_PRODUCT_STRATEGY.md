# Pick1 Product Strategy: 90-Day Monetization & Growth Plan

**Product Director Strategy Document**  
**Target Metric:** Weekly Active Pickers (WAP)  
**Focus:** Engagement, Retention, Revenue without compromising fairness or fun

---

## 1. 90-DAY MONETIZATION & UX ROADMAP

### Week 1-2: Foundation & Quick Wins (Theme: Reduce Friction)
**Goal:** Improve on-time pick rate by 15%, establish baseline metrics  
**Effort:** S-M

| Feature | Effort | Primary KPI | Secondary KPI |
|---------|--------|-------------|---------------|
| Pick Reminders (T-24h, T-2h, T-15m) | S | On-time pick rate | User complaints |
| "Almost Locked" banner on home | S | Pick abandonment rate | Session duration |
| Basic event tracking implementation | M | Data completeness | Dashboard accuracy |

### Week 3-4: Social Foundation (Theme: Viral Mechanics)
**Goal:** Increase friend invites by 25%, improve D7 retention by 10%  
**Effort:** M

| Feature | Effort | Primary KPI | Secondary KPI |
|---------|--------|-------------|---------------|
| Shareable "I survived Week X" cards | M | Share rate | Organic installs |
| Friend activity feed ("Nina locked BUF") | M | Session frequency | Friend connections |
| Referral reward system (1 month premium) | M | Invite acceptance rate | Premium conversion |

### Week 5-6: Premium Value Prop (Theme: Upgrade Intent)
**Goal:** Increase paywall view→start by 20%, premium conversion by 15%  
**Effort:** M-L

| Feature | Effort | Primary KPI | Secondary KPI |
|---------|--------|-------------|---------------|
| Multi-league dashboard (premium) | L | Premium conversion | Feature usage |
| Live score widgets in feed | M | Paywall intent | Session duration |
| Blurred live score preview (freemium) | S | Paywall views | Bounce rate |

### Week 7-8: Engagement Depth (Theme: Mastery & Habit)
**Goal:** Increase weekly sessions by 30%, improve D30 retention by 12%  
**Effort:** M

| Feature | Effort | Primary KPI | Secondary KPI |
|---------|--------|-------------|---------------|
| Streak badges & achievements | M | Return rate | Achievement unlock rate |
| Weekly recap notifications | S | Monday engagement | Notification CTR |
| AI News topic follows (teams/players) | M | News engagement | Premium conversion |

### Week 9-10: Monetization Optimization (Theme: Revenue Growth)
**Goal:** Increase ARPU by 25%, reduce churn by 20%  
**Effort:** M

| Feature | Effort | Primary KPI | Secondary KPI |
|---------|--------|-------------|---------------|
| Dynamic paywall optimization | M | Conversion rate | Revenue per user |
| Commissioner Pack (group subscriptions) | M | Group conversion | League retention |
| Advanced pick analytics (premium) | M | Feature adoption | Upgrade intent |

### Week 11-12: Platform & Scale (Theme: Growth Infrastructure)
**Goal:** Support 2x user growth, improve app store ratings to 4.5+  
**Effort:** L

| Feature | Effort | Primary KPI | Secondary KPI |
|---------|--------|-------------|---------------|
| iOS Live Activities / Android widgets | L | Daily active users | Pick completion rate |
| Performance optimizations | M | Crash-free rate | Load times |
| Advanced league customization | M | Premium retention | Feature usage |

---

## 2. PRD #1: Pick Reminders + "Almost Locked" Banner

**Title:** Smart Pick Reminders & Lock Warning System  
**Problem:** 35% of users miss weekly picks due to forgetting or not knowing lock times, leading to elimination and churn.  
**Goal / Metric:** Primary: Increase on-time pick rate from 65% to 80%. Secondary: Reduce weekly churn by 15%, improve user satisfaction scores.  
**Audience / JTBD:** All active users who want to stay competitive in their leagues without constantly checking lock times.

**Solution (MVP):**
- **Notification System:** T-24h ("Week X picks open"), T-2h ("Picks lock soon"), T-15m ("Final warning") 
- **Home Banner:** "Almost Locked! X minutes remaining" when <2 hours to lock
- **Pick Screen:** Countdown timer with color coding (green>2h, yellow<2h, red<30m)
- **Smart Suppression:** Skip notifications if user already picked
- **Timezone Handling:** All times rendered in user's local timezone

**Free vs Premium Behavior:**
- Free: Basic reminders (T-24h, T-2h only)
- Premium: All reminders + custom timing preferences

**Out-of-Scope:** 
- Custom notification text per user
- SMS reminders
- Calendar integration
- Multiple league reminder consolidation

**Instrumentation:**
```json
Events: notification_sent, notification_opened, banner_viewed, banner_clicked, pick_after_reminder
Properties: reminder_type, time_to_lock, user_timezone, league_count
Dashboard: Reminder effectiveness, pick timing distribution, churn correlation
```

**Variants (A/B):**
- **A:** Standard timing (T-24h, T-2h, T-15m)
- **B:** Aggressive timing (T-48h, T-4h, T-30m, T-5m)
- **C:** Personalized timing based on user's historical pick patterns

**Risks & Mitigations:**
- **Risk:** Notification fatigue → **Mitigation:** Frequency caps, easy opt-out
- **Risk:** Timezone bugs → **Mitigation:** Comprehensive timezone testing
- **Risk:** Server load on reminder dispatch → **Mitigation:** Batch processing, queue management

**Acceptance Criteria:**
- Quantitative: 80% on-time pick rate, <2% notification complaint rate, 99.9% delivery accuracy
- Qualitative: User feedback scores >4.0, no timezone-related support tickets

**Estimate:** S (2 weeks) - leveraging existing notification infrastructure

**Appendix:**
```
Notification Templates:
T-24h: "⚡ Week X picks are open! Lock in your survivor pick before Thursday 8:20 PM"
T-2h: "⏰ Picks lock in 2 hours! Don't get eliminated - make your Week X pick now"
T-15m: "🚨 FINAL WARNING: Picks lock in 15 minutes! Tap to pick now"

Banner Copy: "⚡ Almost Locked! {X} minutes remaining to make your Week {Y} pick"
```

---

## 3. PRD #2: Premium Multi-League Dashboard + Live Score Widgets

**Title:** Premium Multi-League Command Center  
**Problem:** Premium users managing multiple leagues lack a unified view, reducing engagement and perceived value of subscription.  
**Goal / Metric:** Primary: Increase premium user session frequency by 40%. Secondary: Improve premium retention by 25%, increase feature adoption to 80%.  
**Audience / JTBD:** Premium subscribers who participate in multiple leagues and want efficient league management and real-time updates.

**Solution (MVP):**
- **Dashboard Overview:** All leagues in card format with key stats (survivors, your status, next deadline)
- **Live Score Widgets:** Real-time scores for games affecting your picks, embedded in feed
- **Quick Actions:** One-tap pick submission across leagues, bulk operations
- **Status Indicators:** Visual health check (picked/not picked, safe/at risk, eliminated)
- **League Comparison:** Side-by-side performance across leagues

**Free vs Premium Behavior:**
- Free: Single league view only, no live scores, static data
- Premium: Multi-league dashboard, live scores, real-time updates, advanced filters

**Out-of-Scope:**
- League creation from dashboard
- Cross-league pick copying
- Advanced analytics/reporting
- Commissioner tools integration

**Instrumentation:**
```json
Events: dashboard_view, league_card_click, quick_pick_submit, live_score_view, widget_interaction
Properties: league_count, pick_status, score_update_frequency, session_duration
Dashboard: Feature adoption rate, engagement lift, premium retention correlation
```

**Variants (A/B):**
- **A:** Card-based layout with horizontal scroll
- **B:** List-based layout with vertical scroll
- **C:** Hybrid layout with priority league featured

**Risks & Mitigations:**
- **Risk:** Live score API costs → **Mitigation:** Smart caching, rate limiting
- **Risk:** Performance with many leagues → **Mitigation:** Pagination, lazy loading
- **Risk:** Data sync issues → **Mitigation:** Offline-first architecture, conflict resolution

**Acceptance Criteria:**
- Quantitative: 80% feature adoption, 40% session frequency increase, <3s load time
- Qualitative: User satisfaction >4.2, premium value perception increase

**Estimate:** L (4 weeks) - new UI patterns, live data integration, performance optimization

**Appendix:**
```
Widget Types:
- League Status Card: "{League Name} • {X} survivors • You: {Status} • Next: {Deadline}"
- Live Score Ticker: "{Team1} {Score1} - {Score2} {Team2} • {Quarter} {Time}"
- Quick Pick Button: "Pick {Team} for Week {X}" with confidence indicator

Paywall Trigger: "Upgrade to Premium to manage all your leagues in one place + live scores"
```

---

## 4. PRICING & PACKAGING STRATEGY

### Tier Structure & Value Proposition

| Feature | Free | Monthly Premium | Season Pass | Annual Premium |
|---------|------|----------------|-------------|----------------|
| **Price** | €0 | €4.99 | €14.99 | €29.99 |
| **Leagues** | 1 | Unlimited | Unlimited | Unlimited |
| **Live Scores** | ❌ | ✅ | ✅ | ✅ |
| **Ads** | Banner ads | Ad-free | Ad-free | Ad-free |
| **Reminders** | Basic (2) | All + Custom | All + Custom | All + Custom |
| **AI News** | 2/day | Unlimited + Topics | Unlimited + Topics | Unlimited + Topics |
| **League Dashboard** | ❌ | ✅ | ✅ | ✅ |
| **Advanced Analytics** | ❌ | ✅ | ✅ | ✅ |
| **Priority Support** | ❌ | ✅ | ✅ | ✅ |

### Commissioner Pack Add-On
- **Price:** +€9.99/month or +€19.99/season
- **Value:** Pay for up to 12 league members' premium features
- **Target:** League organizers, office pools, friend groups

### Regional Pricing Strategy

| Region | Monthly | Season | Annual | Rationale |
|--------|---------|--------|--------|-----------|
| **US/Canada** | $5.99 | $17.99 | $34.99 | Premium sports market |
| **EU** | €4.99 | €14.99 | €29.99 | Base pricing |
| **UK** | £4.49 | £13.49 | £26.99 | Brexit-adjusted |
| **Emerging** | $2.99 | $8.99 | $17.99 | Purchasing power parity |

### Trial & Onboarding Strategy
- **Free Trial:** 14 days for new users (vs no trial test)
- **Introductory Offer:** 50% off first month
- **Referral Credit:** 1 month free when friend subscribes
- **Win-back Offer:** 3 months for €9.99 for churned users

---

## 5. EXPERIMENT PLAN

### Experiment #1: Paywall Copy Optimization
**Hypothesis:** Value-first copy increases conversion by 20% vs feature-list copy  
**Primary Metric:** Paywall view → subscription start rate  
**Guardrails:** Subscription quality (no increase in immediate churn)  
**Variants:**
- A (Control): "Unlock Premium Features: Multiple leagues, live scores, no ads"
- B (Value): "Never miss the action: Join unlimited leagues and get live scores"
- C (Social): "Join your friends in multiple leagues with live updates"
**Sample Size:** 2,400 users per variant (80% power, 5% significance)  
**Runtime:** 2 weeks  
**Decision Rule:** Ship winner if >15% lift with <5% churn increase

### Experiment #2: Pre-Lock Reminder Cadence
**Hypothesis:** More frequent reminders increase on-time picks by 12%  
**Primary Metric:** On-time pick rate  
**Guardrails:** Notification complaint rate <3%  
**Variants:**
- A (Control): T-24h, T-2h
- B (Aggressive): T-48h, T-4h, T-30m
- C (Smart): Personalized based on user behavior
**Sample Size:** 1,800 users per variant  
**Runtime:** 4 weeks (multiple NFL weeks)  
**Decision Rule:** Ship if >8% improvement with complaint rate <3%

### Experiment #3: Price Ladder Test
**Hypothesis:** €3.99 monthly price increases volume enough to offset lower ARPU  
**Primary Metric:** Monthly revenue per visitor  
**Guardrails:** Premium user satisfaction maintained  
**Variants:**
- A (Control): €4.99/month
- B (Lower): €3.99/month
- C (Higher): €5.99/month
**Sample Size:** 3,000 users per variant  
**Runtime:** 4 weeks  
**Decision Rule:** Ship price with highest revenue per visitor

### Experiment #4: Trial vs No Trial
**Hypothesis:** 14-day trial increases LTV despite lower immediate conversion  
**Primary Metric:** 90-day LTV  
**Guardrails:** Trial-to-paid conversion >25%  
**Variants:**
- A (Control): No trial, direct purchase
- B (Trial): 14-day free trial
**Sample Size:** 2,000 users per variant  
**Runtime:** 6 weeks + 90-day follow-up  
**Decision Rule:** Ship trial if LTV increase >10%

### Experiment #5: Referral Reward Amount
**Hypothesis:** 1 month free reward optimizes invite rate vs cost  
**Primary Metric:** Successful referrals per user  
**Guardrails:** Referral quality (friend retention >50%)  
**Variants:**
- A (Control): No referral reward
- B (Low): 2 weeks free
- C (Medium): 1 month free
- D (High): 2 months free
**Sample Size:** 1,500 users per variant  
**Runtime:** 6 weeks  
**Decision Rule:** Ship reward level with best ROI (referrals × LTV - cost)

---

## 6. EVENT TAXONOMY

### Core User Journey Events

```csv
Event Name,Description,Required Properties,Optional Properties
auth_signup,User creates account,user_id|signup_method|timestamp,referral_code|utm_source
auth_login,User logs in,user_id|login_method|timestamp,session_id
league_create,User creates new league,user_id|league_id|visibility|timestamp,settings_hash|member_limit
league_join,User joins existing league,user_id|league_id|join_method|timestamp,invite_code|referrer_id
league_view,User views league details,user_id|league_id|timestamp,member_count|user_status
pick_open,User opens pick selection,user_id|league_id|week|timestamp,time_to_lock_minutes
pick_submit,User submits weekly pick,user_id|league_id|week|team|timestamp,confidence_level
pick_locked_view,User views after lock time,user_id|league_id|week|timestamp,missed_pick
pick_missed,User failed to pick before lock,user_id|league_id|week|timestamp,reminder_count
```

### Monetization Events

```csv
Event Name,Description,Required Properties,Optional Properties
paywall_view,Paywall displayed to user,user_id|trigger|timestamp,league_count|feature_blocked
paywall_dismiss,User closes paywall,user_id|trigger|timestamp,dismiss_method
sub_start,Subscription initiated,user_id|plan|price|timestamp,trial_days|payment_method
sub_complete,Subscription payment successful,user_id|plan|price|transaction_id|timestamp,promo_code
sub_restore,Subscription restored,user_id|plan|timestamp,platform
sub_cancel,Subscription cancelled,user_id|plan|timestamp,reason|refund_requested
sub_renew,Subscription renewed,user_id|plan|price|timestamp,renewal_count
```

### Engagement Events

```csv
Event Name,Description,Required Properties,Optional Properties
scores_view,User views live scores,user_id|week|timestamp,league_id|game_count
news_view,User reads AI news article,user_id|article_id|timestamp,topic|read_duration
news_share,User shares news article,user_id|article_id|share_method|timestamp,recipient_count
invite_send,User sends league invitation,user_id|league_id|method|timestamp,recipient_count
invite_accept,Invitation accepted,user_id|league_id|inviter_id|timestamp,time_to_accept
friend_connect,Users become friends,user_id|friend_id|timestamp,connection_method
achievement_unlock,User earns achievement,user_id|achievement_id|timestamp,streak_count
```

---

## 7. NOTIFICATION STRATEGY

### Reminder Notifications

| Type | Timing | Title Template | Body Template | CTA |
|------|--------|----------------|---------------|-----|
| **Pick Open** | T-24h | "⚡ Week {week} picks are open!" | "Lock in your survivor pick for {league_name} before {lock_time}" | "Make Pick" |
| **Pick Soon** | T-2h | "⏰ Picks lock in 2 hours!" | "Don't get eliminated - make your Week {week} pick now" | "Pick Now" |
| **Final Warning** | T-15m | "🚨 FINAL WARNING" | "Picks lock in 15 minutes! Tap to pick now or risk elimination" | "Emergency Pick" |

### Result Notifications

| Type | Timing | Title Template | Body Template | CTA |
|------|--------|----------------|---------------|-----|
| **Survived** | Monday 9AM | "🎉 You survived Week {week}!" | "Great pick! {survivors_count} players remain in {league_name}" | "View League" |
| **Eliminated** | Monday 9AM | "💔 Week {week} elimination" | "Your {team} pick didn't work out. Better luck in your other leagues!" | "Join New League" |
| **League Winner** | Season End | "🏆 League Champion!" | "Congratulations! You won {league_name} and outlasted {total_players} players" | "Share Victory" |

### Social Notifications

| Type | Trigger | Title Template | Body Template | CTA |
|------|---------|----------------|---------------|-----|
| **Friend Joined** | Real-time | "{friend_name} joined your league!" | "Welcome {friend_name} to {league_name}. May the best picker win!" | "View League" |
| **Invite Accepted** | Real-time | "Invitation accepted!" | "{friend_name} accepted your invitation to {league_name}" | "View League" |
| **Friend Streak** | Weekly | "{friend_name} is on fire! 🔥" | "They've survived {streak_count} weeks in a row. Can you beat that?" | "View Streak" |

### AI News Notifications

| Type | Timing | Title Template | Body Template | CTA |
|------|--------|----------------|---------------|-----|
| **Breaking News** | Real-time | "🚨 Breaking: {headline}" | "{summary_snippet}... Tap for full AI analysis" | "Read More" |
| **Daily Brief** | 6AM, 12PM, 6PM | "📰 NFL Brief: {top_story}" | "Your AI reporter has {article_count} stories including {topics}" | "Read Brief" |
| **Pregame Brief** | Sunday 10AM | "🏈 Sunday Pregame Brief" | "Key injuries, weather, and upset alerts for today's games" | "Read Analysis" |

### Notification Frequency Rules
- **Maximum per day:** 4 notifications
- **Quiet hours:** 10PM - 7AM local time
- **Suppression logic:** Skip if user already completed action
- **Opt-out granularity:** By category (reminders, results, social, news)
- **Premium benefit:** Custom timing preferences

---

## 8. PAYWALL SPECIFICATION

### Trigger Conditions

| Trigger | Condition | Copy Variant | Timing |
|---------|-----------|--------------|--------|
| **Second League** | User attempts to join 2nd league | Value-focused | Immediate |
| **Live Scores** | User taps live score widget | Feature-focused | Immediate |
| **Custom Settings** | User tries to modify league settings | Social-focused | Immediate |
| **Advanced Analytics** | User views pick history/stats | Data-focused | Immediate |
| **Ad Fatigue** | 10+ ad impressions in session | Experience-focused | After 10th ad |

### Copy Variants

#### Variant A: Value-First
**Title:** "Never Miss the Action"  
**Subtitle:** "Join unlimited leagues and get live scores"  
**Benefits:**
- ⚡ Real-time game scores
- 🏈 Unlimited league participation  
- 🎯 Advanced pick analytics
- 🚫 Ad-free experience

**CTA:** "Start Free Trial" / "Upgrade Now"

#### Variant B: Social-First
**Title:** "Join All Your Friends"  
**Subtitle:** "Compete in multiple leagues with live updates"  
**Benefits:**
- 👥 Play with all your friend groups
- 📱 Live score notifications
- 🏆 Track your performance across leagues
- ✨ Premium experience

**CTA:** "Connect with Friends" / "Go Premium"

#### Variant C: Data-First
**Title:** "Make Smarter Picks"  
**Subtitle:** "Get live data and advanced analytics"  
**Benefits:**
- 📊 Real-time game data
- 📈 Advanced pick analytics
- 🎯 Performance tracking
- 🧠 AI-powered insights

**CTA:** "Get Smart Data" / "Upgrade"

### Paywall UI Elements
- **Hero Image:** Football action shot (no team logos)
- **Benefit Icons:** Custom-designed, consistent style
- **Social Proof:** "Join 10,000+ premium pickers"
- **Money-back Guarantee:** "Cancel anytime, full refund"
- **Close Button:** Small X in top-right (not prominent)

---

## 9. FEATURE GATING MATRIX

### Core Features

| Feature | Free | Premium | Notes |
|---------|------|---------|-------|
| **Account Creation** | ✅ | ✅ | Always free |
| **Join 1 League** | ✅ | ✅ | Core functionality |
| **Make Weekly Picks** | ✅ | ✅ | Never gated |
| **View League Standings** | ✅ | ✅ | Essential feature |
| **Basic Notifications** | ✅ | ✅ | T-24h, T-2h only |

### Premium Features

| Feature | Free | Premium | Grace Period | Trial Access |
|---------|------|---------|--------------|--------------|
| **Multiple Leagues** | ❌ | ✅ | 3 days | ✅ |
| **Live Scores** | Preview only | ✅ | 1 day | ✅ |
| **Ad-free Experience** | ❌ | ✅ | Immediate | ✅ |
| **Custom Reminders** | ❌ | ✅ | N/A | ✅ |
| **AI News Unlimited** | 2/day limit | ✅ | N/A | ✅ |
| **Advanced Analytics** | ❌ | ✅ | N/A | ✅ |
| **Priority Support** | ❌ | ✅ | N/A | ❌ |

### Edge Cases & Rules

| Scenario | Behavior | Rationale |
|----------|----------|-----------|
| **Trial Expired** | 24h grace period for core features | Reduce churn friction |
| **Payment Failed** | 7-day grace period, then downgrade | Allow payment resolution |
| **Subscription Cancelled** | Access until period end | Honor paid period |
| **Refund Requested** | Immediate downgrade | Prevent abuse |
| **Family Sharing** | Each account needs subscription | Revenue protection |

---

## 10. RISK REGISTER

### Technical Risks

| Risk | Impact | Probability | Mitigation | Owner |
|------|--------|-------------|------------|-------|
| **Live Score API Downtime** | High | Medium | Backup providers, graceful degradation | Engineering |
| **Push Notification Failures** | High | Low | Multiple providers, retry logic | Engineering |
| **Database Performance** | Medium | Medium | Caching, query optimization | Engineering |
| **App Store Rejection** | High | Low | Policy compliance review | Product |

### Business Risks

| Risk | Impact | Probability | Mitigation | Owner |
|------|--------|-------------|------------|-------|
| **NFL Season Cancellation** | Critical | Very Low | Diversify to other sports | Product |
| **Competitor Launch** | Medium | High | Feature differentiation, user loyalty | Product |
| **Economic Downturn** | Medium | Medium | Freemium model, price flexibility | Business |
| **User Acquisition Cost Rise** | Medium | High | Organic growth, referrals | Marketing |

### Legal & Compliance Risks

| Risk | Impact | Probability | Mitigation | Owner |
|------|--------|-------------|------------|-------|
| **NFL IP Infringement** | High | Low | No logos, "not affiliated" copy | Legal |
| **Gambling Regulation** | Critical | Low | Skill-based positioning, legal review | Legal |
| **GDPR/Privacy Violations** | High | Low | Privacy by design, regular audits | Legal |
| **App Store Policy Changes** | Medium | Medium | Policy monitoring, compliance buffer | Product |

### Operational Risks

| Risk | Impact | Probability | Mitigation | Owner |
|------|--------|-------------|------------|-------|
| **Key Personnel Loss** | Medium | Medium | Documentation, cross-training | Operations |
| **Data Breach** | High | Low | Security audits, encryption | Security |
| **Server Capacity** | Medium | Medium | Auto-scaling, monitoring | Engineering |
| **Customer Support Overload** | Low | High | Self-service, chatbot | Operations |

---

## SUCCESS METRICS & TARGETS

### North Star Metric
**Weekly Active Pickers (WAP):** Users who submit ≥1 valid weekly pick
- **Current Baseline:** TBD (establish in Week 1)
- **90-Day Target:** 25% increase from baseline
- **Measurement:** Weekly cohort analysis, seasonal adjustment

### Supporting KPIs & Targets

| Category | Metric | Current | 30-Day Target | 90-Day Target |
|----------|--------|---------|---------------|---------------|
| **Conversion** | Free→Premium % | TBD | 8% | 12% |
| **Conversion** | Paywall View→Start % | TBD | 15% | 20% |
| **Retention** | D1 Retention | TBD | 75% | 80% |
| **Retention** | D7 Retention | TBD | 45% | 55% |
| **Retention** | On-time Pick Rate | 65% | 75% | 80% |
| **Engagement** | Leagues per User | TBD | 1.3 | 1.5 |
| **Engagement** | Friend Invites Sent | TBD | +50% | +100% |
| **Monetization** | ARPU (Monthly) | TBD | +20% | +40% |
| **Monetization** | Premium Churn Rate | TBD | <8% | <5% |
| **Health** | Crash-free Rate | TBD | 99.5% | 99.8% |
| **Health** | App Store Rating | TBD | 4.2 | 4.5 |

### Measurement Formulas

```
WAP = COUNT(DISTINCT user_id WHERE pick_submitted = true AND week = current_week)
Conversion Rate = (Premium Subscriptions / Paywall Views) × 100
On-time Pick Rate = (Picks Before Lock / Total Picks) × 100
D7 Retention = (Users Active Day 7 / Users Registered Day 0) × 100
ARPU = Total Revenue / Total Active Users
Churn Rate = (Cancelled Subscriptions / Total Subscriptions) × 100
```

---

## NEXT STEPS & IMPLEMENTATION

### Immediate Actions (Week 1)
1. **Analytics Setup:** Implement event tracking for baseline measurement
2. **A/B Test Infrastructure:** Prepare experimentation framework
3. **Notification System:** Build reminder notification pipeline
4. **Paywall Implementation:** Create dynamic paywall system

### Success Criteria for Roadmap Continuation
- **Week 4:** On-time pick rate >75%, event tracking >95% complete
- **Week 8:** Premium conversion >10%, D7 retention >50%
- **Week 12:** WAP growth >20%, app store rating >4.2

### Iteration & Learning Plan
- **Weekly Reviews:** Metric dashboards, experiment results
- **Monthly Deep Dives:** User research, competitive analysis
- **Quarterly Strategy Updates:** Roadmap adjustments, new opportunities

---

*This strategy document serves as the foundation for Pick1's growth trajectory. All initiatives should be measured against the North Star metric of Weekly Active Pickers while maintaining the core principles of fairness, fun, and social engagement.*
