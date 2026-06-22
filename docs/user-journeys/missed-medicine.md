# Caregiver Missed-Medicine Journey

Status: Mock UI complete in UX-008  
Last updated: 2026-06-21

## Trigger

A reminder reaches Missed or the parent selects Need Help. The caregiver alert inbox is filtered to the active care profile and displays urgent events with medicine, missed time, and care timezone.

## Caregiver workflow

1. Open More → Caregiver alerts.
2. Select a missed/escalated event.
3. Compare parent time (`Asia/Dhaka`) with caregiver time (`Europe/London`).
4. Review prior remote-alarm delivery state: Requested, Delivered, Opened, Actioned, or Failed.
5. Choose Send reminder or Ring now.
6. UI records a new alarm request and displays delivery state.
7. Repeated requests within 30 seconds are rate-limited.
8. If delivery is uncertain, use Call parent or Notify local contact.
9. Resolve alert after confirming the situation is handled.

## Failure and limitation paths

- Remote ring may fail because the phone is offline, muted, low on battery, in Focus mode, or restricted by the OS.
- Failure never removes call/local-contact fallbacks.
- CareBridge does not guarantee emergency delivery or dispatch.
- BE-008 will capture device token failure, retry state, APNs/FCM delivery/open/action events, and abuse controls.

## Data and audit

Forty fictional alarm requests cover requested, sent, delivered, opened, actioned, and failed states. Request actor, type, timestamps, device result, rate-limit decision, and resolution become auditable backend events.

## Acceptance evidence

- Widget workflow displays the 40-record alert catalog.
- Ring now records a delivered request.
- Immediate repeat displays rate-limit feedback.
- Resolution changes the reminder to Resolved.
