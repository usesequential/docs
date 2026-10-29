# Mobile apps (iOS, Android, React Native)

> Use PostHog's open-source mobile SDK and point it at Sequential with your PostHog ingest key and API URL. Events and session replay both arrive.

Sequential has no mobile SDK of its own. It serves the protocol PostHog’s mobile SDKs speak. The key is the project’s **PostHog** ingest key, the same one the web SDK uses. If the app already uses PostHog, change `apiKey` and `host` in its existing setup call and add the replay options. Do not add a second setup call.

## iOS (Swift)

Add the `posthog-ios` package (Swift Package Manager or CocoaPods), then set it up once at launch:

```swift
import PostHog

let config = PostHogConfig(apiKey: "YOUR_POSTHOG_INGEST_KEY", host: "https://api.usesequential.com")
config.sessionReplay = true
config.sessionReplayConfig.screenshotMode = true // required for SwiftUI screens
PostHogSDK.shared.setup(config)
```

- **SwiftUI: name your screens.** Automatic screen capture reports the same hosting-controller class for every SwiftUI screen, so add `.postHogScreenView("Checkout")` to each screen, or call `PostHogSDK.shared.screen("Checkout")`.
- **Masking happens on the device.** As of posthog-ios 3.92.0, text inputs and images are masked by default. With the setup above (screenshot mode), the replay masks every text, text field and button, in SwiftUI views and in UIKit views. On 18 October 2026, Sequential tested this with a real app on the iOS simulator. Opt a view out with `.postHogNoMask()` only where that is safe. Mask custom secure views (a PIN pad, for example) yourself. The project’s masking settings in Sequential do not apply to mobile.
- **Text fields can send what people type.** As of posthog-ios 3.92.0, `config.captureElementInteractions` is off by default, and the setup above does not turn it on. If your app turns it on, the SDK sends an `$autocapture` event each time a person stops editing a `UITextField` or a `UITextView`. A SwiftUI `TextField` uses a `UITextField`, so this applies to it too. The SDK sends the event when the field loses focus. The event carries the text of the field, up to 255 characters. An empty field sends no text, and not its placeholder. The SDK does not remove card numbers, emails or names from it. From 18 October 2026, Sequential stores an email, a card number, a JWT or a Bearer or Basic credential in this text as `[redacted]`. If the SDK cut the text, 9 or more digits or the start of an email just before the cut become `[redacted]` too. On 18 October 2026, Sequential tested this with a real SwiftUI app on the iOS simulator: it stored a typed card number and an email as `[redacted]`. Names, phone numbers, addresses and other text stay as typed, and events stored before that date keep the text. The people in your project can see the stored text in the dashboard, but agent tools never get it. To keep a field out, do one of these:
  - Use secure entry: `isSecureTextEntry = true`, or a SwiftUI `SecureField`.
  - Set a sensitive `textContentType` on the field, for example `.creditCardNumber`, `.emailAddress`, `.telephoneNumber`, `.password`, `.oneTimeCode`, `.familyName`, `.fullStreetAddress` or `.postalCode`. The SDK has a list of 23 such types. `.givenName` (the first name) is not on the list.
  - Put `ph-no-capture` in the `accessibilityIdentifier` or the `accessibilityLabel` of a UIKit view. The SDK then sends no event from that view or from a view in it. On a SwiftUI text field, put it in the identifier, for example `.accessibilityIdentifier("ph-no-capture-card")`.
  - To send no element text from the whole app, set `config.captureAutocaptureElementText = false`. The SDK still sends taps, with the `postHogLabel` ids of your views. Your own events and session replay do not change.
- **Taps send some text too.** With `captureElementInteractions` on, a tap on a UIKit button sends its title. A tap on a label sends no text. With `config.captureSwiftUIElementInteractions` on (off by default), a tap on a SwiftUI view sends its `postHogLabel` or its accessibility identifier, not its visible text. Do not put personal data in button titles or in accessibility identifiers.

## Android (Kotlin)

Add the `com.posthog:posthog-android` dependency, then set it up in `Application.onCreate()`:

```kotlin
import com.posthog.android.PostHogAndroid
import com.posthog.android.PostHogAndroidConfig

val config = PostHogAndroidConfig(apiKey = "YOUR_POSTHOG_INGEST_KEY", host = "https://api.usesequential.com")
config.sessionReplay = true
config.sessionReplayConfig.screenshot = true // required for Jetpack Compose screens
PostHogAndroid.setup(this, config) // in Application.onCreate()
```

- **Masking happens on the device.** As of posthog-android 3.72.3, `maskAllTextInputs` is on by default. In screenshot mode, this setting masks every Jetpack Compose `Text`, not only the text fields. The replay then shows black bars in place of the text. Opt a composable out with `Modifier.postHogUnmask()` only where that is safe. The project’s masking settings in Sequential do not apply to mobile.
- **Tested with a real app.** On 18 October 2026, Sequential stored and played the replay of a Jetpack Compose app with posthog-android 3.72.3 on the Android emulator. iOS replay is tested with a real app on the iOS simulator.

## React Native

Add `posthog-react-native` and wrap the app. **React Native (and Flutter, via `posthog_flutter`) are accepted but not yet verified** against Sequential. After you install, check **Sources** on Settings › Setup.

```tsx
import { PostHogProvider } from 'posthog-react-native';

<PostHogProvider
  apiKey="YOUR_POSTHOG_INGEST_KEY"
  options={{ host: "https://api.usesequential.com", enableSessionReplay: true }}
>
  {/* your app */}
</PostHogProvider>
```

## What is supported

Recording is switched on per platform in Sequential (Settings › Recording & data › **Record on**: Web, iOS, Android), with **Share of sessions recorded** and **Shortest session kept**. The SDK caches that config and picks up a change on its next launch with network. Revoking the PostHog key stops events and replay on the next launch.

What Sequential does with PostHog (mobile) traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Yes | Same wire protocol as web (`/batch`, gzipped). |
| Page / screen views | Yes | `$screen` events. |
| Autocaptured clicks & forms | Partial | Whatever the SDK's own autocapture sends as `$autocapture` is classified; mobile autocapture varies by platform. |
| Identify (user id) | Yes | Top-level `distinct_id`. |
| User properties | Partial | As on web: kept on the event, not stored as user properties. |
| Groups / accounts | No | As on web. |
| Errors | Partial | Manually captured `$exception` events only. |
| Session replay | Yes | PostHog's mobile session replay (iOS, Android) is stored as sent and played in Sequential. iOS replay is tested with a real app on the iOS simulator. Android replay is tested with a real Jetpack Compose app on the Android emulator (posthog-android 3.72.3). Masking is set in the SDK on the device. React Native and Flutter are accepted but unverified. |
| DevTools: errors, console, network, performance | Partial | No JavaScript errors or page performance. Console logs only when the project records message text and the app sets iOS `captureLogs` (Android logcat is on by default). Network timing: iOS URLSession by default, Android needs `PostHogOkHttpInterceptor`. Flutter: none. See [Mobile apps](/docs/mobile). |
| Feature flags, surveys, experiments | No | As on web. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Server-side SDK user agents are rejected as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

## Enable DevTools on mobile (optional)

The replay’s DevTools drawer can show a mobile app’s console logs and network timing. Both need a setting in the app that the setup above deliberately leaves out. **Add them only if the user asks for them.**

- **Logs**: Sequential asks the app for logs only when the project turns on **Console message text** (Settings › Recording & data › **What a recording carries**). On iOS the app must also opt in:

```swift
config.sessionReplayConfig.captureLogs = true // optional: console logs for DevTools
```

Android sends logcat by default. The mobile SDK always sends message text; Sequential keeps it only because that setting is on.
- **Network**: timing, status and size per request, following the project’s *Network requests* switch. iOS records URLSession requests by default. Android needs PostHog’s interceptor on the OkHttp client:

```kotlin
import com.posthog.android.PostHogOkHttpInterceptor

// optional: network timing for DevTools, on the OkHttp client your app already builds
val client = OkHttpClient.Builder()
  .addInterceptor(PostHogOkHttpInterceptor())
  .build()
```

Mobile network rows are metrics only: method, URL with query values redacted, status, duration and size. PostHog’s SDKs never send headers or bodies. JavaScript errors and page performance are web only. React Native: `captureLog` (on by default) maps to iOS `captureLogs`, and network telemetry is iOS only. Flutter sends neither.

Only PostHog’s mobile SDKs are supported on mobile. Mixpanel and Amplitude native SDKs are not supported, and neither are Smartlook’s. Server-side SDKs of other tools are rejected. To send events from your own server, use Sequential’s [backend SDK for Node](/docs/backend-sdk).

## Check it works

1. Build and run the app on a device or simulator and move through a few screens.
2. In Sequential, Settings › Setup shows PostHog as "receiving" within about a minute of the first event. The first recording shows in Workbench › **Sessions** when the app was in the foreground for the shortest session kept, and up to about 6 minutes later.
3. Nothing arriving: check the key is the PostHog one and `host` has no trailing path. Recording starts only when the app is active with no system alert on top.
