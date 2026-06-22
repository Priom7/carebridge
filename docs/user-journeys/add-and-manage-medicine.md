# Add and Manage Medicine Journey

Status: Mock UI complete in UX-006  
Last updated: 2026-06-21

## Preconditions

- Caregiver is authenticated and has selected an active care profile.
- Caregiver has Manage medicine permission.

## Create medicine

1. Open Medicines or use dashboard Add medicine.
2. Enter medicine name, generic/brand names, strength, form, dosage, and quantity per dose.
3. Choose frequency, dose times, days, start/end dates, long-term status, and food instruction.
4. Review the upcoming-dose preview in the selected profile’s timezone.
5. Optionally link prescriber, doctor, and prescription.
6. Enter stock, low-stock threshold, notes, and side-effect notes.
7. Save creates an Active profile-scoped medicine.

## Review and filter

- All shows every lifecycle state.
- Active shows current medicines.
- Low stock shows active medicines at or below their threshold.
- Completed shows finished courses.
- Switching profiles immediately changes the medicine collection.

## Edit and lifecycle

1. Open a medicine card for details, times, timezone, stock, and notes.
2. Edit uses the same complete form.
3. Editing an existing schedule displays an explicit future-reminder warning and confirmation.
4. Actions can Pause, Resume, Complete, or Stop a medicine.
5. Backend audit will record old/new schedule data and actor.

## Validation and safety

- Name, strength, dosage, and start date are required.
- Reminder times use the care profile timezone, never the caregiver device timezone implicitly.
- The app organizes schedules but does not recommend medicines or dosages.
- Prescription extraction remains outside MVP and can never save a schedule without confirmation.
- Backend scheduling will validate dates, duplicate/overlapping times, every-X-hour constraints, and DST behavior.

## Acceptance evidence

- Widget test proves Father/Mother medicine isolation and low-stock filtering.
- Widget test creates a scheduled medicine, verifies timezone/times, then pauses and completes it.
