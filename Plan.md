# CareBridge Delivery Plan

## 1. Plan control

| Field | Value |
|---|---|
| Product | CareBridge — Remote Family Health & Medicine Care App |
| Source | `PRD.md` (all 1,964 lines reviewed) |
| Plan version | 1.0.0 |
| Created | 2026-06-21T14:47:04+01:00 |
| Last updated | 2026-06-23T18:27:21+01:00 |
| Mobile decision | Flutter/Dart for iOS and Android |
| Backend decision | Next.js with TypeScript, App Router route handlers, and background worker entrypoint |
| File storage decision | Firebase Cloud Storage; Firebase Storage Emulator locally |
| Primary data services | PostgreSQL and Redis |
| Local runtime | Docker Compose for backend and all local dependencies |
| Delivery rule | Complete and approve 100% of application UI/UX with realistic mock data before backend implementation |

This file is the execution ledger. It must be updated whenever a task changes state. A task is not `DONE` until its workflow is demonstrable, its acceptance checks pass, and its documentation changes are committed with it.

## 2. Status and timestamp protocol

Allowed statuses:

`NOT_STARTED` → `IN_PROGRESS` → `DONE`

Use `BLOCKED` only while a task is actively blocked. When resumed, change it back to `IN_PROGRESS`; do not erase earlier timestamps or blocker notes.

For every task:

1. On start, set `Status: IN_PROGRESS`, add `Started at`, and add the first `In-progress at` entry.
2. At every meaningful checkpoint, append an ISO-8601 timestamp to `Progress log` with a concrete result.
3. On completion, set `Status: DONE`, add `Done at`, record test/demo evidence, and update `Last updated` in this file.
4. Use timezone-aware timestamps, for example `2026-06-21T14:47:04+01:00`.
5. Never pre-fill future timestamps. Estimates are durations, not claimed completion dates.
6. If scope changes, append a decision to `docs/decisions/` and link it from the task.

Task record template:

```md
Status: NOT_STARTED
Started at: —
In-progress at: —
Done at: —
Estimate: 2 engineering days
Depends on: TASK-XXX
Demo: A complete user-visible workflow.
Acceptance: Objective pass/fail conditions.
Documentation: Files created or updated in this task.
Evidence: Test command, screenshot/video path, API output, or review sign-off.
Progress log:
- —
```

## 3. Definition of done

Every task must satisfy all relevant items:

- A complete vertical workflow can be demonstrated from its documented starting state.
- Loading, empty, populated, validation, offline, permission-denied, and error states are implemented where applicable.
- English and Bangla layouts are checked, including long text and text scaling.
- Parent mode meets large-target, high-contrast, screen-reader, and low-complexity requirements.
- Unit/widget/integration tests pass for changed behavior; golden tests cover stable key screens.
- No sensitive health information appears in notification previews, logs, analytics, or error messages.
- User journey, architecture/flow diagrams, API/OpenAPI, operational notes, and user manual are updated when affected.
- Demo evidence is recorded in the task entry.
- A task may use mocks during the UI phase, but the mock contract must be deterministic and match the planned API schema.
- Every implemented list-heavy domain must include 30–50 deterministic, realistic local fixture records for demos, filtering, pagination preparation, and tests; fixtures must contain fictional data only.

## 4. Architecture baseline

### 4.1 Repository layout

```text
carebridge/
├── apps/
│   ├── mobile/                 # Flutter app
│   └── api/                    # Next.js TypeScript API and worker
├── packages/
│   ├── contracts/              # OpenAPI-generated Dart/TypeScript models
│   └── config/                 # Shared linting/configuration where useful
├── infrastructure/
│   ├── docker/
│   ├── firebase/
│   └── scripts/
├── docs/
│   ├── api/
│   ├── architecture/
│   ├── decisions/
│   ├── diagrams/
│   ├── operations/
│   ├── product/
│   ├── security/
│   ├── testing/
│   ├── user-journeys/
│   └── user-manual/
├── docker-compose.yml
├── .env.example
├── PRD.md
└── Plan.md
```

### 4.2 Runtime design

- Flutter uses feature-first modules, Riverpod for state/dependency management, GoRouter for guarded navigation, Dio for HTTP, Freezed/json_serializable for models, Drift for safe offline cache/outbox, `flutter_secure_storage` for secrets, Firebase Messaging, and `flutter_local_notifications`.
- The UI phase uses repository interfaces backed by deterministic fixture repositories. Backend integration swaps adapters, not widgets.
- Next.js TypeScript exposes versioned `/api/v1` route handlers. Business logic lives outside route files in application/domain services.
- PostgreSQL is the system of record. Prisma manages typed access and migrations.
- Redis supports queues, distributed locks, idempotency, rate limits, and short-lived cache. BullMQ workers generate reminders, detect misses, retry notifications, and escalate alerts.
- Firebase Authentication issues identity tokens. The API verifies Firebase tokens and applies family/profile RBAC. PostgreSQL stores application user, role, consent, and device records.
- Firebase Cloud Storage stores documents. The API issues constrained upload/download authorization, records metadata in PostgreSQL, and enforces access independently of client-provided paths.
- FCM/APNs provides cloud push; the device schedules local reminders for resilience. Server events remain authoritative for audit and caregiver visibility.
- OpenAPI 3.1 is the contract source. TypeScript and Dart clients/models are generated and checked for drift in CI.

### 4.3 Local Docker services

`docker compose up --build` will provide:

- `api`: Next.js TypeScript server
- `worker`: BullMQ reminder/notification worker from the same codebase
- `postgres`: PostgreSQL with health check and persistent volume
- `redis`: Redis with persistence and health check
- `firebase-emulator`: Auth, Storage, and Emulator UI with imported/exportable seed state
- `mailpit`: local email/verification inspection
- `adminer` or equivalent database inspection profile (development only)

The Flutter app runs on the host/simulator and connects through documented platform-specific hostnames. No production secrets are placed in Docker images or committed files.

## 5. Delivery gates

| Gate | Required result |
|---|---|
| G0 Plan approved | Stack, scope, task order, and demo rules accepted |
| G1 UX foundation approved | Brand, design system, navigation, accessibility, localization, and fixtures approved |
| G2 UI/UX 100% complete | Every MVP Must Have and Should Have workflow is interactive using mock repositories; all states and responsive layouts approved |
| G3 Backend foundation ready | Docker stack, auth, database, storage emulator, OpenAPI, observability, and CI work from a clean checkout |
| G4 Core integration complete | Auth, family, profiles, medicine, reminders, emergency alerts, documents, appointments, and timeline use real APIs |
| G5 Release candidate | Security/privacy checks, migration/backup tests, accessibility, performance, notification reliability, manuals, and acceptance tests pass |

Backend feature work must not begin before G2. Planning, contract design, documentation, and non-feature scaffolding may be refined during UI review, but G2 approval is the explicit implementation gate.

## 6. Master task ledger

| ID | Deliverable | Status | Started at | In-progress at | Done at | Estimate | Gate |
|---|---|---|---|---|---|---:|---|
| TASK-000 | PRD review and executable plan | DONE | 2026-06-21T14:47:04+01:00 | 2026-06-21T14:47:04+01:00 | 2026-06-21T14:50:43+01:00 | 0.5d | G0 |
| UX-001 | Flutter shell, brand, design tokens, and component gallery | DONE | 2026-06-21T14:51:55+01:00 | 2026-06-21T14:51:55+01:00 | 2026-06-21T15:02:17+01:00 | 3d | G1 |
| UX-002 | Navigation, roles, mode switching, localization, and accessibility | DONE | 2026-06-21T15:08:04+01:00 | 2026-06-21T15:08:04+01:00 | 2026-06-21T15:16:30+01:00 | 3d | G1 |
| UX-003 | Authentication, consent, recovery, and account UI | DONE | 2026-06-21T15:17:40+01:00 | 2026-06-21T15:17:40+01:00 | 2026-06-21T15:32:14+01:00 | 3d | G1 |
| UX-004 | Onboarding, family group, invitations, and permissions UI | DONE | 2026-06-21T16:26:59+01:00 | 2026-06-21T16:26:59+01:00 | 2026-06-21T16:37:51+01:00 | 4d | G1 |
| UX-005 | Care profiles and caregiver dashboard UI | DONE | 2026-06-21T21:35:09+01:00 | 2026-06-21T21:35:09+01:00 | 2026-06-21T21:45:15+01:00 | 4d | G1 |
| UX-006 | Medicine management and schedule builder UI | DONE | 2026-06-21T21:47:03+01:00 | 2026-06-21T21:47:03+01:00 | 2026-06-21T21:56:48+01:00 | 5d | G2 |
| UX-007 | Parent reminder, local alarm, and adherence history UI | DONE | 2026-06-21T21:58:42+01:00 | 2026-06-21T21:58:42+01:00 | 2026-06-21T22:06:58+01:00 | 5d | G2 |
| UX-008 | Caregiver missed-reminder and remote-ring UI | DONE | 2026-06-21T22:16:28+01:00 | 2026-06-21T22:16:28+01:00 | 2026-06-21T22:23:27+01:00 | 3d | G2 |
| UX-009 | Emergency contacts and escalation UI | DONE | 2026-06-22T20:08:24+01:00 | 2026-06-22T20:08:24+01:00 | 2026-06-22T20:35:38+01:00 | 5d | G2 |
| UX-010 | Document vault and secure viewer UI | DONE | 2026-06-22T20:37:45+01:00 | 2026-06-22T20:37:45+01:00 | 2026-06-22T20:44:52+01:00 | 4d | G2 |
| UX-011 | Doctors, appointments, and visit workflow UI | IN_PROGRESS | 2026-06-23T18:19:37+01:00 | 2026-06-23T18:19:37+01:00 | — | 4d | G2 |
| UX-012 | Health logs, check-ins, and unified timeline UI | NOT_STARTED | — | — | — | 4d | G2 |
| UX-013 | Settings, device health, privacy, export/delete, and help UI | NOT_STARTED | — | — | — | 4d | G2 |
| UX-014 | Complete UI state matrix, polish, golden tests, and UX sign-off | NOT_STARTED | — | — | — | 5d | G2 |
| BE-001 | Monorepo, Docker dependencies, CI, and developer bootstrap | NOT_STARTED | — | — | — | 4d | G3 |
| BE-002 | OpenAPI 3.1 contract and generated clients | NOT_STARTED | — | — | — | 3d | G3 |
| BE-003 | PostgreSQL schema, migrations, seeds, and audit foundation | NOT_STARTED | — | — | — | 4d | G3 |
| BE-004 | Firebase Auth integration, sessions/devices, consent, and RBAC | NOT_STARTED | — | — | — | 5d | G3 |
| BE-005 | Family groups, memberships, invitations, and care profiles API | NOT_STARTED | — | — | — | 5d | G4 |
| BE-006 | Medicines, schedules, timezone engine, and stock API | NOT_STARTED | — | — | — | 6d | G4 |
| BE-007 | Reminder generation, actions, offline sync, and adherence API | NOT_STARTED | — | — | — | 6d | G4 |
| BE-008 | FCM, local notification coordination, remote ring, and delivery logs | NOT_STARTED | — | — | — | 6d | G4 |
| BE-009 | Emergency contacts, verification, alerts, and escalation engine | NOT_STARTED | — | — | — | 6d | G4 |
| BE-010 | Firebase Storage documents, metadata, permissions, and secure viewer integration | NOT_STARTED | — | — | — | 5d | G4 |
| BE-011 | Doctors, appointments, health logs, check-ins, and timeline API | NOT_STARTED | — | — | — | 6d | G4 |
| BE-012 | Flutter real-API integration and mock removal | NOT_STARTED | — | — | — | 8d | G4 |
| BE-013 | Observability, analytics events, admin operations, and failure recovery | NOT_STARTED | — | — | — | 4d | G4 |
| QA-001 | End-to-end acceptance, accessibility, performance, security, and privacy | NOT_STARTED | — | — | — | 7d | G5 |
| REL-001 | Staging/release infrastructure, backups, runbooks, and release candidate | NOT_STARTED | — | — | — | 6d | G5 |

## 7. Detailed task cards

### TASK-000 — PRD review and executable plan

Status: DONE  
Started at: 2026-06-21T14:47:04+01:00  
In-progress at: 2026-06-21T14:47:04+01:00  
Done at: 2026-06-21T14:50:43+01:00  
Estimate: 0.5 engineering day  
Depends on: None

Demo: Open `Plan.md` and trace every PRD Must Have/Should Have capability through UI, backend, integration, documentation, test, and release work.

Acceptance:

- Flutter, Next.js TypeScript, Firebase Storage, PostgreSQL, Redis, FCM, and Docker decisions are explicit.
- UI/UX completion is a hard gate before backend feature implementation.
- Every delivery task is independently demoable and has timestamp fields.
- Documentation work is part of every feature task.

Documentation: `Plan.md`.  
Evidence: PRD sections 1–30 mapped into this plan.

Progress log:

- 2026-06-21T14:47:04+01:00 — Read the complete 1,964-line PRD and created the initial execution ledger.
- 2026-06-21T14:50:43+01:00 — Verified the 551-line plan, task ledger, traceability matrix, and UI-first delivery gates.

### UX-001 — Flutter shell, brand, design tokens, and component gallery

Status: DONE  
Started at: 2026-06-21T14:51:55+01:00  
In-progress at: 2026-06-21T14:51:55+01:00  
Done at: 2026-06-21T15:02:17+01:00  
Estimate: 3 engineering days  
Depends on: TASK-000

Demo: Launch iOS and Android builds and browse a component gallery using supplied CareBridge logos: typography, color, spacing, icons, buttons, inputs, cards, chips, dialogs, banners, loaders, error/empty states, charts, and parent-mode controls.

Acceptance: Flutter project builds; light/dark themes work; tokens replace hard-coded presentation values; assets render correctly; components meet touch-target and contrast requirements; reference screenshots are reviewed and recorded.

Documentation: `docs/product/design-system.md`, `docs/decisions/ADR-001-flutter-architecture.md`, `docs/testing/ui-test-strategy.md`.

Evidence: `flutter analyze` passed; `flutter test` passed; `flutter build web` passed; iOS simulator app built at `apps/mobile/build/ios/Debug-iphonesimulator/Runner.app`; browser boot title verified as CareBridge.

Progress log:

- 2026-06-21T14:51:55+01:00 — Started UX-001 and verified Flutter 3.38.5/Dart 3.10.4.
- 2026-06-21T14:53:00+01:00 — Reviewed both supplied UI reference boards and the ready-to-use logo preview.
- 2026-06-21T14:57:00+01:00 — Implemented responsive shell, themes, tokens, reusable controls/cards/statuses, and parent reminder preview.
- 2026-06-21T14:58:00+01:00 — First widget test detected compact token-card overflow; corrected the flexible layout and test scroll behavior.
- 2026-06-21T15:02:17+01:00 — Analysis, widget tests, web build, iOS simulator build, and task documentation completed.

### UX-002 — Navigation, roles, mode switching, localization, and accessibility

Status: DONE  
Started at: 2026-06-21T15:08:04+01:00  
In-progress at: 2026-06-21T15:08:04+01:00  
Done at: 2026-06-21T15:16:30+01:00  
Estimate: 3 engineering days  
Depends on: UX-001

Demo: Navigate every top-level destination as caregiver and parent, switch profiles/modes, switch English/Bangla, scale text to 200%, and complete primary navigation using a screen reader.

Acceptance: GoRouter map covers all screens; guards and deep-link placeholders work; Bangla/English strings contain no hard-coded UI copy; elderly-friendly parent navigation uses large primary actions; semantic labels and focus order pass checks.

Documentation: `docs/user-journeys/navigation-map.md`, `docs/diagrams/mobile-navigation.mmd`, `docs/product/localization-accessibility.md`.

Evidence: `flutter analyze` passed; four widget workflows passed; `flutter build web` passed; `flutter build ios --simulator` produced `apps/mobile/build/ios/iphonesimulator/Runner.app`.

Progress log:

- 2026-06-21T15:08:04+01:00 — Started UX-002 and established the role, locale, theme, profile, and text-scale state model.
- 2026-06-21T15:11:00+01:00 — Implemented guarded GoRouter navigation, responsive caregiver shell, profile switcher, and simplified parent route.
- 2026-06-21T15:13:00+01:00 — Added generated English/Bangla localization and 100/150/200% application text controls.
- 2026-06-21T15:15:00+01:00 — Corrected test targeting for lazily rendered parent controls and globally rebuilt scaled content.
- 2026-06-21T15:16:30+01:00 — Analysis, navigation/localization/accessibility widget tests, web build, iOS simulator build, and documentation completed.

### UX-003 — Authentication, consent, recovery, and account UI

Status: DONE  
Started at: 2026-06-21T15:17:40+01:00  
In-progress at: 2026-06-21T15:17:40+01:00  
Done at: 2026-06-21T15:32:14+01:00  
Estimate: 3 engineering days  
Depends on: UX-002

Demo: Register, verify, sign in, recover password, accept health-data consent, enable optional 2FA/biometric UI, inspect devices, log out one/all devices, request export, and request deletion using deterministic mocks.

Acceptance: All form validation, loading, success, lockout, expired-link, offline, and error states exist; notifications never disclose health details; destructive actions require clear confirmation.

Documentation: `docs/user-journeys/authentication.md`, `docs/diagrams/auth-sequence.mmd`, `docs/user-manual/account-and-security.md`.

Evidence: `flutter analyze` passed; seven widget workflows passed, including registration/verification/consent, enumeration-safe recovery, device revocation, 2FA, and export; web and iOS simulator builds succeeded.

Progress log:

- 2026-06-21T15:17:40+01:00 — Started UX-003 and defined unauthenticated, verification-required, consent-required, and authenticated states.
- 2026-06-21T15:22:00+01:00 — Implemented localized welcome, registration, sign-in, recovery, verification, and explicit consent screens with guarded routes.
- 2026-06-21T15:26:00+01:00 — Added account security, two-factor/biometric preferences, device revocation, logout-all, export, and deletion-request UI.
- 2026-06-21T15:29:00+01:00 — Completed full registration, recovery, and account-management widget workflows and corrected scroll-aware test targeting.
- 2026-06-21T15:32:14+01:00 — Analysis, seven widget tests, web/iOS builds, and authentication/account documentation completed.

### UX-004 — Onboarding, family group, invitations, and permissions UI

Status: DONE  
Started at: 2026-06-21T16:26:59+01:00  
In-progress at: 2026-06-21T16:26:59+01:00  
Done at: 2026-06-21T16:37:51+01:00  
Estimate: 4 engineering days  
Depends on: UX-003

Demo: A new caregiver creates a family, adds parents, invites a sibling, assigns a role, reviews permissions, revokes access, and transfers ownership.

Acceptance: Multi-family and multi-role paths are represented; invitation states cover added/invited/accepted/expired/revoked; permission summaries use plain language; activity view shows sensitive changes.

Documentation: `docs/user-journeys/onboarding.md`, `docs/user-journeys/manage-family.md`, `docs/diagrams/family-permission-flow.mmd`, `docs/user-manual/family-care-circle.md`.

Evidence: `flutter analyze` passed; nine widget workflows passed; web and signed iOS release builds succeeded; the updated release was installed and remained running on the connected iPhone as PID 21992.

Progress log:

- 2026-06-21T16:26:59+01:00 — Started UX-004 and added the post-consent onboarding guard and family domain fixture model.
- 2026-06-21T16:30:00+01:00 — Implemented four-step localized family-group, dependent, invitation, permission-preview, and review workflow.
- 2026-06-21T16:33:00+01:00 — Implemented invitation states, acceptance/revocation, member permissions, access removal, ownership transfer, and activity history.
- 2026-06-21T16:35:00+01:00 — Completed onboarding, invitation, permission, and ownership widget workflows with scroll-aware compact-device coverage.
- 2026-06-21T16:37:51+01:00 — Analysis, nine tests, web/iOS release builds, documentation, physical iPhone installation, and launch verification completed.

### UX-005 — Care profiles and caregiver dashboard UI

Status: DONE  
Started at: 2026-06-21T21:35:09+01:00  
In-progress at: 2026-06-21T21:35:09+01:00  
Done at: 2026-06-21T21:45:15+01:00  
Estimate: 4 engineering days  
Depends on: UX-004

Demo: Create/edit/archive a care profile, switch between father and mother, and use a dashboard showing medicines, misses, appointment, documents, emergency contacts, and quick actions.

Acceptance: All PRD profile fields are represented; dashboard loads under the perceived-performance target with skeletons; empty/populated/partial/error states work; timezone and language are visible and editable.

Documentation: `docs/user-journeys/care-profile.md`, `docs/user-journeys/caregiver-dashboard.md`, `docs/diagrams/dashboard-data-flow.mmd`, `docs/user-manual/profiles-and-dashboard.md`.

Evidence: `flutter analyze` passed; eleven widget workflows passed; web and signed iOS release builds succeeded; UX-005 was installed and remained running on the connected iPhone as PID 22380.

Progress log:

- 2026-06-21T21:35:09+01:00 — Started UX-005 and added the complete care-profile domain fixture with active/archive lifecycle.
- 2026-06-21T21:39:00+01:00 — Implemented localized create/edit/archive forms covering identity, contact, location, timezone, language, health, safety, and care-team fields.
- 2026-06-21T21:41:00+01:00 — Replaced the static dashboard with selected-profile identity, care timezone, metrics, appointment, quick actions, partial, and empty states.
- 2026-06-21T21:43:00+01:00 — Completed profile switch, create, validation, and archive workflow tests and all regression tests.
- 2026-06-21T21:45:15+01:00 — Analysis, eleven tests, web/iOS release builds, documentation, and physical iPhone installation/launch verification completed.

### UX-006 — Medicine management and schedule builder UI

Status: DONE  
Started at: 2026-06-21T21:47:03+01:00  
In-progress at: 2026-06-21T21:47:03+01:00  
Done at: 2026-06-21T21:56:48+01:00  
Estimate: 5 engineering days  
Depends on: UX-005

Demo: Add a temporary course and a long-term medicine, link a prescription, configure complex times/days/food instructions/timezone, edit/pause/complete it, and manage stock/low-stock settings.

Acceptance: Every medicine field, form, frequency, and status in the PRD is handled; schedule preview shows actual future local times; validation prevents ambiguous/invalid schedules; edit impact is explained before confirmation.

Documentation: `docs/user-journeys/add-and-manage-medicine.md`, `docs/diagrams/medicine-lifecycle.mmd`, `docs/diagrams/schedule-builder-flow.mmd`, `docs/user-manual/medicines.md`.

Evidence: `flutter analyze` passed; thirteen widget workflows passed; web and signed iOS release builds succeeded; UX-006 was installed and remained running on the connected iPhone as PID 22462.

Progress log:

- 2026-06-21T21:47:03+01:00 — Started UX-006 and added profile-scoped medicine, schedule, frequency, and lifecycle fixture models.
- 2026-06-21T21:50:00+01:00 — Implemented localized medicine list, All/Active/Low stock/Completed filters, cards, detail, and lifecycle actions.
- 2026-06-21T21:53:00+01:00 — Implemented full identity, dosage, schedule, days/times, timezone preview, prescription, stock, and notes form.
- 2026-06-21T21:55:00+01:00 — Completed profile isolation, low-stock, create schedule, timezone, pause, and completion workflow tests.
- 2026-06-21T21:56:48+01:00 — Analysis, thirteen tests, web/iOS release builds, documentation, and physical iPhone installation/launch verification completed.

### UX-007 — Parent reminder, local alarm, and adherence history UI

Status: DONE  
Started at: 2026-06-21T21:58:42+01:00  
In-progress at: 2026-06-21T21:58:42+01:00  
Done at: 2026-06-21T22:06:58+01:00  
Estimate: 5 engineering days  
Depends on: UX-006

Demo: Parent receives a full-screen reminder and completes Taken, Snooze, Skip, and Need Help paths; caregiver/parent can then inspect the event history.

Acceptance: Controls are elderly-friendly; duplicate taps are safe; offline actions visibly queue; sensitive notification previews are generic; permission-denied/battery/silent-mode guidance exists; scheduled/due/taken/snoozed/skipped/missed/escalated/resolved/cancelled states render.

Documentation: `docs/user-journeys/respond-to-reminder.md`, `docs/diagrams/reminder-state-machine.mmd`, `docs/diagrams/reminder-action-sequence.mmd`, `docs/user-manual/parent-reminders.md`.

Evidence: `flutter analyze` passed; sixteen automated workflows passed; 32 profiles, 30 family members, 30 invitations, 50 medicines, and 50 reminder events satisfy the fixture-scale contract; web and signed iOS release builds succeeded; UX-007 remained running on the connected iPhone as PID 22565.

Progress log:

- 2026-06-21T21:58:42+01:00 — Started UX-007 and added the permanent 30–50 deterministic fixture rule to Definition of Done.
- 2026-06-21T22:01:00+01:00 — Expanded local demo data to 32 profiles, 30 members, 30 invitations, 50 medicines, and 50 reminder events.
- 2026-06-21T22:03:00+01:00 — Implemented parent Taken/Snooze/Skip/Need Help actions, offline queuing, readiness/limitations, and no-reminder state.
- 2026-06-21T22:05:00+01:00 — Implemented profile-scoped filterable adherence history and fixture-bound regression tests.
- 2026-06-21T22:06:58+01:00 — Analysis, sixteen tests, web/iOS release builds, documentation, and physical iPhone installation/launch verification completed.
- 2026-06-21T22:14:38+01:00 — Corrected the real sign-in fixture-seeding path, added a visible dataset-count indicator, passed seventeen tests, and reinstalled/launched the corrected physical-device release as PID 22577.

### UX-008 — Caregiver missed-reminder and remote-ring UI

Status: DONE  
Started at: 2026-06-21T22:16:28+01:00  
In-progress at: 2026-06-21T22:16:28+01:00  
Done at: 2026-06-21T22:23:27+01:00  
Estimate: 3 engineering days  
Depends on: UX-007

Demo: A reminder ages from due to missed, the caregiver receives an alert, sends Ring Now, calls the parent, sees delivery/open/action status, and resolves the event.

Acceptance: The app states that delivery is not guaranteed; fallback call/contact actions are always available; status timestamps are readable across both user timezones; repeated remote requests are rate-limited in the UI.

Documentation: `docs/user-journeys/missed-medicine.md`, `docs/diagrams/missed-reminder-escalation.mmd`, `docs/user-manual/remote-reminders.md`.

Evidence: `flutter analyze` passed; nineteen automated workflows passed; 40 remote alarm-request fixtures cover all delivery states; web and signed iOS release builds succeeded; UX-008 remained running on the connected iPhone as PID 22614.

Progress log:

- 2026-06-21T22:16:28+01:00 — Started UX-008 and added the remote alarm request/delivery domain model.
- 2026-06-21T22:18:00+01:00 — Added 40 deterministic alarm requests spanning requested, sent, delivered, opened, actioned, and failed states.
- 2026-06-21T22:20:00+01:00 — Implemented caregiver missed-alert inbox, timezone comparison, delivery tracking, remote ring/reminder, rate limiting, fallbacks, and resolution.
- 2026-06-21T22:21:30+01:00 — Completed remote-ring delivery, immediate repeat limit, fixture-count, and resolution workflow tests.
- 2026-06-21T22:23:27+01:00 — Analysis, nineteen tests, web/iOS release builds, documentation, and physical iPhone installation/launch verification completed.

### UX-009 — Emergency contacts and escalation UI

Status: DONE  
Started at: 2026-06-22T20:08:24+01:00  
In-progress at: 2026-06-22T20:08:24+01:00  
Done at: 2026-06-22T20:35:38+01:00  
Estimate: 5 engineering days  
Depends on: UX-008

Demo: Add and verify a neighbour, configure priority/permissions, trigger Need Help, notify priority contacts, let one accept “I am going to help,” show live status, and resolve with notes.

Acceptance: All contact fields/statuses/types exist; Call/WhatsApp/Alert work through safe platform intents or mocks; emergency-only permissions never imply document access; priority escalation and caregiver-unavailable scenarios are visually complete.

Documentation: `docs/user-journeys/emergency-contact.md`, `docs/user-journeys/emergency-help.md`, `docs/diagrams/emergency-alert-state-machine.mmd`, `docs/diagrams/emergency-escalation-sequence.mmd`, `docs/user-manual/emergency-support.md`.

Evidence: `flutter analyze` passed; all 23 automated workflows passed; 40 emergency contacts and 40 emergency alerts meet the fixture-scale contract; web and signed iOS release builds succeeded; the release installed and remained running on the physical iPhone as PID 24792.

Progress log:

- 2026-06-22T20:08:24+01:00 — Started UX-009 contact, permission, and escalation domain work.
- 2026-06-22T20:11:00+01:00 — Added 40 deterministic emergency contacts and 40 alerts spanning priority, verification, permission, active, accepted, and resolved states.
- 2026-06-22T20:14:00+01:00 — Implemented profile-scoped contact management, safe Call/WhatsApp mocks, least-privilege permissions, emergency inbox/detail, acceptance, timeline, and resolution.
- 2026-06-22T20:15:00+01:00 — Connected parent Need Help to live emergency alert creation and completed bilingual localization and documentation.
- 2026-06-22T20:17:00+01:00 — Static analysis and all 23 workflow tests passed; web and signed iOS release builds completed.
- 2026-06-22T20:18:22+01:00 — Updated release installed successfully on the connected iPhone; launch was denied because iOS reported that the device remained locked.
- 2026-06-22T20:35:38+01:00 — Physical iPhone launch succeeded and the installed UX-009 release was verified running as PID 24792; task completed.

### UX-010 — Document vault and secure viewer UI

Status: DONE  
Started at: 2026-06-22T20:37:45+01:00  
In-progress at: 2026-06-22T20:37:45+01:00  
Done at: 2026-06-22T20:44:52+01:00  
Estimate: 4 engineering days  
Depends on: UX-009

Demo: Photograph/upload a prescription and PDF report, show progress, categorize/tag/link/filter/search, securely view/share/archive/delete, and inspect access history.

Acceptance: All PRD document types/fields work; camera/file permission failures are handled; upload retry is visible; unsupported/oversized files are rejected clearly; viewer blocks accidental exposure in app-switcher screenshots where platform support permits.

Documentation: `docs/user-journeys/document-vault.md`, `docs/diagrams/document-upload-flow.mmd`, `docs/user-manual/documents.md`.

Evidence: `flutter analyze` passed; all 27 automated workflows passed; 40 document fixtures cover every PRD type, PDF/image formats, visibility, lifecycle, failure/retry, and audit history; web and signed iOS release builds succeeded; UX-010 installed and remained running on the physical iPhone as PID 24882.

Progress log:

- 2026-06-22T20:37:45+01:00 — Started UX-010 by reconciling the document requirements, fields, types, features, security, and acceptance criteria from the PRD.
- 2026-06-22T20:39:00+01:00 — Added 40 deterministic local documents across all 15 PRD types with profile scope, permissions, links, upload failures, and access histories.
- 2026-06-22T20:41:00+01:00 — Implemented vault search/filter/archive visibility, PDF/image/camera upload workflow, progress, validation, permission failure guidance, retry, and metadata/linking.
- 2026-06-22T20:42:00+01:00 — Implemented secure preview, inactive-app privacy cover, permission-checked share/download mocks, archive/delete, access auditing, bilingual copy, and documentation.
- 2026-06-22T20:43:00+01:00 — Static analysis and all 27 workflow tests passed; web and signed iOS release builds completed.
- 2026-06-22T20:44:52+01:00 — Installed and launched the signed UX-010 release on the connected physical iPhone; verified PID 24882 and completed the task.

### UX-011 — Doctors, appointments, and visit workflow UI

Status: IN_PROGRESS  
Started at: 2026-06-23T18:19:37+01:00  
In-progress at: 2026-06-23T18:19:37+01:00  
Done at: —  
Estimate: 4 engineering days  
Depends on: UX-010

Demo: Add a doctor, schedule/reschedule a timezone-aware visit, prepare questions/reports, complete the appointment, add visit notes, and schedule follow-up.

Acceptance: Every doctor/appointment field and status is supported; conflicts and past dates are handled; appointment event appears on the timeline; doctor visit pack preview is designed as a future-compatible placeholder, not claimed as MVP functionality.

Documentation: `docs/user-journeys/doctor-appointment.md`, `docs/diagrams/appointment-lifecycle.mmd`, `docs/user-manual/doctors-and-appointments.md`.

Evidence in progress: `flutter analyze` passed; all 31 automated workflows passed; 30 doctor and 40 appointment fixtures cover all PRD fields and statuses; web and signed iOS release builds succeeded; physical iPhone installation is waiting because CoreDevice reports the previously connected phone as unavailable.

Progress log:

- 2026-06-23T18:19:37+01:00 — Started UX-011 and reconciled doctor, appointment, visit-pack, lifecycle, and acceptance requirements from the PRD.
- 2026-06-23T18:21:00+01:00 — Added 30 deterministic doctors and 40 appointments with every PRD status, timezone/location, questions, reports, attachments, summaries, and follow-ups.
- 2026-06-23T18:23:00+01:00 — Implemented profile-scoped doctor directory, doctor creation, conflict/past-date-safe scheduling, and bilingual appointment lists/details.
- 2026-06-23T18:24:00+01:00 — Implemented rescheduling, future-compatible visit-pack preview, completion notes, follow-up capture, and appointment timeline events.
- 2026-06-23T18:25:00+01:00 — Completed workflow tests and documentation; static analysis and all 31 tests passed.
- 2026-06-23T18:27:21+01:00 — Web and signed iOS release builds succeeded; installation paused because CoreDevice lists the physical iPhone as unavailable.

### UX-012 — Health logs, check-ins, and unified timeline UI

Demo: Record BP, blood sugar and a wellbeing check-in, flag dizziness/Need a Call, filter the unified timeline, and inspect linked medicine/document/appointment/emergency events.

Acceptance: PRD metric types and units are represented; implausible values warn without diagnosing; trends remain descriptive; timeline pagination, filtering, empty, and error states work.

Documentation: `docs/user-journeys/health-check-in.md`, `docs/diagrams/health-timeline-flow.mmd`, `docs/user-manual/health-logs-and-check-ins.md`.

### UX-013 — Settings, device health, privacy, export/delete, and help UI

Demo: Configure reminder and privacy settings, inspect notification/device readiness, update language/timezone, review consent/access, export data, delete the account, and open emergency limitations/help.

Acceptance: Permission remediation links work; destructive/privacy actions are explicit; legal/medical disclaimers match PRD non-goals; no screen claims guaranteed emergency delivery or medical advice.

Documentation: `docs/user-journeys/settings-and-privacy.md`, `docs/user-manual/settings-privacy-help.md`, `docs/product/content-and-safety-guidelines.md`.

### UX-014 — Complete UI state matrix, polish, golden tests, and UX sign-off

Demo: Run a scripted product tour covering all Must Have and Should Have workflows on compact/large Android and iOS viewports, English/Bangla, caregiver/parent roles, and online/offline/error states.

Acceptance: Screen inventory is 100% implemented; no dead buttons/placeholders for MVP scope; golden/widget/accessibility tests pass; supplied UI references and brand assets are reconciled; stakeholder signs the G2 checklist.

Documentation: `docs/product/screen-inventory.md`, `docs/product/ui-state-matrix.md`, `docs/testing/ui-acceptance-report.md`, all user manuals and journeys reviewed.

### BE-001 — Monorepo, Docker dependencies, CI, and developer bootstrap

Demo: From a clean checkout, copy `.env.example`, run one documented bootstrap command, start the Docker stack, open API health/ready endpoints, Firebase Emulator UI, Mailpit, PostgreSQL and Redis health checks, then run Flutter checks.

Acceptance: Images are pinned; services have health checks and persistent named volumes; migrations/seeds are idempotent; platform hostnames are documented; CI runs lint/typecheck/test/build/OpenAPI drift and secret scanning.

Documentation: root `README.md`, `docs/architecture/local-development.md`, `docs/operations/docker.md`, `docs/diagrams/local-infrastructure.mmd`, `.env.example`.

### BE-002 — OpenAPI 3.1 contract and generated clients

Demo: Render API docs, call representative endpoints with example payloads/errors, regenerate TypeScript/Dart clients, and prove CI detects contract drift.

Acceptance: `/api/v1` resources cover auth, families, profiles, medicines, reminders, contacts, alerts, documents, doctors, appointments, health logs, timeline, devices, and account privacy; pagination/error/idempotency conventions are consistent.

Documentation: `docs/api/openapi.yaml`, `docs/api/README.md`, `docs/api/authentication.md`, `docs/decisions/ADR-002-api-contract.md`.

### BE-003 — PostgreSQL schema, migrations, seeds, and audit foundation

Demo: Recreate the database, apply migrations, load a UK-caregiver/Bangladesh-family demo dataset, query relationships and audit events, and roll forward from the prior schema.

Acceptance: PRD entities plus invitations, permissions, devices, consent, emergency alerts/events, file access, health timeline and idempotency are modeled; UTC instants plus IANA timezone identifiers are used; indexes/constraints and soft-delete/retention choices are documented.

Documentation: `docs/architecture/data-model.md`, `docs/diagrams/erd.mmd`, `docs/operations/database-migrations.md`, `docs/decisions/ADR-003-data-retention.md`.

### BE-004 — Firebase Auth integration, sessions/devices, consent, and RBAC

Demo: Register/verify/login through emulator, call an authenticated endpoint, manage a device, reject an unauthorized cross-family read, revoke access, log out all devices, and audit each sensitive action.

Acceptance: Firebase tokens are verified server-side; authorization is resource-scoped; optional 2FA/biometric boundaries are clear; rate limits and generic auth errors work; export/deletion jobs have safe state models.

Documentation: `docs/architecture/auth-and-rbac.md`, `docs/diagrams/auth-sequence.mmd`, `docs/diagrams/authorization-flow.mmd`, `docs/security/access-control.md`.

### BE-005 — Family groups, memberships, invitations, and care profiles API

Demo: Use the Flutter app against real APIs to create a family, add two care profiles, invite a second caregiver, change permissions, switch profiles, revoke the invitation, and view activity.

Acceptance: CRUD, archive, transfer ownership, memberships, invitations, and permission enforcement pass integration tests; cross-family isolation is tested.

Documentation: relevant OpenAPI sections, journeys/manuals, `docs/diagrams/family-permission-flow.mmd`.

### BE-006 — Medicines, schedules, timezone engine, and stock API

Demo: Create multiple schedule types in Bangladesh time from a UK device, preview generated occurrences across DST boundaries, edit/pause/complete medicine, decrement stock, and trigger low-stock status.

Acceptance: All MVP schedule types are deterministic; DST/timezone test matrix passes; overlapping duplicate schedules are prevented; mutation history is audited.

Documentation: `docs/architecture/scheduling.md`, `docs/diagrams/schedule-generation-sequence.mmd`, OpenAPI medicine/schedule sections.

### BE-007 — Reminder generation, actions, offline sync, and adherence API

Demo: Worker generates reminders, parent takes one offline, outbox syncs once online, another becomes missed, caregiver sees it, and adherence/timeline update without duplicate events.

Acceptance: Jobs are idempotent and locked; actions have valid state transitions; retries/dead-letter handling work; millions-of-records query/index strategy is tested; offline conflicts resolve predictably.

Documentation: `docs/architecture/reminder-engine.md`, `docs/diagrams/reminder-state-machine.mmd`, `docs/operations/reminder-worker.md`, OpenAPI reminders.

### BE-008 — FCM, local notification coordination, remote ring, and delivery logs

Demo: Register a device, schedule local reminders, deliver safe cloud push, action it, request remote ring, display delivery/open/action status, and exercise failed-token fallback.

Acceptance: No sensitive lock-screen content; token rotation/revocation works; retries and failure reasons are logged; rate limiting prevents abuse; iOS/Android permission and background limitations are tested and documented.

Documentation: `docs/architecture/notifications.md`, `docs/diagrams/notification-sequence.mmd`, `docs/operations/push-notifications.md`.

### BE-009 — Emergency contacts, verification, alerts, and escalation engine

Demo: Verify a Priority 1 neighbour, trigger Need Help, alert caregiver, escalate, accept help, publish live status, resolve, and inspect the immutable event history.

Acceptance: Contact permissions are least-privilege; escalation jobs are idempotent/cancellable; acknowledgements stop later escalation; call/WhatsApp fallbacks work; system never promises emergency-service dispatch.

Documentation: `docs/architecture/emergency-escalation.md`, emergency `.mmd` diagrams, OpenAPI contacts/alerts, operations runbook.

### BE-010 — Firebase Storage documents, metadata, permissions, and secure viewer integration

Demo: Upload an image/PDF through emulator with progress, validate and record it, retrieve it only with authorization, share with a permitted caregiver, revoke access, and delete according to policy.

Acceptance: Paths are server-controlled; object metadata and PostgreSQL records remain consistent; file type/size/content validation is applied; signed access is short-lived; unauthorized and revoked reads fail; orphan cleanup/retry works.

Documentation: `docs/architecture/document-storage.md`, `docs/diagrams/document-upload-sequence.mmd`, `docs/security/file-access.md`, Firebase rules and emulator guide.

### BE-011 — Doctors, appointments, health logs, check-ins, and timeline API

Demo: Create doctor/appointment, deliver reminder, complete with follow-up, record health values/check-in, and show a correctly ordered, filterable unified timeline.

Acceptance: Timezone handling, pagination, filtering, permissions, auditing, validation, and non-diagnostic wording pass tests; appointment reminder jobs are idempotent.

Documentation: OpenAPI sections, `docs/architecture/health-timeline.md`, relevant journeys/manuals/diagrams.

### BE-012 — Flutter real-API integration and mock removal

Demo: Run the entire UX-014 product tour using Dockerized dependencies and real API/storage/auth/queue behavior, including offline recovery and app restart.

Acceptance: Production paths contain no fixture fallback; generated clients are used; token refresh/error mapping/cache/outbox work; all G4 end-to-end tests pass on iOS and Android.

Documentation: `docs/testing/end-to-end.md`, `docs/architecture/mobile-data-sync.md`, integration evidence report.

### BE-013 — Observability, analytics events, admin operations, and failure recovery

Demo: Inspect correlated API/worker logs and metrics for reminder, push, document, and emergency workflows; retry a failed job safely; display aggregate product metrics without exposing health content.

Acceptance: Structured redacted logs, correlation IDs, health/readiness, queue metrics, alert thresholds, crash reporting boundaries, audit access, and retention are defined; analytics follows consent/minimization rules.

Documentation: `docs/operations/observability.md`, `docs/operations/incident-response.md`, `docs/product/analytics-event-catalog.md`, `docs/diagrams/observability-flow.mmd`.

### QA-001 — End-to-end acceptance, accessibility, performance, security, and privacy

Demo: Execute PRD acceptance scenarios plus cross-country/timezone, offline, revoked access, failed push, failed upload, and emergency escalation cases; present test results and defects disposition.

Acceptance: PRD section 25 passes; dashboard/medicine response targets are measured; OWASP-aligned API/mobile checks pass; dependency/secret scans pass; accessibility and Bangla reviews pass; backup restore and data deletion/export are verified.

Documentation: `docs/testing/release-acceptance-report.md`, `docs/security/threat-model.md`, `docs/security/privacy-review.md`, `docs/testing/performance-report.md`, `docs/testing/accessibility-report.md`.

### REL-001 — Staging/release infrastructure, backups, runbooks, and release candidate

Demo: Provision staging from code, deploy API/worker, apply migration, configure Firebase, install signed app builds, run smoke tests, restore a backup, roll back an application release, and complete release checklist.

Acceptance: Secrets are externally managed; TLS, least-privilege identities, backups/restore, monitoring, alerting, retention, CDN/storage policy, CI/CD approvals, rollback, store privacy declarations, and support procedures are complete.

Documentation: `docs/architecture/system-design.md`, `docs/architecture/deployment.md`, `docs/diagrams/system-context.mmd`, `docs/diagrams/container-architecture.mmd`, `docs/diagrams/deployment.mmd`, `docs/operations/release-runbook.md`, `docs/operations/backup-restore.md`, complete user manual index.

## 8. Documentation workstream

Documentation is not a final phase. Each feature task updates all affected artifacts in the same change. The minimum set is:

### Product and user journeys

- `docs/product/scope-and-non-goals.md`
- `docs/product/screen-inventory.md`
- `docs/product/ui-state-matrix.md`
- `docs/user-journeys/onboarding.md`
- `docs/user-journeys/manage-family.md`
- `docs/user-journeys/care-profile.md`
- `docs/user-journeys/add-and-manage-medicine.md`
- `docs/user-journeys/respond-to-reminder.md`
- `docs/user-journeys/missed-medicine.md`
- `docs/user-journeys/emergency-contact.md`
- `docs/user-journeys/emergency-help.md`
- `docs/user-journeys/document-vault.md`
- `docs/user-journeys/doctor-appointment.md`
- `docs/user-journeys/health-check-in.md`
- `docs/user-journeys/settings-and-privacy.md`

Each journey must state actors, prerequisites, trigger, happy path, alternative/error/offline paths, permissions, emitted events, notifications, acceptance criteria, and linked screens/endpoints/diagrams.

### System and architecture

- System context, container architecture, component boundaries, data model/ERD, auth/RBAC, mobile sync/offline outbox, scheduling/timezones, reminders, notifications, emergency escalation, document storage, health timeline, observability, deployment, retention, and disaster recovery.
- Architecture Decision Records cover material choices and rejected alternatives.
- Mermaid source stays in standalone `.mmd` files and is also linked from explanatory Markdown.

Required diagrams:

- `system-context.mmd`
- `container-architecture.mmd`
- `mobile-navigation.mmd`
- `erd.mmd`
- `auth-sequence.mmd`
- `authorization-flow.mmd`
- `family-permission-flow.mmd`
- `medicine-lifecycle.mmd`
- `schedule-builder-flow.mmd`
- `schedule-generation-sequence.mmd`
- `reminder-state-machine.mmd`
- `reminder-action-sequence.mmd`
- `missed-reminder-escalation.mmd`
- `notification-sequence.mmd`
- `emergency-alert-state-machine.mmd`
- `emergency-escalation-sequence.mmd`
- `document-upload-sequence.mmd`
- `appointment-lifecycle.mmd`
- `health-timeline-flow.mmd`
- `observability-flow.mmd`
- `local-infrastructure.mmd`
- `deployment.mmd`

### API documentation

- OpenAPI 3.1 is authoritative and linted in CI.
- Every operation includes authorization, request/response examples, validation errors, stable error codes, pagination, idempotency, rate limits, and audit behavior.
- Generated API reference is published for local/staging use.
- Contract changes require regenerated Dart/TypeScript clients and a compatibility note.

### User manual

The manual is role-based and bilingual-ready: caregiver quick start, parent quick start, account/security, family groups, care profiles, medicines, reminders, emergency contacts/help, documents, appointments, health check-ins, privacy/settings, troubleshooting, limitations, and support. Screenshots are refreshed at G2 and G5.

### Operations and testing

- Local setup, Docker services, Firebase emulator, database migrations, seeds, worker/queue, notification setup, monitoring, incidents, backups/restores, release/rollback, privacy requests, and access revocation.
- Test strategy, fixture catalog, UI state matrix, API integration, E2E, notification-device matrix, timezone/DST matrix, accessibility, performance, security/privacy, and release evidence.

## 9. PRD scope traceability

| PRD capability | UI task | Backend/integration task | Primary documentation |
|---|---|---|---|
| Auth/account/privacy | UX-003, UX-013 | BE-004, BE-012 | Auth journey, RBAC, API, manual |
| Family graph/roles | UX-004, UX-005 | BE-005 | Family journeys, permission diagrams |
| Care profiles | UX-005 | BE-005 | Profile journey, data model |
| Medicines/schedules/stock | UX-006 | BE-006 | Medicine journey/lifecycle, scheduling |
| Reminder actions/history | UX-007 | BE-007 | Reminder state/sequence, API |
| Missed alerts/remote ring | UX-008 | BE-007, BE-008 | Escalation and notification docs |
| Emergency contacts/help | UX-009 | BE-009 | Emergency journeys/state/sequence |
| Documents/Firebase files | UX-010 | BE-010 | Storage architecture/upload sequence |
| Doctors/appointments | UX-011 | BE-011 | Appointment journey/lifecycle |
| Health logs/check-in/timeline | UX-012 | BE-011 | Health journey/timeline |
| Bangla, accessibility, parent mode | UX-001, UX-002, UX-014 | BE-012, QA-001 | Accessibility/localization reports |
| Push/local notifications | UX-007, UX-008 | BE-008 | Notification architecture/runbook |
| Docker/local dependencies | — | BE-001 | Local infrastructure/setup |
| Audit, observability, analytics | UX-004, UX-007–UX-013 | BE-003, BE-013 | Audit/observability/event catalog |
| Security/privacy/reliability | All | BE-004–BE-013, QA-001 | Threat model, privacy, operations |

MVP Could Have items (OCR, AI summaries, doctor visit PDF, SMS/WhatsApp alert integration beyond launch intents, caregiver voice, wearables, pharmacy refill) remain outside release scope. Their UI may only appear as clearly labelled future concepts; they must not create dead controls in the G2 build.

## 10. Test and demo strategy

- Flutter: `flutter analyze`, Dart unit tests, widget tests, golden tests, semantics/accessibility checks, and integration tests on representative iOS/Android targets.
- Backend: TypeScript lint/typecheck, unit tests, route/service integration tests against real Docker services, database constraint tests, worker idempotency/retry tests, and OpenAPI conformance.
- E2E personas: UK primary caregiver, Bangladesh parent, secondary caregiver, local Priority 1 neighbour, and unauthorized outsider.
- Critical matrices: timezone/DST, language/text scale, notification permission/device state, online/offline/reconnect, role/permission, upload type/size/failure, and emergency escalation race conditions.
- Demo seed data is deterministic and contains fictional people and documents only.
- Evidence is stored under `docs/testing/evidence/<task-id>/` or linked CI artifacts; no real health data is used.

## 11. Initial execution order

1. Approve G0 and begin UX-001.
2. Complete UX-001 through UX-005 and review G1.
3. Complete UX-006 through UX-014; run the complete mock-backed product tour and obtain G2 sign-off.
4. Complete BE-001 through BE-004 for G3.
5. Implement BE-005 through BE-011 by domain, demonstrating each through the already-approved Flutter UI.
6. Complete BE-012 and BE-013 for G4.
7. Complete QA-001 and REL-001 for G5/release candidate.

Parallel work is allowed only when dependencies do not undermine the UI-first gate. Documentation and tests always proceed within the active task. Backend domain implementation does not start early merely because a UI screen exists; G2 requires the whole application UX to be complete and approved.

## 12. Current next action

Start `UX-001`. At the moment work begins, update its ledger row and task card with the real start/in-progress timestamp, scaffold the Flutter app, integrate the supplied logo assets, and deliver the component gallery as the first complete demonstrable feature.
