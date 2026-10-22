# Registry tweaks

Every value that `configuration.winget` sets, what it does, and where the same switch lives in the Settings app (if any). All values are `REG_DWORD` unless noted.

**Undo:** delete the value. Without it, Windows falls back to its default (the feature is on again). Values under a `Policies` key are group policies; while they exist, Settings shows "Some of these settings are managed by your organization" and greys out the matching switch.

## Settings app

`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer`

| Value | Data | Effect |
| --- | --- | --- |
| `SettingsPageVisibility` (`REG_SZ`) | `hide:home` | Hides the *Home* page of the Settings app (recommended settings, Microsoft account and Microsoft 365 promotions). Settings opens on *System* instead. More pages can be added separated by `;`, e.g. `hide:home;gaming-gamebar`. |

## Error reporting

`HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting`

| Value | Data | Effect |
| --- | --- | --- |
| `Disabled` | `1` | Turns off Windows Error Reporting: crashes and hangs are no longer collected and sent to Microsoft. No Settings equivalent. |

## Suggestions, tips and promoted apps

`HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager`

The Content Delivery Manager drives the "suggestions" Windows shows across the shell. Each `SubscribedContent-<id>Enabled` value is one content channel.

| Value | Data | Effect | Settings equivalent |
| --- | --- | --- | --- |
| `SilentInstalledAppsEnabled` | `0` | Stops Windows from silently installing promoted apps (the "suggested" games and apps that show up in Start). | none |
| `SystemPaneSuggestionsEnabled` | `0` | No app suggestions in Start. | none |
| `SubscribedContent-338388Enabled` | `0` | No suggestions in Start. | none |
| `SubscribedContent-338389Enabled` | `0` | No tips, tricks and suggestions while using Windows. | System → Notifications → Additional settings → *Get tips and suggestions when using Windows* |
| `SubscribedContent-338393Enabled` | `0` | No suggested content in the Settings app. | Privacy & security → General → *Show me suggested content in the Settings app* |
| `SubscribedContent-353694Enabled` | `0` | Same as above (second channel). | same switch |
| `SubscribedContent-353696Enabled` | `0` | Same as above (third channel). | same switch |
| `SoftLandingEnabled` | `0` | No tip notifications about Windows features. | none |

## Nags

| Key | Value | Data | Effect | Settings equivalent |
| --- | --- | --- | --- | --- |
| `HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement` | `ScoobeSystemSettingEnabled` | `0` | No full-screen "Let's finish setting up your device" after feature updates. | System → Notifications → Additional settings → *Suggest ways to get the most out of Windows and finish setting up this device* |
| `HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced` | `Start_AccountNotifications` | `0` | No Microsoft account reminders (badge on the profile picture) in Start. | Personalization → Start → *Show account-related notifications* |
| `HKCU\SOFTWARE\Microsoft\Siuf\Rules` | `NumberOfSIUFInPeriod` | `0` | Windows never asks for feedback (SIUF = "System Initiated User Feedback"). | Privacy & security → Diagnostics & feedback → *Feedback frequency: Never* |

## Privacy

| Key | Value | Data | Effect | Settings equivalent |
| --- | --- | --- | --- | --- |
| `HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy` | `TailoredExperiencesWithDiagnosticDataEnabled` | `0` | Microsoft does not use diagnostic data for personalized tips, ads and recommendations. | Privacy & security → Diagnostics & feedback → *Tailored experiences* |

### Inking and typing personalization

These four values together switch off the custom inking and typing dictionary: Windows stops learning from what you type and write and does not read your contacts for it.

| Key | Value | Data | Effect |
| --- | --- | --- | --- |
| `HKCU\Software\Microsoft\InputPersonalization` | `RestrictImplicitTextCollection` | `1` | No collection of typed text. |
| `HKCU\Software\Microsoft\InputPersonalization` | `RestrictImplicitInkCollection` | `1` | No collection of pen/handwriting input. |
| `HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore` | `HarvestContacts` | `0` | Contacts are not added to the dictionary. |
| `HKCU\Software\Microsoft\Personalization\Settings` | `AcceptedPrivacyPolicy` | `0` | Marks the feature as not accepted, so the switch shows as off. |

Settings equivalent: Privacy & security → Inking & typing personalization → *Custom inking and typing dictionary*.

## Network

| Key | Value | Data | Effect |
| --- | --- | --- | --- |
| `HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization` | `DODownloadMode` | `0` | Delivery Optimization in HTTP-only mode: updates and Store apps come only from Microsoft, nothing is downloaded from or uploaded to other PCs. Policy, overrides Windows Update → Advanced options → Delivery Optimization. |
| `HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config` | `AutoConnectAllowedOEM` | `0` | Windows does not automatically connect to suggested open Wi-Fi hotspots (Wi-Fi Sense). Same value as the group policy *Network → WLAN Service → WLAN Settings → Allow Windows to automatically connect to suggested open hotspots…*. |
