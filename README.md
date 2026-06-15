# ConnectOnion iOS

ConnectOnion iOS is a SwiftUI app for connecting to local or remote ConnectOnion agents, managing agent profiles, and running chat-style agent sessions with approvals, file attachments, and execution status updates.

## Project Snapshot

- Platform: iOS
- UI: SwiftUI
- Persistence: SwiftData
- Bundle identifier: `com.romantcD.ConnectOnion-iOS`
- Version: `1.0 (1)`
- Info plist: `Config/ConnectOnion-Info.plist`
- Local networking: enabled for connecting to agents on the same network

## Local Development

1. Open `ConnectOnion iOS.xcodeproj` in Xcode.
2. Select the `ConnectOnion iOS` scheme.
3. Choose a simulator or a registered physical device.
4. Build and run with `Cmd+R`.
5. Run tests with `Cmd+U` before preparing an installable build.

For UI test scenarios, the app supports the `--ui-testing` launch argument and uses seeded preview dependencies.

## iOS App Installation Best Practices

Use the narrowest distribution path that matches the audience. Simulator builds are for development only, TestFlight is the default path for testers, Ad Hoc is for tightly controlled device lists, and App Store distribution is for production users.

### 1. Keep Signing Explicit And Reproducible

- Use a consistent Apple Developer Team across app, unit test, and UI test targets.
- Keep the bundle identifier stable after testers or users have installed the app.
- Prefer automatic signing for day-to-day development, but confirm the selected team and provisioning profile before archiving.
- Rotate certificates intentionally and verify that existing testers can still install updates.
- Never commit private keys, exported certificates, provisioning profiles, or App Store Connect API keys.

### 2. Validate The Build Before Distribution

- Build with the same scheme and configuration that will be archived.
- Run unit tests and UI tests on at least one current iPhone simulator.
- Install on a physical device before sending a build to testers.
- Verify first launch, app permissions, local network access, persistence, and upgrade behavior.
- Confirm the app icon, display name, launch screen, supported orientations, and version/build numbers.

### 3. Install On A Development Device

Use this path for daily engineering validation.

1. Connect a registered iPhone or iPad.
2. In Xcode, select the physical device as the run destination.
3. Make sure the Apple Developer Team is selected for the app target.
4. Build and run with `Cmd+R`.
5. On first install, trust the developer profile on the device if iOS asks for it.

This method is fast, but it is not a substitute for TestFlight because it does not exercise the App Store distribution pipeline.

### 4. Install With TestFlight

Use TestFlight for internal and external testing.

1. Increment `CURRENT_PROJECT_VERSION` for every uploaded build.
2. Archive from Xcode with `Product > Archive`.
3. Validate the archive in Organizer.
4. Upload to App Store Connect.
5. Add internal testers first and run a smoke test.
6. Add external testers after App Review approval for the beta build.
7. Include concise test notes that explain what changed and what testers should verify.

Best practice: keep TestFlight groups small and purposeful, such as `Internal`, `Design Review`, `External Beta`, and `Release Candidate`.

### 5. Install With Ad Hoc Builds

Use Ad Hoc distribution only when TestFlight is not suitable, such as offline QA or device-limited partner testing.

- Register every target device UDID in the Apple Developer portal.
- Create or refresh the Ad Hoc provisioning profile after device list changes.
- Export an `.ipa` from Xcode Organizer using the Ad Hoc method.
- Share the `.ipa` and installation manifest only through a trusted channel.
- Track which build was sent to which devices.

Ad Hoc builds expire with their provisioning profile, so avoid using them for long-running beta programs.

### 6. App Store Release Checklist

Before submitting a production build:

- Bump both marketing version and build number as needed.
- Run tests from a clean build.
- Test install and update from the previous released build.
- Review privacy strings, especially local network usage.
- Confirm App Store screenshots, description, support URL, privacy nutrition labels, and age rating.
- Verify no debug endpoints, test credentials, verbose logs, or mock-only flows are enabled.
- Archive, validate, upload, and submit through App Store Connect.

### 7. Post-Install Smoke Test

After installing any distributed build, verify:

- The app launches without migration or persistence errors.
- Local network permission appears with the expected explanation.
- Agent configuration can be created, edited, and persisted.
- Chat sessions can start, receive events, show tool calls, and handle approval prompts.
- Offline, invalid address, and connection failure states are understandable.
- Reinstall and upgrade paths do not leave the app in a broken state.

## Release Hygiene

- Commit key source, project, and documentation changes before handing off a build.
- Keep release notes tied to commit history.
- Tag production releases after App Store approval.
- Keep generated archives and exported `.ipa` files out of the repository.
