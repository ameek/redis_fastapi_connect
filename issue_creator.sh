#!/bin/bash

REPO="ameek/redis_fastapi_connect"

declare -A milestones=(
    ["Milestone 1: Database & Redis Sync"]="✅ Goal: Persist Redis data to PostgreSQL/MySQL"
    ["Milestone 2: Microservices & Messaging"]="✅ Goal: Split into Counter Service & Database Sync Service"
    ["Milestone 3: CI/CD & Automation"]="✅ Goal: Automate testing & deployments"
    ["Milestone 4: Authentication & Rate Limiting"]="✅ Goal: Secure API & prevent abuse"
    ["Milestone 5: Real-time Updates with WebSockets"]="✅ Goal: Live updates without refresh"
    ["Milestone 6: Swagger API Docs & Final Testing"]="✅ Goal: API documentation & final checks"
)

declare -A sub_issues
sub_issues["Milestone 1: Database & Redis Sync"]="Setup PostgreSQL/MySQL & SQLAlchemy|Define models & migrations|Implement background sync to DB|Create API to fetch historical counts|Testing & Debugging"
sub_issues["Milestone 2: Microservices & Messaging"]="Refactor Counter Service|Refactor Database Sync Service|Set up RabbitMQ/Kafka for event-driven syncing|Testing & Debugging"
sub_issues["Milestone 3: CI/CD & Automation"]="Set up GitHub Actions for CI|Set up Docker builds & push to DockerHub|Deploy to GCP Cloud Run / AWS"
sub_issues["Milestone 4: Authentication & Rate Limiting"]="Implement JWT authentication (Auth0/custom)|Add Redis-based rate limiting|Build an admin panel to monitor hit counts"
sub_issues["Milestone 5: Real-time Updates with WebSockets"]="Add WebSocket support in FastAPI|Implement Redis Pub/Sub for updates|Build a real-time dashboard UI"
sub_issues["Milestone 6: Swagger API Docs & Final Testing"]="Implement OpenAPI (Swagger) docs|Final testing & bug fixes"

for milestone in "${!milestones[@]}"; do
    milestone_body="${milestones[$milestone]}"
    
    # Create the milestone issue
    milestone_issue=$(gh issue create --repo "$REPO" --title "$milestone" --body "$milestone_body")
    
    echo "✅ Created milestone issue: $milestone"

    # Prepare checklist for sub-issues
    checklist="### Sub-Issues:\n"

    # Create sub-issues for this milestone
    IFS="|" read -ra tasks <<< "${sub_issues[$milestone]}"
    for task in "${tasks[@]}"; do
        sub_issue=$(gh issue create --repo "$REPO" --title "$task" --body "Related to: $milestone")
        checklist+="- [ ] $task\n"
        echo "  ➖ Created sub-issue: $task"
    done

    # Update milestone issue with sub-issue checklist
    gh issue edit "$(echo "$milestone_issue" | awk '{print $NF}')" --repo "$REPO" --body "$milestone_body\n\n$checklist"
    echo "🔄 Updated milestone with sub-issues: $milestone"
done
