# Mobile apps (iOS, Android, React Native)

> Use PostHog's open-source mobile SDK and point it at Sequential with your PostHog ingest key and API URL. Events and session replay both arrive.

> **In short**
>
> - Sequential has no mobile SDK of its own. It serves the protocol PostHog’s mobile SDKs speak.
> - Use the project’s PostHog ingest key (`sq_posthog_…`), not the Sequential browser key (`sq_sequential_…`).
> - On iOS and Android, masking happens on the device. The project’s masking settings in Sequential do not apply to mobile.
> - After you install, open one replay. On iOS it can be all black: see step 4 in [Check it works](#check-it-works).

## Choose the SDK for your platform

Before you start:

1. Get the project’s PostHog ingest key. It starts with `sq_posthog_`. It is the same key that posthog-js uses on a website. To find it, see [Where the values come from](/docs/install#where-the-values-come-from). Do not use the Sequential browser key (`sq_sequential_…`): Sequential refuses that key from a mobile app.
2. Recording is switched on per platform in **Settings › Recording & data › Record on**.

Then choose the SDK for your platform:

| Platform | SDK | Status |
|---|---|---|
| [iOS (Swift)](#ios-swift) | `posthog-ios` | Replay tested with a real app on the iOS simulator |
| [Android (Kotlin)](#android-kotlin) | `com.posthog:posthog-android` | Replay tested with a real Jetpack Compose app on the Android emulator |
| [React Native](#react-native) | `posthog-react-native` | Accepted but not yet verified |
| Flutter | `posthog_flutter` | Accepted but not yet verified. This page has no Flutter snippet. |

### When do changes to Record on and to the key take effect?

Recording is switched on per platform in Sequential (Settings › Recording & data › Record on: Web, iOS, Android), with Share of sessions recorded and Shortest session kept. The SDK caches that config and picks up a change on its next launch with network. Revoking the PostHog ingest key stops events and replay on the next launch.

### For coding agents

If the person has no Sequential key yet, create a trial for them. Do not leave a placeholder key in the code. The key starts with `sq_posthog_`. If the key that you have starts in a different way, for example `sq_sequential_` (the key of the Sequential browser SDK), stop and ask the person for the project’s PostHog key. Do not put that key in the app: Sequential refuses it with 401 `unknown_ingest_key`, and on Android the SDK then drops the events with no error. Send one call: `POST https://api.usesequential.com/api/agent/provision` with the JSON body `{"owner_email": "<the person's email>", "platform": "ios"}` (or `android`, `react-native`). Ask the person for their email if you do not have it. The answer has the key and the snippet. Until the person claims the trial, it records no replays and keeps up to 100 sessions. Sequential sends the person an email with a claim link. Tell the person to claim the trial within 72 hours. If nobody claims it, Sequential erases it. See [Let your agent set up a trial](/docs/agent-trial).

The setup code on this page leaves out the DevTools settings of [Enable DevTools on mobile (optional)](#enable-devtools-on-mobile-optional) on purpose. Add them only if the user asks for them.

## iOS (Swift)

1. Add the `posthog-ios` package (Swift Package Manager or CocoaPods).
2. Set it up once at launch with this code. If the app already uses PostHog, change `apiKey` and `host` in its existing setup call and add the replay options. Do not add a second setup call.

```swift
import PostHog

let config = PostHogConfig(apiKey: "YOUR_POSTHOG_INGEST_KEY", host: "https://api.usesequential.com")
config.sessionReplay = true
config.sessionReplayConfig.screenshotMode = true // required for SwiftUI screens
PostHogSDK.shared.setup(config)
```

`apiKey` is the project’s PostHog ingest key, which starts with `sq_posthog_`, not the Sequential browser key (`sq_sequential_…`).

3. In a SwiftUI app, name each screen, as in [Name your SwiftUI screens](#name-your-swiftui-screens).
4. Check the install, as in [Check it works](#check-it-works).

### Name your SwiftUI screens

Automatic screen capture reports the same hosting-controller class for every SwiftUI screen, so add `.postHogScreenView("Checkout")` to each screen, or call `PostHogSDK.shared.screen("Checkout")`. If the app does not name a screen, SwiftUI gives it a framework container name. Such a name is not a page.

### Masking on iOS

Masking happens on the device. As of posthog-ios 3.92.0, text inputs and images are masked by default. With the setup code (screenshot mode), the replay masks every text, text field and button, in SwiftUI views and in UIKit views.

Opt a view out with `.postHogNoMask()` only where that is safe. Mask custom secure views (a PIN pad, for example) yourself. The project’s masking settings in Sequential do not apply to mobile.

In posthog-ios 3.93.6 (tested 6 November 2026), the default image masking made every frame of the replay black in a test app with an image that fills the screen as a background. See [If the iOS replay is all black](#if-the-ios-replay-is-all-black). If a replay is all black, add `config.sessionReplayConfig.maskAllImages = false` to the setup, but only if the images in your app show no personal data.

### Text fields and taps on iOS

As of posthog-ios 3.92.0, `config.captureElementInteractions` is off by default, and the setup code does not turn it on. If your app turns it on, the SDK sends an `$autocapture` event each time a person stops editing a `UITextField` or a `UITextView`. A SwiftUI `TextField` uses a `UITextField`, so this applies to it too.

The event carries the text of the field, up to 255 characters. The SDK does not remove card numbers, emails or names from it. From 18 October 2026, Sequential stores an email, a card number, a JWT or a Bearer or Basic credential in this text as `[redacted]`. The people in your project can see the stored text in the dashboard, but agent tools never get it.

To keep a field out, do one of these:

- Use secure entry: `isSecureTextEntry = true`, or a SwiftUI `SecureField`.
- Set a sensitive `textContentType` on the field, for example `.creditCardNumber`, `.emailAddress`, `.telephoneNumber`, `.password`, `.oneTimeCode`, `.familyName`, `.fullStreetAddress` or `.postalCode`. The SDK has a list of 23 such types. `.givenName` (the first name) is not on the list.
- Put `ph-no-capture` in the `accessibilityIdentifier` or the `accessibilityLabel` of a UIKit view. The SDK then sends no event from that view or from a view in it. On a SwiftUI text field, put it in the identifier, for example `.accessibilityIdentifier("ph-no-capture-card")`.
- To send no element text from the whole app, set `config.captureAutocaptureElementText = false`. The SDK still sends taps, with the `postHogLabel` ids of your views. Your own events and session replay do not change.

Taps send some text too. With `captureElementInteractions` on, a tap on a UIKit button sends its title. A tap on a label sends no text.

With `config.captureSwiftUIElementInteractions` on (off by default), a tap on a SwiftUI view sends its `postHogLabel` or its accessibility identifier, not its visible text. Do not put personal data in button titles or in accessibility identifiers.

### If your app turns on captureElementInteractions

The SDK sends the event when the field loses focus. An empty field sends no text, and not its placeholder.

If the SDK cut the text of the field, 9 or more digits or the start of an email just before the cut become `[redacted]` too. On 18 October 2026, Sequential tested this with a real SwiftUI app on the iOS simulator: it stored a typed card number and an email as `[redacted]`. Names, phone numbers, addresses and other text stay as typed, and events stored before that date keep the text.

## Android (Kotlin)

1. Add the `com.posthog:posthog-android` dependency.
2. Set it up in `Application.onCreate()` with this code. If the app already uses PostHog, change `apiKey` and `host` in its existing setup call and add the replay options. Do not add a second setup call.

```kotlin
import com.posthog.android.PostHogAndroid
import com.posthog.android.PostHogAndroidConfig

val config = PostHogAndroidConfig(apiKey = "YOUR_POSTHOG_INGEST_KEY", host = "https://api.usesequential.com")
config.sessionReplay = true
config.sessionReplayConfig.screenshot = true // required for Jetpack Compose screens
PostHogAndroid.setup(this, config) // in Application.onCreate()
```

`apiKey` is the project’s PostHog ingest key, which starts with `sq_posthog_`, not the Sequential browser key (`sq_sequential_…`). If the key is wrong, the SDK drops the events with no error.

3. In a Jetpack Compose app with one Activity, name each screen, as in [Name your Jetpack Compose screens](#name-your-jetpack-compose-screens).
4. Check the install, as in [Check it works](#check-it-works).

### Name your Jetpack Compose screens

posthog-android names a screen by its `Activity` class, for example `DashboardActivity`. Sequential uses this name as the page: see [Screens are pages](#screens-are-pages). The SDK does not see Jetpack Compose navigation inside one `Activity`. So an app with one `Activity` and a `NavHost` shows all its screens as one page. To name each screen, call `PostHog.screen()` with the route when the destination changes:

```kotlin
navController.addOnDestinationChangedListener { _, destination, _ ->
    destination.route?.let { PostHog.screen(it) }
}
```

### Masking on Android

Masking happens on the device. As of posthog-android 3.72.3, `maskAllTextInputs` is on by default. In screenshot mode, this setting masks every Jetpack Compose `Text`, not only the text fields. The replay then shows black bars in place of the text.

Opt a composable out with `Modifier.postHogUnmask()` only where that is safe. The project’s masking settings in Sequential do not apply to mobile.

Do not turn off `maskAllTextInputs` in an app with text fields that can hold personal data. In a test on 7 November 2026 with posthog-android 3.72.8 in screenshot mode and `maskAllTextInputs = false`, the replay showed the text typed into every text field except password fields, for example an email address. posthog-ios masks fields with a sensitive content type, but posthog-android has no such rule. The text was in no stored event, only in the pixels of the replay screenshots.

> **Android: a background image is not masked in wireframe mode**
>
> As of posthog-android 3.72.3, in wireframe mode (the default), the SDK sends an image that is set as the background of a view, and Sequential shows it in the replay. This is so also with `maskAllImages` on, and also on a view with `ph-no-capture` in its tag or its content description. Do not use a background image that can show personal data.

### Android: a still screen adds no frames

posthog-android records a replay frame only when the screen draws again. A screen that does not change adds no frames, also while the app is in the foreground. So a replay can end before the last event of the session: it ends at the last change on the screen. In a test on 7 November 2026 with posthog-android 3.72.8, the replay ended at the last screen change, 15 seconds before the session’s last event. The SDK sent no frames for that time, so Sequential stored none.

### How ph-no-capture and ph-no-mask work on Android

- In wireframe mode, `ph-no-capture` masks only the text of a `TextView` (also a button or a text field), the items of a `Spinner`, and the image of an `ImageView`. It does not mask an `ImageView` that shows a colour, vector, gradient, layer or inset drawable. It does not apply to the views inside the marked view.
- `ph-no-mask` takes precedence over `ph-no-capture`, and it also applies to the views inside.
- In screenshot mode, a view with `ph-no-capture` is masked as a whole, with its background.

## React Native

React Native (and Flutter, via `posthog_flutter`) are accepted but not yet verified against Sequential.

1. Add `posthog-react-native` and wrap the app with this code. If the app already uses PostHog, change `apiKey` and `host` in its existing setup call and add the replay options. Do not add a second setup call.

```tsx
import { PostHogProvider } from 'posthog-react-native';

<PostHogProvider
  apiKey="YOUR_POSTHOG_INGEST_KEY"
  options={{ host: "https://api.usesequential.com", enableSessionReplay: true }}
>
  {/* your app */}
</PostHogProvider>
```

`apiKey` is the project’s PostHog ingest key, which starts with `sq_posthog_`, not the Sequential browser key (`sq_sequential_…`).

2. After you install, check Sources on Settings › Setup, as in [Check it works](#check-it-works).

## Check it works

1. Build and run the app on a device or simulator and move through a few screens. Recording starts only when the app is active with no system alert on top.
2. In Sequential, open **Settings › Setup**. Under Sources, PostHog shows as "receiving" within about a minute of the first event.
3. Open **Workbench › Sessions**. The first recording shows there after the app was in the foreground for the Shortest session kept time (Settings › Recording & data). It can show up to about 6 minutes later.
4. On iOS, open one replay. If it is all black, add `config.sessionReplayConfig.maskAllImages = false` to the setup, but only if the images in your app show no personal data.

If nothing arrives, check these:

- The key is the PostHog ingest key. Sequential refuses a wrong key with 401 `unknown_ingest_key`. On Android, the SDK then drops the events with no error.
- `host` (the API URL) has no trailing path.

[Check that your install works](/docs/verify) shows what each failure looks like.

### If the iOS replay is all black

In posthog-ios 3.93.6 (tested 6 November 2026), `config.sessionReplayConfig.maskAllImages` is `true` by default. The SDK then masks every image, also an image that fills the screen as a background. In a test app with such a background, every frame of the replay was black. With `maskAllImages` set to `false`, every frame showed the screen, and the text stayed masked.

Email and password fields stay masked with both values: the SDK masks a secure entry field and a field with a sensitive `textContentType`.

## What is supported

Only PostHog’s mobile SDKs are supported on mobile. Mixpanel and Amplitude native SDKs are not supported, and neither are Smartlook’s. Server-side SDKs of other tools are rejected. To send events from your own server, use Sequential’s [backend SDK for Node](/docs/backend-sdk).

What Sequential does with PostHog (mobile) traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Yes | Same wire protocol as web (`/batch`, gzipped). |
| Page / screen views | Yes | `$screen` events. |
| Autocaptured clicks & forms | Partial | Sequential sorts the `$autocapture` events that the SDK's own autocapture sends into event classes. Mobile autocapture varies by platform. |
| Identify (user id) | Yes | Top-level `distinct_id`. |
| User properties | Partial | As on web: `$set` / `$set_once` are kept on the event but not stored as user properties. |
| Groups / accounts | No | As on web: Sequential accepts group calls, but `$groups` stays an event property: no accounts. |
| Errors | Partial | Manually captured `$exception` events only. |
| Session replay | Yes | Sequential stores PostHog's mobile session replay (iOS, Android) as sent and plays it. iOS replay is tested with a real app on the iOS simulator. Android replay is tested with a real Jetpack Compose app on the Android emulator (posthog-android 3.72.3). Masking is set in the SDK on the device. React Native and Flutter are accepted but unverified. |
| DevTools: errors, console, network, performance | Partial | No JavaScript errors or page performance. Console logs only when the project records message text and the app sets iOS `captureLogs` (Android logcat is on by default). Network timing: iOS URLSession by default, Android needs `PostHogOkHttpInterceptor`. Flutter: none. See [Mobile apps](/docs/mobile). |
| Feature flags, surveys, experiments | No | As on web: Sequential’s remote config turns flags, surveys and heatmaps off; `/flags` and `/decide` have no route. Flags evaluate as off. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Sequential rejects server-side SDK user agents as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

### Which tests did Sequential run with real apps?

- On 18 October 2026, Sequential tested the iOS masking in screenshot mode with a real app on the iOS simulator. The replay masked every text, text field and button, in SwiftUI views and in UIKit views.
- On 18 October 2026, Sequential stored and played the replay of a Jetpack Compose app with posthog-android 3.72.3 on the Android emulator.
- iOS replay is tested with a real app on the iOS simulator.
- On 18 October 2026, Sequential tested the iOS text-field redaction with a real SwiftUI app on the iOS simulator: it stored a typed card number and an email as `[redacted]`.
- On 6 November 2026, Sequential tested posthog-ios 3.93.6 with a test app: see [If the iOS replay is all black](#if-the-ios-replay-is-all-black).

## Screens are pages

From 6 November 2026, Sequential uses the screen name of a mobile app as the page of each event that has no URL. PostHog’s mobile SDKs send no URL. They send the name of the last screen (`$screen_name`) with each event. The page is `/` and the name, for example `/Checkout`.

You see it in People, in Sessions, in the page count of the player, in the page filters, in the dashboard tiles, in funnels and in `get_overview`. The screen page is for display only. Sequential does not use it to group cases.

From 8 November 2026, the session page of a session from a mobile app says screen and tap in place of page and click. For example, it says "moved through 6 screens", "Tapped", "Unnamed screen" for a screen with no name, and "No screen view, tap or custom event was recorded in this session." Sequential knows that a session is from an app when its events come from PostHog’s iOS, Android, React Native or Flutter SDK, or when its recording is a mobile recording. A WebView in an app sends web events, so its session uses web words.

From 8 November 2026, Workbench › Sessions and People also use the words of the project. Sequential reads which platforms sent the project events in the last 30 days. With only an app, the column heads say "Screens" and "Entry screen", and People speaks of one-event visitors. With a website and an app, the heads say "Pages and screens" and "Entry page or screen". With only a website, nothing changes.

### How Sequential turns a screen name into a page

- Sequential tidies the name. It removes the spaces at the start and the end, and quotes around the name. It removes generic arguments (`CheckoutView<AnyView>` becomes `CheckoutView`) and a module prefix (`MyApp.CheckoutView` becomes `CheckoutView`). An id in the name, such as a UUID or a number of 4 or more digits, becomes `:id`.
- The name of a framework container, such as `NavigationStackHostingController<AnyView>`, `TabHostingController` or `EXHost`, is not a page. A name that starts with `_`, such as `_UISceneHosting`, is not a page either. SwiftUI and UIKit give every screen such a name if the app does not name it. So name your SwiftUI screens: see [Name your SwiftUI screens](#name-your-swiftui-screens).
- A name with `@` (it can be an email) is not a page. A name of more than 60 characters after the tidy is not a page.
- From 7 November 2026, on Android, a launcher `<activity-alias>` is not a page. Some apps start through an alias in the manifest, for example `MainActivityAlias1`, that opens the first real screen at once. Sequential keeps the screen view of the alias, but it does not count it as a page. So the first real screen is the entry page of the session. This applies only when all of these are true: the screen name ends in `Alias`, with or without a number; the app opened 1 second or less before or after the screen view; and no tap or other action came before the next screen. Sequential checks this in each upload from the app, so an alias stays a page if the next screen comes in a later upload. Other screens that show for a short time, such as a splash screen, stay pages. Screen views stored before this change stay as they were.

## Enable DevTools on mobile (optional)

The replay’s DevTools drawer can show a mobile app’s console logs and network timing. Both need a setting in the app that the setup code on this page deliberately leaves out. Add them only if the user asks for them. JavaScript errors and page performance are web only. Flutter sends neither console logs nor network telemetry.

### Console logs

Sequential asks the app for logs only when the project turns on Console message text (Settings › Recording & data › What a recording carries). On iOS the app must also opt in:

```swift
config.sessionReplayConfig.captureLogs = true // optional: console logs for DevTools
```

Android sends logcat by default. The mobile SDK always sends message text; Sequential keeps it only because that setting is on. React Native: `captureLog` (on by default) maps to iOS `captureLogs`.

### Network timing

A network row has the timing, status and size of one request, following the project’s Network requests switch. iOS records URLSession requests by default. Android needs PostHog’s interceptor on the OkHttp client:

```kotlin
import com.posthog.android.PostHogOkHttpInterceptor

// optional: network timing for DevTools, on the OkHttp client your app already builds
val client = OkHttpClient.Builder()
  .addInterceptor(PostHogOkHttpInterceptor())
  .build()
```

Mobile network rows are metrics only: method, URL with query values redacted, status, duration and size. PostHog’s SDKs never send headers or bodies. React Native: network telemetry is iOS only.

### Why does the replay not show the SDK’s own calls to Sequential?

From 6 November 2026, a replay leaves out the requests to the host that the SDK sent the replay to. So the SDK’s own calls to Sequential are not shown, and they are never a failed request of your app. A request to another Sequential host, for example a call from your app to the Sequential API, stays. Sequential also answers the SDK’s feature flag calls (`/flags` and `/decide`) with no flags, so these calls do not fail. Recordings stored before then do not change.

## Next steps

- [Check that your install works](/docs/verify): what each failure looks like, for every SDK that Sequential accepts.
- [Session replay masking and redaction](/docs/masking-and-redaction): what masking and redaction do, and what neither one catches.
- [Session replay recording settings](/docs/recording-settings): each control on Settings › Recording & data.
- [DevTools in session replays](/docs/devtools): the console, network requests, errors and page performance behind a session replay.
