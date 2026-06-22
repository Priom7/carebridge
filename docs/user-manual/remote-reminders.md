# Caregiver Alerts and Remote Reminders

## Open missed alerts

Select **More → Caregiver alerts**. Alerts are scoped to the person selected in the header. Open an alert to see the medicine, missed time, parent timezone, your timezone, and prior delivery state.

## Send a reminder or ring

- **Send reminder** sends a normal reminder request.
- **Ring now** requests the stronger alarm-style reminder.

Wait before sending another request. CareBridge rate-limits repeated alarms to reduce confusion and abuse.

## Understand delivery tracking

- Requested: CareBridge accepted the action.
- Delivered: the device service reported delivery.
- Opened: the parent opened the alert.
- Actioned: the parent selected an action.
- Failed: the request could not reach the device.

These UI states currently use deterministic local demonstration data. Real push delivery tracking arrives with BE-008.

## Use fallbacks

Remote ringing is not guaranteed. If the parent does not respond:

1. Select **Call parent**.
2. Select **Notify local contact** when appropriate.
3. Contact local emergency services directly if the situation is urgent.
4. Resolve the CareBridge alert only after confirming it is handled.
