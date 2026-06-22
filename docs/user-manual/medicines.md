# Medicines

## Select the correct person

Before adding or changing medicine, use the header profile switch and confirm the person’s name and care timezone.

## Add medicine

1. Open **Medicines → Add medicine**.
2. Enter the medicine name, strength, form, dosage, and quantity.
3. Configure frequency, times, days, start/end dates, and food instruction.
4. Review the upcoming dose and care-profile timezone.
5. Add prescription, doctor, stock, threshold, and notes where available.
6. Select **Save medicine**.

CareBridge does not prescribe medicine or recommend dosage. Enter schedules only from instructions provided by an appropriate healthcare professional.

## Find medicines

Use **All**, **Active**, **Low stock**, and **Completed** filters. Low stock means the current count is at or below its configured threshold.

## Change medicine status

Open a medicine to:

- Pause future reminders temporarily
- Resume a paused medicine
- Mark a course completed
- Stop a medicine while retaining history

Editing an existing schedule requires confirmation because future reminder times will change.

## Current implementation

This release demonstrates the complete UI and deterministic local state. Reliable reminder generation, offline synchronization, audit logs, and backend schedule validation arrive in BE-006 and BE-007.
