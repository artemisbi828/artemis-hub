---
aliases:
  - CI/CD
definition: It's a set of practices used in modern software development to automate and streamline how code gets built, tested, and released.
related_to:
  - "[[Git]]"
---
🚧 CI — Continuous Integration
Goal: Automatically build and test code every time someone pushes changes to a shared Git repository.
What it does:

Developers push code to Git (GitHub, GitLab, Azure DevOps, etc.).
A pipeline automatically:

Pulls the new code
Builds it
Runs tests (unit, integration, linting)


If something breaks, the pipeline fails and alerts the team.

Why it matters:
You catch bugs early and keep the main branch stable.

🚀 CD — Continuous Delivery or Continuous Deployment
CD can mean one of two things:
1️⃣ Continuous Delivery
Your pipeline automatically prepares releases, but a human approves deployment.
Example:
Code → Build → Test → Ready to deploy → Human clicks “Deploy”.
2️⃣ Continuous Deployment
Every code change that passes the pipeline is automatically deployed to production.
Example:
Code → Build → Test → Auto-deployed.
Why it matters:
It reduces manual work and ensures updates reach users quickly and reliably.

🔁 CI/CD + Git
Putting it all together:

You commit code to a Git branch
CI pipeline runs automatically
If successful, CD pipeline delivers or deploys the app
Dev team gets faster, safer releases

Tools you might see:

GitHub Actions
GitLab CI
Azure DevOps Pipelines
Jenkins
CircleCI