# Localization and Accessibility Contract

Status: Active  
Implemented baseline: UX-002  
Last updated: 2026-06-21

## Localization architecture

Flutter `gen-l10n` generates strongly typed application strings from:

- `apps/mobile/lib/l10n/app_en.arb`
- `apps/mobile/lib/l10n/app_bn.arb`

English is the source locale. Bangla is fully available for the production navigation shell and current demo surfaces. Development-only component-gallery prose is not part of the shipped user navigation and will be removed or localized before release.

Rules:

- No production widget contains user-facing English/Bangla literals.
- Add a key to both ARB files in the same change.
- Use placeholders for names, dates, quantities, and times; do not concatenate sentences.
- Present care-profile times in that profile’s IANA timezone, while making caregiver timezone differences explicit.
- Dates, numbers, and plural forms must use locale-aware formatting.
- Translation review must be completed by a native Bangla speaker before G2 approval.
- Medical and emergency wording must be reviewed for clarity and must not imply diagnosis or guaranteed response.

## Accessibility baseline

- Material controls provide platform semantics; custom status and image components add explicit semantic labels.
- Normal targets are at least 48×48 logical pixels; parent critical actions are at least 64 pixels high.
- Navigation destinations always include text labels.
- Color is paired with text/icon meaning.
- Application text controls support 100%, 150%, and 200%; layouts must also respect platform text preferences.
- Parent mode minimizes navigation and presents one decision per large action.
- Tooltips describe icon-only caregiver controls.
- Focus order follows visual reading order; no interaction relies only on hover or gesture.
- Light/dark themes use semantic color roles rather than fixed foreground colors.

## Required verification through G2

- Compact and wide layouts in English and Bangla
- 200% text scale with no clipping, overlap, or unreachable controls
- Android TalkBack and iOS VoiceOver primary journeys
- Keyboard navigation on Flutter web/dev surfaces
- Contrast review for text, icons, focus, and statuses
- Reduced-motion behavior for any animation added later
- Generic notification preview copy under locked-device conditions

## Known follow-up

Production Bangla font evaluation is pending. The current theme uses the platform fallback for Bangla glyphs. UX-014 must select/test a bundled font or document why platform fallback is retained across supported Android/iOS versions.
