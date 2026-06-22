# Care Profile Journey

Status: Mock UI complete in UX-005  
Last updated: 2026-06-21

## Actor and scope

An authorized caregiver creates and maintains a profile for a parent, relative, or other dependent. A care profile can exist without that person having a CareBridge login.

## Create profile

1. Caregiver opens More → Care profiles.
2. Caregiver selects Add care profile.
3. Required identity fields are full name, preferred name, and relationship.
4. Caregiver can enter date of birth, gender, blood group, phone, address, city, country, timezone, and preferred language.
5. Health and safety fields include medical conditions, allergies, mobility notes, doctor notes, and emergency instructions.
6. Primary and secondary caregivers are shown in the care-team section.
7. Save validates required fields, creates the active profile, selects it, and records family activity.

## Edit and switch profile

1. Caregiver can open Edit care profile from the profile list or dashboard.
2. All fields preserve current values and are editable.
3. Save updates the existing profile without losing dashboard counters or appointment summary.
4. The header profile switch lists active profiles only.
5. Selecting a profile refreshes dashboard identity, timezone, medicines, alerts, documents, appointment, and quick-action context.

## Archive profile

1. Caregiver selects Archive profile.
2. A confirmation explains that active care hides the profile while history remains.
3. Confirming marks it archived and switches to the next active profile.
4. If no active profile remains, the dashboard shows an empty state and Add care profile action.
5. Archived profiles remain visible in the Archived section for future restore/history support.

## Validation and states

- Required fields show localized inline validation.
- Long notes and 200% text scaling remain scrollable.
- Empty active-profile state is explicit.
- Profiles missing phone, timezone, or emergency instructions show a completion banner on the dashboard.
- Backend failures will preserve form content and provide retry; unauthorized edits will return to a safe read-only/list state.

## Security and events

- Profile access is family- and role-scoped.
- Emergency contacts do not inherit profile document access.
- Create, update, archive, and future restore actions are audited.
- Sensitive health content is not placed in push previews or analytics.

## Acceptance evidence

- Widget workflow switches Father to Mother and verifies dashboard context/timezone.
- Widget workflow creates a third profile with validation and archives Father with confirmation.
