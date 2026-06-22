# Respond to Medicine Reminder Journey

Status: Mock UI complete in UX-007  
Last updated: 2026-06-21

## Parent happy paths

1. Parent opens the full-screen reminder for the selected care profile.
2. Screen shows medicine, dosage, food instruction, local time, and care-profile timezone.
3. Parent chooses one large action:
   - I took it → Taken
   - Remind me in 15 minutes → Snoozed
   - Skip this dose → Skipped
   - I need help → Escalated immediately
4. Action is timestamped and appears in reminder history.
5. When no reminder is due, the screen shows a calm completion state and history link.

## Offline path

1. If offline, the same action remains available.
2. Action is marked `queuedOffline` and stored locally.
3. UI announces that it will sync when connection returns.
4. BE-007 will send an idempotency key and reconcile server/client state without duplicate adherence events.

## Need Help path

Need Help does not wait for normal missed-reminder timing. It changes the event to Escalated immediately and informs the parent that the caregiver has been notified. UX-009 adds local-contact acceptance and emergency resolution.

## Readiness and limitations

- UI shows notification permission readiness.
- Battery optimization, Focus, silent mode, connectivity, and OS policies can affect delivery.
- CareBridge never promises guaranteed alarm or emergency delivery.
- Call caregiver/emergency-contact fallbacks remain required.

## History

The parent/caregiver history is profile-scoped, filterable by every PRD status, timezone-labelled, and includes offline-queued state. Fifty deterministic events support realistic scrolling and filtering.

## Acceptance evidence

- Widget workflow records Taken while offline and verifies queued state.
- Widget workflow escalates Need Help immediately.
- History remains populated with 41 Father events from the 50-event fixture catalog.
