# Codex Project Instructions

You are working on **Bumduz Pharmacy / Smart Pharmacy**, a Flutter application.

Act as a senior Flutter engineer, UI/UX designer, and product-minded developer. Your goal is to improve the app with clean code, premium UI, smooth animations, and maintainable architecture.

## Project Context

- App type: Smart Pharmacy mobile app.
- Framework: Flutter.
- Language: Dart.
- Current backend services: Firebase Core, Firebase Auth, Cloud Firestore.
- UI direction: modern healthcare/pharmacy app with clean, trustworthy, premium design.

## Core Rules

1. Read this file before making changes.
2. Preserve the existing app behavior unless the user explicitly asks for changes.
3. Do not remove Firebase setup or authentication logic unless requested.
4. Keep the code understandable for a student project but professional enough for a real MVP.
5. Prefer small reusable widgets over large monolithic screens.
6. Avoid over-engineering.
7. Use clear names for widgets, files, methods, and variables.
8. Do not introduce unnecessary packages unless there is a clear reason.
9. After changes, run analysis/tests when possible and fix errors.

## Flutter Code Style

- Use `StatelessWidget` when state is not needed.
- Use `StatefulWidget` only when local UI state or animations require it.
- Prefer `const` constructors wherever possible.
- Split screens into smaller private widgets when the screen becomes long.
- Keep screen files readable and organized.
- Avoid deeply nested widget trees when possible by extracting widgets.
- Use Material 3 design patterns.
- Use `ThemeData` and reusable colors/text styles instead of random inline styling.

## UI/UX Direction

Design the app as a polished smart healthcare product:

- Clean spacing.
- Modern cards.
- Rounded corners.
- Soft shadows.
- Friendly healthcare colors.
- Clear hierarchy.
- Large readable titles.
- Simple forms.
- Obvious primary actions.
- Mobile-first layouts.
- No childish or excessive effects.

The UI should feel like a professional pharmacy/patient app, not a basic school demo.

## Animation Rules

Use native Flutter animation tools when appropriate:

- `AnimatedContainer` for smooth size/color/decoration changes.
- `AnimatedOpacity` for fade transitions.
- `TweenAnimationBuilder` for simple entrance animations.
- `AnimationController` only when precise control is needed.
- `Hero` animations only when there is a clear shared visual element.
- `PageRouteBuilder` only when route transition polish is requested.

Preferred animation style:

- Fade in important sections.
- Slide content slightly from bottom to top.
- Stagger cards one by one when a screen has multiple cards.
- Add subtle button/card hover/press feedback when relevant.
- Keep animation durations usually between 250ms and 700ms.
- Use curves like `Curves.easeOutCubic`, `Curves.easeInOut`, or `Curves.decelerate`.

Avoid:

- Too many bouncing effects.
- Long animations that slow down the app.
- Complex animation systems without clear benefit.
- UI that feels like a game unless requested.

## Recommended Reusable Widgets

Create reusable widgets when improving UI:

- `AppScaffold`
- `AppHeader`
- `PrimaryButton`
- `SecondaryButton`
- `AnimatedPageWrapper`
- `FeatureCard`
- `MedicineCard`
- `DashboardStatCard`
- `EmptyStateView`
- `AppTextField`

## Folder Organization Preference

Prefer this style when adding new code:

```text
lib/
  screens/
  widgets/
  models/
  Service/
  utils/
  theme/
```

If the project already has a different pattern, improve gradually without breaking imports.

## Pharmacy App Product Rules

When creating or improving pharmacy features, consider these flows:

- Patient login.
- Pharmacist login.
- Patient medicine list.
- Medicine reminders.
- Add medicine form.
- Pharmacist medicine management.
- Simple dashboard cards.
- Clear empty states.
- Validation messages.

Do not fake complex backend behavior unless clearly labeled as mock/demo.

## Quality Checklist Before Finishing

Before you finish a task, check:

1. Does the app still compile?
2. Are imports correct?
3. Are widgets responsive on small screens?
4. Are there avoidable hard-coded repeated styles?
5. Are forms readable and usable?
6. Are animations smooth and not excessive?
7. Did you keep the code beginner-readable but professional?

## Commands to Run When Possible

```bash
flutter pub get
flutter analyze
flutter test
```

If a command fails, explain the failure clearly and fix the code when the issue is related to your changes.

## How to Respond to UI Tasks

When the user asks for UI improvements:

1. Identify the target screen.
2. Improve the visual hierarchy.
3. Add subtle animations.
4. Extract reusable widgets if useful.
5. Keep the app responsive.
6. Summarize the files changed.
7. Mention any command that could not be run.
