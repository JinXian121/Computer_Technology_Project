# GitHub Actions Documentation

This repository includes automated GitHub Actions to streamline team workflows and reduce manual work. These actions are designed to save approximately 100+ minutes per week by automating repetitive tasks.

## Available Actions

### 1. Weekly Report Generation (`weekly-report.yml`)

**Purpose**: Automatically generates weekly progress reports by collecting data from GitHub activity.

**Schedule**: Runs every Friday at 9:00 AM UTC (configurable)

**What it does**:
- Collects commits from the past week
- Tracks issues opened and closed
- Monitors pull requests created and merged
- Parses meeting notes (if available)
- Creates a formatted report following the team template
- Opens a pull request with the generated report

**Manual Trigger**: You can manually run this action from the Actions tab → Weekly Report Generation → Run workflow

**Configuration**:
- `REPORT_TIME_ZONE`: Set your local timezone (default: UTC)
- `REPORT_WEEK_START`: Choose when your week starts (default: Monday)

**Time Saved**: ~30 minutes per week

### 2. Team Setup Automation (`team-setup.yml`)

**Purpose**: Automatically configures a new team repository with all necessary structure and resources.

**Triggers**:
- When repository is created from template
- Manual trigger from Actions tab
- First push to main branch

**What it does**:
- Creates project directory structure:
  - `docs/team` - Team documentation
  - `docs/architecture` - Architecture decisions
  - `src` - Source code
  - `tests` - Test files
  - `resources` - Additional resources
  - `.github/scripts` - GitHub Actions scripts
- Generates `.gitignore` file with common exclusions
- Creates GitHub Project Board with columns (To Do, In Progress, Review, Done)
- Creates welcome issue with getting started guide
- Creates 5 onboarding issues:
  - Update Team Information
  - Set Up Development Environment
  - Schedule First Team Meeting
  - Review Project Requirements
  - Establish Team Communication Channels
- Attempts to set up branch protection rules (requires admin permissions)

**Time Saved**: ~45 minutes for initial setup

## Supporting Scripts

### Meeting Notes Parser (`parse-meeting-notes.py`)

Located in `.github/scripts/parse-meeting-notes.py`

**Purpose**: Parses markdown meeting notes to extract structured information for weekly reports.

**Features**:
- Extracts meeting date, attendees, decisions, and action items
- Supports various meeting note formats
- Generates summary for weekly reports

**Usage**:
```bash
python .github/scripts/parse-meeting-notes.py \
  --start-date 2024-01-01 \
  --end-date 2024-01-07 \
  --output-format markdown
```

## How to Use

### For New Teams

1. **Create repository from template**
   - The team setup action will run automatically
   - Check the Issues tab for your onboarding tasks
   - Review the generated project structure

2. **Configure your team**
   - Update `TEAM_INFO.md` with your team details
   - Assign the onboarding issues to team members
   - Set up branch protection if needed (Settings → Branches)

### Weekly Reports

1. **Automatic generation**
   - Reports are generated every Friday at 9 AM
   - Check Pull Requests tab for the generated report
   - Review and update the report as needed
   - Merge the PR to publish the report

2. **Manual generation**
   - Go to Actions tab
   - Select "Weekly Report Generation"
   - Click "Run workflow"
   - Select the branch and run

### Meeting Notes

To ensure meeting notes are included in weekly reports:

1. Save meeting notes in the `/meetings` folder
2. Use markdown format (`.md` extension)
3. Include date in filename (e.g., `2024-01-15-team-meeting.md`)
4. Follow this structure:
   ```markdown
   # Team Meeting - January 15, 2024
   
   ## Attendees
   - John Doe
   - Jane Smith
   
   ## Agenda
   - Topic 1
   - Topic 2
   
   ## Decisions
   - Decided to implement feature X
   - Agreed on timeline for milestone 2
   
   ## Action Items
   - @John: Complete design mockups
   - @Jane: Review API documentation
   ```

## Customization

### Modifying Report Schedule

Edit `.github/workflows/weekly-report.yml`:
```yaml
on:
  schedule:
    - cron: '0 9 * * 5'  # Change this line
```

Cron format: `minute hour day month day-of-week`
- `0 14 * * 5` = 2 PM every Friday
- `0 9 * * 1` = 9 AM every Monday

### Adding Custom Directories

Edit `.github/workflows/team-setup.yml` and add directories to the array:
```bash
directories=(
    "docs/team"
    "your/custom/directory"  # Add here
)
```

### Changing Project Board Columns

Edit `.github/workflows/team-setup.yml`:
```javascript
const columns = ['To Do', 'In Progress', 'Review', 'Done', 'Your Column'];
```

## Troubleshooting

### Weekly Report Not Generated

1. Check if the action ran (Actions tab → Weekly Report Generation)
2. Verify you have commits/issues/PRs in the date range
3. Check action logs for errors
4. Ensure proper permissions are set

### Team Setup Failed

1. Check action logs for specific errors
2. Branch protection may fail without admin permissions - set manually
3. Project board creation may fail if projects are disabled
4. Ensure repository has proper permissions for GitHub Actions

### Meeting Notes Not Included

1. Verify meeting files are in `/meetings` folder
2. Check file dates match the report week
3. Ensure files use `.md` extension
4. Run the parser script manually to test

## Benefits

Using these automated actions provides:

- **Time Savings**: 100+ minutes per week
- **Consistency**: Standardized reports and setup
- **Transparency**: Automatic tracking of progress
- **Reduced Errors**: No manual data collection
- **Better Focus**: More time for actual project work

## Support

If you encounter issues:
1. Check the action logs in the Actions tab
2. Review this documentation
3. Check if similar issues exist in the Issues tab
4. Create a new issue with:
   - Action name that failed
   - Error message from logs
   - Steps to reproduce

---

*These actions are part of the UNI_TEAM_KIT automation system designed to reduce manual work from 155 to under 52 minutes per week.*