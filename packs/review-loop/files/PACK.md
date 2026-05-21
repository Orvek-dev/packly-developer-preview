# Review Loop

Route this Pack when the task asks for fixing, verifying, reviewing, or stabilizing code.

Workflow:

1. Identify the smallest failing or risky behavior.
2. Make the narrowest change that addresses it.
3. Run the focused test or smoke command closest to the touched layer.
4. Review the resulting diff for regressions, missing validation, and accidental scope creep.
5. Fix any issue found in the review.
6. Report remaining test gaps or residual risk.

For review output, lead with findings. If no findings are found, say that clearly and mention residual test gaps.

