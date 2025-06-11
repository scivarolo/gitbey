# Feature Spec: GitHub Commit Sentiment to Beyoncé Song Recommendation

## Objective
Implement the core feature that takes a user's GitHub username, analyzes the sentiment of their last 50 public commits, and recommends 5 Beyoncé songs based on the detected vibe. Users should be able to play song previews and share their results as an image.

---

## Step 1: Collect GitHub Username and Fetch Commits
**Objective:** Get the user's GitHub username and retrieve their last 50 public commits.
**Steps:**
- Display an input field for the GitHub username.
- On submit, call the GitHub REST API to fetch the user's last 50 public commits.
- Handle errors (invalid username, network issues, not enough commits).
**Pseudocode:**
```
username = getInput()
commits = fetchCommitsFromGitHub(username, limit=50)
if commits.length < 1:
    showError('No commits found')
```
**User intervention:** User must enter their GitHub username.

---

## Step 2: Sentiment Analysis on Commit Messages
**Objective:** Analyze the sentiment of the commit messages to determine the overall vibe.
**Steps:**
- Extract commit messages from the fetched commits.
- Use a Dart sentiment analysis package or simple rules to score each message.
- Aggregate scores to determine the overall sentiment (e.g., positive, neutral, negative).
**Pseudocode:**
```
sentiments = analyzeSentiment(commitMessages)
overallVibe = aggregateSentiments(sentiments)
```
**User intervention:** None.

---

## Step 3: Map Vibe to Beyoncé Songs
**Objective:** Recommend 5 Beyoncé songs that match the detected vibe.
**Steps:**
- Define a static mapping of sentiment/vibe categories to Beyoncé songs.
- Select 5 songs based on the overall vibe.
**Pseudocode:**
```
songs = getSongsForVibe(overallVibe)
```
**User intervention:** None.

---

## Step 4: Display Results and Enable Song Previews
**Objective:** Show the recommended songs and allow users to play 30-second previews via Spotify.
**Steps:**
- Display the user's GitHub handle, detected vibe, and song list.
- Integrate Spotify Web API to fetch and play song previews.
- Handle errors if a preview is unavailable.
**Pseudocode:**
```
displayResults(username, overallVibe, songs)
for song in songs:
    previewUrl = getSpotifyPreview(song)
    enablePlayButton(previewUrl)
```
**User intervention:** User can play song previews.

---

## Step 5: Share Results as an Image
**Objective:** Allow users to share a visual summary of their results.
**Steps:**
- Render the results (handle, vibe, song list) in a shareable format (canvas or widget).
- Provide a button to export/download/share the image.
**Pseudocode:**
```
image = renderShareableImage(username, overallVibe, songs)
showShareButton(image)
```
**User intervention:** User clicks to share or download the image.

---

## Step 6: Error Handling and Edge Cases
**Objective:** Ensure a smooth user experience for all scenarios.
**Steps:**
- Show clear error messages for invalid usernames, API failures, or insufficient data.
- Suggest trying another username if needed.
**Pseudocode:**
```
if error:
    showError(errorMessage)
```
**User intervention:** User may need to retry or enter a different username.

---

## Notes
- This feature is to be implemented as a Flutter web app. All UI and logic should target the web platform using Flutter's web capabilities.
- Keep UI mobile-first and simple.
- Use an Apple-esque (Cupertino) UI look and feel: prioritize clean lines, subtle gradients, rounded corners, and smooth transitions. Use Cupertino widgets and design patterns in Flutter for iOS-style appearance across platforms.
- No authentication or private data required.
- All APIs used must be public and respect rate limits.

---

This spec provides a step-by-step plan for implementing the core GitBey feature, with objectives, steps, and pseudocode for each part.
