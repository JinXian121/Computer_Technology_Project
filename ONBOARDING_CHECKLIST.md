# 🚀 Student Team Onboarding Checklist

Welcome to your team project! This interactive checklist will guide you through setting up your repository and establishing effective workflows. Check off each item as you complete it.

## 📊 Progress Tracker
Track your overall progress here:
- [x] Pre-Course Setup Complete
- [x] Week 1 Tasks Complete  
- [ ] Week 2 Tasks Complete
- [ ] Ongoing Processes Established
- [ ] Integration Ready

---

## 🎯 Pre-Course Setup (Before Semester Starts)
**Time Required:** 2-3 hours  
**Goal:** Be ready to hit the ground running on Day 1

### GitHub Account & Access
- [x] Create GitHub account (if needed) - [Sign up here](https://github.com/signup)
- [x] Set up 2FA for security - [GitHub 2FA Guide](https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa)
- [ ] Add profile picture and bio
- [x] Join course organization (check course email for invite)
- [x] Accept repository access invitation

**✅ Success Indicator:** You can access the course organization and see other repositories

### Development Environment
- [x] Install Git - [Download Git](https://git-scm.com/downloads)
  ```bash
  # Verify installation
  git --version
  ```
- [x] Configure Git with your info:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your.email@student.edu"
  ```
- [x] Install VS Code - [Download VS Code](https://code.visualstudio.com/)
- [x] Install VS Code GitHub extension
- [x] Set up VS Code command line tools

**✅ Success Indicator:** Running `git --version` and `code --version` both work

### Optional but Recommended
- [x] Install GitHub Desktop (if you prefer GUI) - [Download](https://desktop.github.com/)
- [ ] Set up SSH keys for GitHub - [SSH Setup Guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [ ] Install Node.js/npm (if using JavaScript) - [Download Node.js](https://nodejs.org/)
- [x] Install Python (if using Python) - [Download Python](https://www.python.org/)

**🔧 Troubleshooting:**
- **Git not recognized?** Make sure Git is in your PATH
- **VS Code won't open?** Try restarting your terminal
- **Can't join organization?** Check spam folder for invite email

---

## 📅 Week 1: Team Formation & Setup
**Time Required:** 4-5 hours across the week  
**Goal:** Establish your team and basic workflows

### Day 1-2: Repository Setup (30 mins)
- [x] Click "Use this template" to create your team repository
- [x] Name it according to course guidelines: `TeamName-ProjectName`
- [x] Make repository private (if required by course)
- [x] Add all team members as collaborators
  - Go to Settings → Manage access → Add people

**✅ Success Indicator:** All team members can clone and push to the repository

### Day 2-3: Run Setup Scripts (15 mins)
- [ ] Clone repository locally:
  ```bash
  git clone https://github.com/your-org/your-repo.git
  cd your-repo
  ```
- [ ] Run the appropriate setup script:
  ```bash
  # For macOS/Linux:
  ./scripts/setup.sh
  
  # For Windows:
  scripts\setup.bat
  
  # For Windows PowerShell:
  .\scripts\setup.ps1
  ```
- [ ] Verify VS Code extensions installed
- [ ] Open repository in VS Code: `code .`

**✅ Success Indicator:** Setup script completes without errors

### Day 3-4: Team Information (45 mins)
- [x] Update `TEAM_INFO.md` with real information:
  - [x] Team name decided and updated
  - [x] All member names and GitHub handles
  - [x] Roles assigned (PM, Tech Lead, etc.)
  - [x] Contact emails added
  - [x] Meeting schedule determined
- [x] Create team communication channel (Slack/Discord/Teams)
- [x] Commit and push changes:
  ```bash
  git add TEAM_INFO.md
  git commit -m "Update team information"
  git push
  ```

**✅ Success Indicator:** TEAM_INFO.md has no more {{PLACEHOLDER}} values

### Day 4-5: First Team Meeting (1-2 hours)
- [x] Schedule meeting (use when2meet or similar)
- [x] Create meeting agenda in `meetings/week01-kickoff.md`
- [x] Hold meeting covering:
  - [x] Introductions and icebreaker
  - [x] Review project requirements together
  - [x] Discuss individual strengths/interests
  - [x] Agree on communication norms
  - [x] Set regular meeting times
- [x] Document meeting notes
- [x] Create action items as GitHub issues

**✅ Success Indicator:** All team members attended and meeting notes are in repository

### End of Week 1: Automation Check
- [x] Verify GitHub Actions are enabled (Settings → Actions)
- [x] Check that team-setup workflow ran successfully
- [x] Review automatically created onboarding issues
- [x] Assign onboarding issues to team members

**🔧 Troubleshooting:**
- **Can't push to repository?** Check you're added as collaborator
- **Setup script fails?** Run with `--verbose` flag for details
- **Actions not running?** Enable Actions in repository settings

---

## 📋 Week 2: Project Management Setup
**Time Required:** 3-4 hours across the week  
**Goal:** Establish project management workflows

### GitHub Project Board (1 hour)
- [ ] Create GitHub Project board (Projects tab → New project)
- [ ] Choose "Team planning" template
- [ ] Set up columns: Backlog, To Do, In Progress, Review, Done
- [ ] Link project to repository
- [ ] Create initial epic issues for major features
- [ ] Add all issues to project board

**✅ Success Indicator:** Project board visible with at least 5 issues

### Milestones & Planning (1 hour)
- [ ] Create milestones matching course deadlines:
  - [ ] Week 4: Initial Prototype
  - [ ] Week 8: Beta Release
  - [ ] Week 11: Final Submission
- [ ] Assign issues to first milestone
- [ ] Estimate effort using labels (small/medium/large)
- [ ] Distribute work among team members

**✅ Success Indicator:** First milestone has 3-5 assigned issues

### Issue Templates & Labels (30 mins)
- [ ] Review issue templates in `.github/ISSUE_TEMPLATE/`
- [ ] Create first issues using templates:
  - [ ] At least one task issue
  - [ ] At least one feature issue
- [ ] Apply appropriate labels
- [ ] Link issues to project board

**✅ Success Indicator:** Issues appear on project board in correct columns

### Weekly Report Setup (30 mins)
- [ ] Review `reports/README.md` for report structure
- [ ] Check Actions tab for weekly-report workflow
- [ ] Note that reports generate automatically on Fridays
- [ ] Designate who reviews/edits weekly reports

**✅ Success Indicator:** Team knows when and how reports are generated

**🔧 Troubleshooting:**
- **Can't create project?** Need repository write access
- **Issues not showing on board?** Drag from sidebar or use "Add items"
- **Workflow not triggering?** Can manually run from Actions tab

---

## 🔄 Ongoing Tasks (Throughout Semester)
**Time Required:** 2-3 hours per week  
**Goal:** Maintain momentum and good practices

### Weekly Rituals
- [ ] **Monday Planning (30 mins)**
  - [ ] Review project board
  - [ ] Move tasks from Backlog to To Do
  - [ ] Check milestone progress
  - [ ] Update issue assignments

- [ ] **Wednesday Check-in (15 mins)**
  - [ ] Quick status update in team channel
  - [ ] Flag any blockers
  - [ ] Offer help to teammates

- [ ] **Friday Wrap-up (30 mins)**
  - [ ] Review auto-generated weekly report
  - [ ] Add qualitative notes to report
  - [ ] Merge report PR
  - [ ] Celebrate wins! 🎉

### Meeting Protocol
- [ ] **Before Each Meeting:**
  - [ ] Create agenda in `meetings/` folder
  - [ ] Share agenda 24 hours before
  - [ ] Review previous action items

- [ ] **During Meeting:**
  - [ ] Start on time
  - [ ] Follow agenda
  - [ ] Assign note-taker
  - [ ] Create action items

- [ ] **After Meeting:**
  - [ ] Push meeting notes within 24 hours
  - [ ] Create issues for action items
  - [ ] Update project board

### Code Workflow
- [ ] **For Each Feature:**
  - [ ] Create issue first
  - [ ] Create feature branch
  - [ ] Make small, frequent commits
  - [ ] Write descriptive commit messages
  - [ ] Create PR when ready
  - [ ] Request review from teammate
  - [ ] Address review feedback
  - [ ] Merge when approved

**✅ Success Indicators:** 
- Consistent commit activity from all members
- PRs reviewed within 48 hours
- Project board updated daily

---

## 🌐 Digital Village Integration Preparation
**Time Required:** 2-3 hours in final weeks  
**Goal:** Prepare for ecosystem integration

### Week 9-10: Integration Planning
- [ ] Review [Digital Village Integration Guide](docs/DIGITAL_VILLAGE_INTEGRATION.md)
- [ ] Complete [DV Requirements Template](templates/DV_REQUIREMENTS_TEMPLATE.md)
- [ ] Schedule discovery meeting with DV team
- [ ] Document technical requirements
- [ ] Identify integration points

### Week 11: Technical Preparation
- [ ] Implement required API endpoints
- [ ] Add authentication if needed
- [ ] Create integration documentation
- [ ] Prepare demo for DV team
- [ ] Run integration tests

### Week 12: Final Integration
- [ ] Deploy to staging environment
- [ ] Complete integration checklist
- [ ] Conduct integration testing
- [ ] Address feedback from DV team
- [ ] Document any issues or limitations

**✅ Success Indicator:** Project successfully connects with DV ecosystem

**🔧 Troubleshooting:**
- **Unclear requirements?** Schedule office hours with DV team
- **Technical blockers?** Document in integration issue template
- **Timeline concerns?** Communicate early with instructors

---

## 🎯 Quick Validation Checks

Run these commands to verify your setup:

```bash
# Check Git configuration
git config --list | grep user

# Verify repository connection
git remote -v

# Check for uncommitted changes
git status

# View project structure
ls -la

# Check if in correct branch
git branch

# Verify GitHub CLI (if installed)
gh auth status
```

---

## 📚 Essential Resources

### Documentation
- [Project Management Guide](docs/PROJECT_MANAGEMENT.md)
- [GitHub Workflow Guide](UniTeamRepoTemplate/docs/03_GitHub_Workflow.md)
- [Meeting Etiquette](UniTeamRepoTemplate/docs/01_Meeting_Etiquette.md)
- [AI Usage Guidelines](UniTeamRepoTemplate/docs/05_AI_Usage_Guide.md)

### Quick References
- [GitHub Keyboard Shortcuts](https://docs.github.com/en/get-started/using-github/keyboard-shortcuts)
- [Markdown Cheatsheet](https://www.markdownguide.org/cheat-sheet/)
- [Git Commands Reference](https://education.github.com/git-cheat-sheet-education.pdf)

### Getting Help
1. Check documentation first
2. Ask in team channel
3. Search course forums
4. Office hours with instructor
5. Create issue with "help wanted" label

---

## 🏆 Completion Celebration!

When you've completed all sections:
1. Take a team selfie! 📸
2. Share your progress in course channel
3. Treat yourselves to coffee/snacks ☕
4. You're ready for an awesome semester!

---

*Last updated: [Date] | Version: 1.0*  
*Found an issue? Submit a PR to improve this checklist!*
