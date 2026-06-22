# Caregiver Dashboard Journey

Status: Mock UI complete in UX-005  
Last updated: 2026-06-21

## Purpose

The dashboard provides a fast, profile-specific answer to: “What needs my attention for this person today?”

## Dashboard composition

- Selected care profile name, initials, and care timezone
- Medicines due today
- Missed reminders needing attention
- Documents added this week
- Next appointment summary
- Quick actions for medicine, report, emergency contact, and timeline
- Positive completion state when morning medicines are handled
- Profile-completion banner when critical contact/safety data is absent

## Profile-switch workflow

1. Caregiver opens the profile chip in the application header.
2. Active profiles are listed by preferred name.
3. Selecting another profile preserves the dashboard destination.
4. All visible metrics and actions immediately use the new profile context.
5. Archived profiles are excluded from the switcher.

## Dashboard states

- Populated: metrics, appointment, actions, and current status
- Partial: populated dashboard plus profile-completion banner
- Empty: no active profiles, explanatory state, and Add care profile action
- Loading/error/offline: reserved repository states implemented when fixture repositories are formalized in later UI tasks; visual patterns already exist in the design system

## Performance contract

- Display cached profile/dashboard state immediately when available.
- Refresh remote state without blanking the current dashboard.
- Profile switching should feel immediate and never mix metrics from two profiles.
- Backend responses will include profile-scoped versions/timestamps to prevent stale cross-profile updates.

## Privacy

The dashboard contains health information and is shown only after authentication. Application lock/biometric behavior arrives with platform integration. Notification previews remain generic.
