# Family Onboarding Journey

Status: Mock UI complete in UX-004  
Last updated: 2026-06-21

## Actor and trigger

A newly verified caregiver has accepted required consent but has not created a family care circle. The authentication guard redirects every private route to `/onboarding` until onboarding is complete.

## Happy path

1. Caregiver enters a family group name, such as “Sharif Family Care.”
2. Caregiver selects Father, Mother, or both as initial dependent profiles.
3. Caregiver optionally enters another caregiver’s email.
4. UI previews the default secondary-caregiver permissions:
   - Manage medicines: allowed
   - Manage documents: denied
   - Manage appointments: allowed
   - Manage emergency contacts: allowed
5. Caregiver reviews the group, dependent profiles, invitation, and role.
6. Caregiver selects Create family.
7. Mock family data and activity events are created atomically.
8. `onboardingComplete` becomes true and the route guard redirects to the caregiver dashboard.

## Alternative and error paths

- Empty family name does not advance.
- Father and Mother are independently optional; future UX-005 adds custom dependents and complete profile data.
- Invitation email is optional. Backend validation and duplicate/existing-member checks arrive in BE-005.
- Previous returns to the preceding step without losing entered data.
- At 200% text scaling, every step is scrollable and actions remain reachable.
- If creation fails in the backend phase, the user remains on Review with entered data and a retry action.

## Permissions and events

- The creator becomes Owner with all family-management permissions.
- Dependents do not receive account access merely because a care profile exists.
- An invited secondary caregiver receives no access until invitation acceptance.
- Creation, profile additions, and invitation events are added to family activity.

## Acceptance evidence

The registration integration test completes authentication, verification, consent, all four onboarding steps, invitation creation, and dashboard arrival.
