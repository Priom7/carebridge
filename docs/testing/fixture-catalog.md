# Local Demo Fixture Catalog

Status: Active requirement from UX-007 onward  
Last updated: 2026-06-22

All fixtures are deterministic, fictional, local-only, and safe for demos/tests. List-heavy domains must contain 30–50 records when implemented.

| Domain | Current count | Coverage |
|---|---:|---|
| Care profiles | 32 | Relationships, cities, health conditions, languages, completion metrics |
| Family members | 30 | Dependents and secondary caregivers with varied permissions |
| Family invitations | 30 | Pending, accepted, revoked, and expired |
| Medicines | 50 | Profile scope, forms, frequencies, lifecycle states, stock levels |
| Reminder events | 50 | Due, taken, snoozed, skipped, missed, escalated, resolved, cancelled |
| Alarm requests | 40 | Requested, sent, delivered, opened, actioned, and failed remote alerts |
| Emergency contacts | 40 | Profile scope, priority 1–4, verification lifecycle, availability, and least-privilege permissions |
| Emergency alerts | 40 | Active, accepted, resolved, caregiver/parent triggers, and timeline variation |
| Documents | 40 | All 15 PRD types, PDF/image, profile scope, visibility, links, archive/delete, upload failures, and access history |
| Doctors | 30 | Specialities, hospitals, visiting hours, contacts, notes, and linked care profiles |
| Appointments | 40 | Every PRD status, timezone/location, questions, reports, attachments, summaries, and follow-ups |

Implementation: `apps/mobile/lib/core/demo/demo_fixtures.dart` plus the two primary care profiles and three named primary medicines seeded by `AppSettings`.

## Rules for future domains

- Health logs/check-ins, notifications, and timeline events must each add 30–50 records when their UI task begins.
- Use stable IDs and stable dates so golden/widget tests are repeatable.
- Do not use actual patient names, contact details, documents, or health information.
- Include happy, empty/filter, warning, failure-relevant, permission, and lifecycle variations.
- Keep the first few records human-readable for scripted demos; use generated remainder for scale.
- Tests assert the 30–50 bounds to prevent accidental fixture regression.
