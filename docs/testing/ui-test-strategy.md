# UI Test Strategy

Status: Active  
Owner task: UX-001 onward

## Test layers

1. Dart unit tests validate formatting, state transitions, scheduling presentation helpers, and repository adapters.
2. Widget tests validate rendering, interaction, validation, responsive constraints, semantics, and text scaling.
3. Golden tests capture stable key screens for compact/large layouts, light/dark themes, English/Bangla, and caregiver/parent modes.
4. Flutter integration tests execute complete mock-backed workflows during the UI phase and real API workflows after BE-012.
5. Manual device review covers platform dialogs, screen readers, keyboard behavior, notification presentation, background lifecycle, and camera/document flows.

## Required UI state matrix

Every data-driven surface must cover relevant states:

- Loading and refresh
- Empty and first-use guidance
- Populated and partial data
- Validation error
- Recoverable server/device error
- Permission denied with remediation
- Offline, queued action, reconnect, and conflict
- Unauthorized/revoked access
- Large text, narrow width, and long localized strings

## Initial UX-001 evidence

Commands:

```sh
cd apps/mobile
flutter analyze
flutter test
flutter build web
```

The component-gallery widget test checks that the brand workflow renders, the parent-mode control can be activated, and the critical “I took it” control becomes at least 64 logical pixels high. The first run exposed a compact-width token-card overflow; the component was corrected to use a wider wrapping card and flexible text.

## Device matrix

- Small Android phone: approximately 360×800 logical pixels
- Representative Android phone: approximately 412×915
- Compact iPhone: approximately 375×667
- Modern iPhone: approximately 393×852
- Large phone/text scale combinations
- Tablet/desktop-width shell at and above the 840px navigation breakpoint

UX-014 requires the full matrix and golden review before backend implementation begins.
