# Navigation and Mode-Switching Journey

Status: Implemented in UX-002  
Last updated: 2026-06-21

## Actors

- Remote caregiver managing one or more care profiles
- Parent/dependent using the simplified mode

## Preconditions

- The current UX phase uses deterministic local state.
- Authentication and persisted role/profile selection arrive in UX-003/UX-004 and BE-004.
- The initial role is caregiver and the initial care profile is Father.

## Caregiver happy path

1. The application opens `/home` with the Caregiver Dashboard.
2. The caregiver moves between Home, Medicines, Health, Documents, and More.
3. Navigation uses a bottom bar below 900 logical pixels and a labelled rail at wider sizes.
4. The caregiver opens the profile control and switches between Father and Mother without changing the current destination.
5. The caregiver can change English/Bangla, text scale, and light/dark appearance from More.
6. A direct route maps to the same selected navigation destination.

## Parent-mode path

1. The caregiver taps the accessibility/person control labelled Parent mode.
2. Application role changes to Parent and the router redirects to `/parent`.
3. The parent sees one simplified page: next medicine, My Medicines, Log Vitals, Call Sharif, and Need Help.
4. Critical actions are at least 64 logical pixels high.
5. The overflow menu provides language switching and a return to Caregiver mode.
6. When the role returns to Caregiver, the router redirects to `/home`.

## Guard and error behavior

- Parent role cannot remain on caregiver destinations; an attempted caregiver deep link redirects to `/parent`.
- Caregiver role cannot remain on `/parent`; it redirects to `/home`.
- Unknown routes show a localized, non-technical unavailable-page message.
- Future authentication guards will run before role guards and preserve a safe intended destination.

## Accessibility behavior

- Navigation icons always have visible labels.
- Logo images expose the CareBridge semantic name.
- Profile and mode controls have localized tooltips/semantic labels.
- Status meaning is never color-only.
- UI supports application-controlled 100%, 150%, and 200% scaling in addition to platform text settings.
- Parent mode uses fewer destinations and larger critical controls.

## Acceptance evidence

- Caregiver widget test visits Medicines, Health, and Documents through the navigation bar.
- Role test changes to Parent mode and verifies the 64px Need Help control.
- Localization test switches to Bangla and verifies a 2.0 text scaler.
- Flutter analysis, all widget tests, and web compilation pass.
