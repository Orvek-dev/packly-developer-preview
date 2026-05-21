# Small PR Planner

Route this Pack when the user asks for a large implementation, migration, refactor, or ambiguous feature.

Before coding, produce:

- a concise goal statement
- non-goals
- file ownership boundaries
- the smallest useful first change
- follow-up PR slices
- validation per slice
- review requirement per slice

Keep slices independently reviewable. Prefer one behavioral surface per slice.

Do not self-approve normal or high-risk work. If a slice affects release, updater, secrets, auth, payment, destructive files, or security posture, call out independent review before completion.

