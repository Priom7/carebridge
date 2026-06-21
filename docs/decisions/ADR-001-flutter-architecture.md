# ADR-001: Flutter mobile presentation architecture

Date: 2026-06-21  
Status: Accepted

## Context

CareBridge requires one iOS/Android application with caregiver and elderly-friendly parent experiences, reliable local notifications, offline behavior, secure storage, camera/document access, localization, and testable UI. The user selected Flutter.

## Decision

Use Flutter/Dart with a feature-first source layout. Cross-feature presentation foundations live under `lib/core`; feature UI lives under `lib/features/<feature>/presentation`. The application will use Material 3 as an accessibility-capable base while CareBridge tokens control brand and status semantics.

Planned application boundaries:

- GoRouter for typed/guarded route composition
- Riverpod for state and dependency injection
- Repository interfaces between presentation and data sources
- Deterministic fixture repositories through the complete UI phase
- Dio plus OpenAPI-generated models/client for backend integration
- Drift-backed cache and offline outbox
- Firebase Messaging and local notifications behind platform service interfaces
- Secure storage for device secrets; no sensitive values in ordinary preferences

The UI phase must not import backend-specific behavior into widgets. Repository adapters will be swapped after UI/UX sign-off.

## Consequences

- UI workflows can be completed and demonstrated before backend implementation.
- Widget, golden, semantics, and integration tests can run deterministically.
- Extra discipline is required to keep fixture contracts aligned with OpenAPI.
- Platform notification/alarm limitations still require separate iOS and Android testing.

## Alternatives considered

- React Native: rejected because Flutter was explicitly selected and offers predictable custom rendering across the target platforms.
- Screen-by-screen stateful widgets: rejected because it would couple navigation, data, and presentation and make the later API swap expensive.
- Backend-first shared DTOs: deferred; OpenAPI will become the contract source in BE-002 after the full UI contract is known.
