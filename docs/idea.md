# GitBey Proposal

## 1. Product Overview
**Core value proposition:**
GitBey is a playful web app that analyzes a user's last 50 public GitHub commits, determines their overall sentiment, and recommends 5 Beyoncé songs that match the "vibe". Users can listen to song previews via Spotify and share a visual summary of their results.

**Target audience:**
- Developers and tech enthusiasts
- Fans of Beyoncé and pop culture
- Social media users who enjoy sharing quirky, personalized content

---

## 2. Functional Specifications
2.1. User enters their GitHub username to start analysis.
2.2. App fetches the user's last 50 public commits using the GitHub API.
2.3. Sentiment analysis is performed on commit messages to determine the overall mood/vibe.
2.4. The app maps the detected vibe to 5 Beyoncé songs using a predefined mapping.
2.5. Users can play 30-second previews of the recommended songs via the Spotify API.
2.6. Users can share an image of their results (including their GitHub handle, vibe, and song list) on social media.
2.7. The app handles errors gracefully (e.g., invalid username, not enough commits, API issues).

---

## 3. Technical Specifications
- **Platform:** Web app (mobile-first, responsive)
- **Framework:** Flutter (Dart)
- **APIs:**
  - GitHub REST API (public data, no authentication required)
  - Spotify Web API (for song previews)
- **Vibe Analysis:** Sentiment analysis on commit messages (using a Dart package or custom logic)
- **Music Mapping:** Static mapping of sentiment/vibe to Beyoncé songs
- **Sharing:** Generate a shareable image (screenshot or canvas export)
- **No privacy issues:** Only public GitHub data is used; no user authentication required

---

## 4. MVP Scope
- User inputs GitHub username
- Fetch and analyze last 50 public commits for sentiment
- Map sentiment to 5 Beyoncé songs
- Display results with song previews (Spotify)
- Allow user to share a generated image of their results
- Responsive, mobile-friendly UI
- Basic error handling for common edge cases

---

This plan is ready for review. Let me know if you want any changes or if I should proceed to create the GitHub issue.
