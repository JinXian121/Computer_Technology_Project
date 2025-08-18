# GitHub Project Board Setup Guide

This document provides instructions for setting up a GitHub Project board for effective project management.

## Project Board Overview

Our project management workflow uses GitHub Projects (v2) with a Kanban-style board to track work progress. This integrates seamlessly with Issues, Pull Requests, and Milestones.

## Setting Up Your Project Board

### Step 1: Create a New Project

1. Navigate to your repository on GitHub
2. Click on the "Projects" tab
3. Click "New project" button
4. Select "Board" as the template
5. Name your project (e.g., "Team Sprint Board", "Semester Project Tracker")
6. Add a description explaining the project's purpose
7. Set visibility (typically "Public" for course projects)

### Step 2: Configure Columns

Create the following columns in this order:

#### 1. **Backlog**
- **Purpose**: All unplanned or future work items
- **Description**: Items that are identified but not yet scheduled
- **Automation**: None

#### 2. **To Do (This Week)**
- **Purpose**: Items planned for the current week/sprint
- **Description**: Work that has been prioritized and assigned
- **Automation**: 
  - When issues are added to project → Move to this column
  - When issues are reopened → Move to this column

#### 3. **In Progress**
- **Purpose**: Active work items
- **Description**: Tasks currently being worked on
- **Automation**: 
  - When PR is opened → Move linked issues here
  - Limit WIP (Work in Progress) to 2-3 items per person

#### 4. **Review**
- **Purpose**: Work awaiting review or approval
- **Description**: Completed work that needs peer review
- **Automation**: 
  - When PR is marked as "Ready for review" → Move here
  - When issue is labeled "status: review" → Move here

#### 5. **Done**
- **Purpose**: Completed work items
- **Description**: Work that has been reviewed and merged
- **Automation**: 
  - When issues are closed → Move here
  - When PR is merged → Move linked issues here

### Step 3: Configure Project Settings

1. Click on the ⚙️ (Settings) icon in your project
2. Configure the following:

#### General Settings
- Enable "Project description"
- Set up README if needed

#### Manage Access
- Add all team members as collaborators
- Set appropriate permissions (typically "Write" for team members)

#### Workflows (Automation)
1. Click "Workflows" in settings
2. Enable "Item added to project"
3. Configure automations as described in Step 2

### Step 4: Custom Fields (Optional but Recommended)

Add these custom fields for better tracking:

1. **Priority** (Single select)
   - Options: Critical, High, Medium, Low

2. **Estimate** (Number)
   - Story points or hours

3. **Sprint** (Iteration)
   - Link to milestone/sprint cycles

4. **Type** (Single select)
   - Options: Feature, Bug, Task, Research

## Best Practices

### Daily Usage
1. **Start of Day**: Review "To Do" column
2. **When Starting Work**: Move item to "In Progress"
3. **When Stuck**: Add "status: blocked" label and comment
4. **When Complete**: Move to "Review" and request review
5. **End of Day**: Update item status and add comments

### Weekly Planning
1. Review "Backlog" items
2. Move next week's work to "To Do"
3. Ensure all items have:
   - Clear descriptions
   - Acceptance criteria
   - Assigned team members
   - Priority labels
   - Time estimates

### Card Management
- Each card should represent one Issue
- Link Pull Requests to Issues
- Use labels consistently
- Add estimates for planning
- Update status regularly

## Integration with Weekly Reports

The project board directly feeds into weekly reports:
- **Completed items**: Move from "Review" to "Done"
- **In-progress work**: Items in "In Progress" column
- **Blockers**: Items with "status: blocked" label
- **Next week's plan**: Items in "To Do" column

## Views and Filters

Create these saved views for quick access:

1. **My Work**: Assignee = @me
2. **This Week**: Sprint = current
3. **High Priority**: Priority = High OR Critical
4. **Blocked Items**: Label = "status: blocked"
5. **Team Member View**: Group by Assignee

## Tips for Students

1. **Update Daily**: Keep the board current
2. **Communicate Blockers**: Don't wait for meetings
3. **Small Tasks**: Break large items into smaller ones
4. **Clear Descriptions**: Future you will thank you
5. **Use Templates**: For recurring task types

## Troubleshooting

### Common Issues

**Items not moving automatically?**
- Check workflow automation settings
- Ensure proper labels are applied
- Verify PR/Issue linking

**Can't see the project?**
- Check access permissions
- Ensure you're logged in
- Ask project admin for access

**Board feels cluttered?**
- Archive completed sprints
- Use filters to focus view
- Move old items to backlog

## Additional Resources

- [GitHub Projects Documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [Automation with GitHub Actions](https://docs.github.com/en/actions)
- [Issue and PR Templates](.github/ISSUE_TEMPLATE/)