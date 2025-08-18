#!/bin/bash
# Onboarding Validation Script
# This script validates that all onboarding steps have been completed correctly

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
PASSED=0
FAILED=0
WARNINGS=0

# Script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}    Team Onboarding Validation Script${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Function to check a condition
check() {
    local description=$1
    local command=$2
    local is_warning=${3:-false}
    
    echo -n "Checking: $description... "
    
    if eval "$command" &> /dev/null; then
        echo -e "${GREEN}✓ PASSED${NC}"
        ((PASSED++))
        return 0
    else
        if [ "$is_warning" = true ]; then
            echo -e "${YELLOW}⚠ WARNING${NC}"
            ((WARNINGS++))
            return 1
        else
            echo -e "${RED}✗ FAILED${NC}"
            ((FAILED++))
            return 1
        fi
    fi
}

# Function to check for placeholders
check_no_placeholders() {
    local file=$1
    if [ -f "$file" ]; then
        if grep -q "{{" "$file"; then
            return 1
        else
            return 0
        fi
    else
        return 1
    fi
}

echo -e "${BLUE}1. Environment Checks${NC}"
echo "------------------------"

# Check Git installation
check "Git is installed" "command -v git"
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version | cut -d' ' -f3)
    echo "   └─ Version: $GIT_VERSION"
fi

# Check Git configuration
check "Git user.name is configured" "git config --global user.name"
if git config --global user.name &> /dev/null; then
    GIT_NAME=$(git config --global user.name)
    echo "   └─ Name: $GIT_NAME"
fi

check "Git user.email is configured" "git config --global user.email"
if git config --global user.email &> /dev/null; then
    GIT_EMAIL=$(git config --global user.email)
    echo "   └─ Email: $GIT_EMAIL"
fi

# Check VS Code installation
check "VS Code CLI is available" "command -v code" true

echo ""
echo -e "${BLUE}2. Repository Checks${NC}"
echo "------------------------"

# Check if in git repository
check "In a Git repository" "git rev-parse --git-dir"

# Check remote origin
check "Remote origin is configured" "git config --get remote.origin.url"
if git config --get remote.origin.url &> /dev/null; then
    REPO_URL=$(git config --get remote.origin.url)
    echo "   └─ Remote: $REPO_URL"
fi

# Check current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
echo "   └─ Current branch: $CURRENT_BRANCH"

echo ""
echo -e "${BLUE}3. File Structure Checks${NC}"
echo "------------------------"

# Check essential directories
check "meetings/ directory exists" "[ -d '$PROJECT_ROOT/meetings' ]"
check "reports/ directory exists" "[ -d '$PROJECT_ROOT/reports' ]"
check "project/ directory exists" "[ -d '$PROJECT_ROOT/project' ]"
check "docs/ directory exists" "[ -d '$PROJECT_ROOT/docs' ]"
check ".github/workflows/ directory exists" "[ -d '$PROJECT_ROOT/.github/workflows' ]"

echo ""
echo -e "${BLUE}4. Team Information Checks${NC}"
echo "------------------------"

# Check TEAM_INFO.md
check "TEAM_INFO.md exists" "[ -f '$PROJECT_ROOT/TEAM_INFO.md' ]"
check "TEAM_INFO.md has no placeholders" "check_no_placeholders '$PROJECT_ROOT/TEAM_INFO.md'"

# Count team members in TEAM_INFO.md
if [ -f "$PROJECT_ROOT/TEAM_INFO.md" ]; then
    MEMBER_COUNT=$(grep -c "@{{MEMBER" "$PROJECT_ROOT/TEAM_INFO.md" 2>/dev/null || echo "0")
    if [ "$MEMBER_COUNT" -eq "0" ]; then
        ACTUAL_MEMBERS=$(grep -c "^|.*@" "$PROJECT_ROOT/TEAM_INFO.md" 2>/dev/null || echo "0")
        echo "   └─ Team members found: $ACTUAL_MEMBERS"
    else
        echo "   └─ ${RED}Placeholder team members still present!${NC}"
    fi
fi

echo ""
echo -e "${BLUE}5. Documentation Checks${NC}"
echo "------------------------"

check "README.md exists" "[ -f '$PROJECT_ROOT/README.md' ]"
check "ONBOARDING_CHECKLIST.md exists" "[ -f '$PROJECT_ROOT/ONBOARDING_CHECKLIST.md' ]"
check "docs/QUICK_START.md exists" "[ -f '$PROJECT_ROOT/docs/QUICK_START.md' ]"
check "docs/PROJECT_MANAGEMENT.md exists" "[ -f '$PROJECT_ROOT/docs/PROJECT_MANAGEMENT.md' ]"

echo ""
echo -e "${BLUE}6. GitHub Actions Checks${NC}"
echo "------------------------"

check "Weekly report workflow exists" "[ -f '$PROJECT_ROOT/.github/workflows/weekly-report.yml' ]"
check "Team setup workflow exists" "[ -f '$PROJECT_ROOT/.github/workflows/team-setup.yml' ]"

# Check if Actions are enabled (this requires gh CLI)
if command -v gh &> /dev/null; then
    check "GitHub CLI authenticated" "gh auth status" true
else
    echo -e "${YELLOW}⚠ GitHub CLI not installed - cannot check Actions status${NC}"
    ((WARNINGS++))
fi

echo ""
echo -e "${BLUE}7. Setup Completion Checks${NC}"
echo "------------------------"

# Check for setup completion marker
check "Setup script has been run" "[ -f '$PROJECT_ROOT/.setup-complete' ]"
if [ -f "$PROJECT_ROOT/.setup-complete" ]; then
    SETUP_DATE=$(head -n 1 "$PROJECT_ROOT/.setup-complete" 2>/dev/null)
    echo "   └─ $SETUP_DATE"
fi

echo ""
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}                 SUMMARY${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

TOTAL=$((PASSED + FAILED + WARNINGS))

echo -e "Total checks: $TOTAL"
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${YELLOW}Warnings: $WARNINGS${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo ""

# Overall status
if [ $FAILED -eq 0 ]; then
    if [ $WARNINGS -eq 0 ]; then
        echo -e "${GREEN}🎉 Excellent! All onboarding checks passed!${NC}"
        echo -e "${GREEN}Your team is ready to start development.${NC}"
        EXIT_CODE=0
    else
        echo -e "${GREEN}✅ Good! All critical checks passed.${NC}"
        echo -e "${YELLOW}Some optional items need attention.${NC}"
        EXIT_CODE=0
    fi
else
    echo -e "${RED}❌ Onboarding incomplete!${NC}"
    echo -e "${RED}Please complete the failed items before proceeding.${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Review the failed checks above"
    echo "2. Consult ONBOARDING_CHECKLIST.md for detailed instructions"
    echo "3. Run this script again after fixing issues"
    EXIT_CODE=1
fi

echo ""
echo -e "${BLUE}For detailed onboarding instructions, see:${NC}"
echo "- ONBOARDING_CHECKLIST.md (comprehensive guide)"
echo "- docs/QUICK_START.md (5-minute setup)"
echo ""

exit $EXIT_CODE