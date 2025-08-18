# Onboarding Validation Script for Windows
# This script validates that all onboarding steps have been completed correctly

# Color functions
function Write-Success {
    param([string]$Message)
    Write-Host "✓ PASSED" -ForegroundColor Green -NoNewline
    Write-Host " - $Message"
}

function Write-Failure {
    param([string]$Message)
    Write-Host "✗ FAILED" -ForegroundColor Red -NoNewline
    Write-Host " - $Message"
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠ WARNING" -ForegroundColor Yellow -NoNewline
    Write-Host " - $Message"
}

function Write-Info {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Cyan
}

function Write-Header {
    param([string]$Message)
    Write-Host ""
    Write-Host $Message -ForegroundColor Blue
    Write-Host ("-" * $Message.Length) -ForegroundColor Blue
}

# Counters
$Script:Passed = 0
$Script:Failed = 0
$Script:Warnings = 0

# Get script and project directories
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

# Function to check a condition
function Test-Condition {
    param(
        [string]$Description,
        [scriptblock]$Test,
        [bool]$IsWarning = $false
    )
    
    Write-Host "Checking: $Description... " -NoNewline
    
    try {
        if (& $Test) {
            Write-Success ""
            $Script:Passed++
            return $true
        } else {
            if ($IsWarning) {
                Write-Warning ""
                $Script:Warnings++
            } else {
                Write-Failure ""
                $Script:Failed++
            }
            return $false
        }
    } catch {
        if ($IsWarning) {
            Write-Warning ""
            $Script:Warnings++
        } else {
            Write-Failure ""
            $Script:Failed++
        }
        return $false
    }
}

# Function to check for placeholders
function Test-NoPlaceholders {
    param([string]$FilePath)
    
    if (Test-Path $FilePath) {
        $content = Get-Content $FilePath -Raw
        return -not ($content -match '\{\{')
    }
    return $false
}

Write-Info "================================================"
Write-Info "    Team Onboarding Validation Script"
Write-Info "================================================"

Write-Header "1. Environment Checks"

# Check Git installation
$gitInstalled = Test-Condition "Git is installed" { Get-Command git -ErrorAction SilentlyContinue }
if ($gitInstalled) {
    $gitVersion = git --version
    Write-Host "   └─ Version: $gitVersion"
}

# Check Git configuration
$gitNameConfigured = Test-Condition "Git user.name is configured" { 
    $name = git config --global user.name 2>$null
    -not [string]::IsNullOrWhiteSpace($name)
}
if ($gitNameConfigured) {
    $gitName = git config --global user.name
    Write-Host "   └─ Name: $gitName"
}

$gitEmailConfigured = Test-Condition "Git user.email is configured" {
    $email = git config --global user.email 2>$null
    -not [string]::IsNullOrWhiteSpace($email)
}
if ($gitEmailConfigured) {
    $gitEmail = git config --global user.email
    Write-Host "   └─ Email: $gitEmail"
}

# Check VS Code installation
Test-Condition "VS Code CLI is available" { Get-Command code -ErrorAction SilentlyContinue } -IsWarning $true

Write-Header "2. Repository Checks"

# Check if in git repository
$inGitRepo = Test-Condition "In a Git repository" {
    Push-Location $ProjectRoot
    $result = git rev-parse --git-dir 2>$null
    Pop-Location
    $LASTEXITCODE -eq 0
}

# Check remote origin
$remoteConfigured = Test-Condition "Remote origin is configured" {
    Push-Location $ProjectRoot
    $remote = git config --get remote.origin.url 2>$null
    Pop-Location
    -not [string]::IsNullOrWhiteSpace($remote)
}
if ($remoteConfigured) {
    Push-Location $ProjectRoot
    $repoUrl = git config --get remote.origin.url
    Pop-Location
    Write-Host "   └─ Remote: $repoUrl"
}

# Get current branch
Push-Location $ProjectRoot
$currentBranch = git rev-parse --abbrev-ref HEAD 2>$null
if ([string]::IsNullOrWhiteSpace($currentBranch)) {
    $currentBranch = "unknown"
}
Pop-Location
Write-Host "   └─ Current branch: $currentBranch"

Write-Header "3. File Structure Checks"

# Check essential directories
Test-Condition "meetings/ directory exists" { Test-Path "$ProjectRoot\meetings" -PathType Container }
Test-Condition "reports/ directory exists" { Test-Path "$ProjectRoot\reports" -PathType Container }
Test-Condition "project/ directory exists" { Test-Path "$ProjectRoot\project" -PathType Container }
Test-Condition "docs/ directory exists" { Test-Path "$ProjectRoot\docs" -PathType Container }
Test-Condition ".github/workflows/ directory exists" { Test-Path "$ProjectRoot\.github\workflows" -PathType Container }

Write-Header "4. Team Information Checks"

# Check TEAM_INFO.md
$teamInfoExists = Test-Condition "TEAM_INFO.md exists" { Test-Path "$ProjectRoot\TEAM_INFO.md" -PathType Leaf }
Test-Condition "TEAM_INFO.md has no placeholders" { Test-NoPlaceholders "$ProjectRoot\TEAM_INFO.md" }

# Count team members in TEAM_INFO.md
if ($teamInfoExists) {
    $content = Get-Content "$ProjectRoot\TEAM_INFO.md" -Raw
    $placeholderCount = ([regex]::Matches($content, '@\{\{MEMBER')).Count
    if ($placeholderCount -eq 0) {
        $actualMembers = ([regex]::Matches($content, '\|.*@\w+')).Count
        Write-Host "   └─ Team members found: $actualMembers"
    } else {
        Write-Host "   └─ " -NoNewline
        Write-Host "Placeholder team members still present!" -ForegroundColor Red
    }
}

Write-Header "5. Documentation Checks"

Test-Condition "README.md exists" { Test-Path "$ProjectRoot\README.md" -PathType Leaf }
Test-Condition "ONBOARDING_CHECKLIST.md exists" { Test-Path "$ProjectRoot\ONBOARDING_CHECKLIST.md" -PathType Leaf }
Test-Condition "docs/QUICK_START.md exists" { Test-Path "$ProjectRoot\docs\QUICK_START.md" -PathType Leaf }
Test-Condition "docs/PROJECT_MANAGEMENT.md exists" { Test-Path "$ProjectRoot\docs\PROJECT_MANAGEMENT.md" -PathType Leaf }

Write-Header "6. GitHub Actions Checks"

Test-Condition "Weekly report workflow exists" { Test-Path "$ProjectRoot\.github\workflows\weekly-report.yml" -PathType Leaf }
Test-Condition "Team setup workflow exists" { Test-Path "$ProjectRoot\.github\workflows\team-setup.yml" -PathType Leaf }

# Check if GitHub CLI is available
$ghAvailable = Get-Command gh -ErrorAction SilentlyContinue
if ($ghAvailable) {
    Test-Condition "GitHub CLI authenticated" { 
        $result = gh auth status 2>&1
        $LASTEXITCODE -eq 0
    } -IsWarning $true
} else {
    Write-Warning "GitHub CLI not installed - cannot check Actions status"
    $Script:Warnings++
}

Write-Header "7. Setup Completion Checks"

# Check for setup completion marker
$setupComplete = Test-Condition "Setup script has been run" { Test-Path "$ProjectRoot\.setup-complete" -PathType Leaf }
if ($setupComplete) {
    $setupDate = Get-Content "$ProjectRoot\.setup-complete" -First 1
    Write-Host "   └─ $setupDate"
}

Write-Info ""
Write-Info "================================================"
Write-Info "                 SUMMARY"
Write-Info "================================================"
Write-Info ""

$Total = $Script:Passed + $Script:Failed + $Script:Warnings

Write-Host "Total checks: $Total"
Write-Host "Passed: $Script:Passed" -ForegroundColor Green
Write-Host "Warnings: $Script:Warnings" -ForegroundColor Yellow
Write-Host "Failed: $Script:Failed" -ForegroundColor Red
Write-Info ""

# Overall status
if ($Script:Failed -eq 0) {
    if ($Script:Warnings -eq 0) {
        Write-Host "🎉 Excellent! All onboarding checks passed!" -ForegroundColor Green
        Write-Host "Your team is ready to start development." -ForegroundColor Green
        $ExitCode = 0
    } else {
        Write-Host "✅ Good! All critical checks passed." -ForegroundColor Green
        Write-Host "Some optional items need attention." -ForegroundColor Yellow
        $ExitCode = 0
    }
} else {
    Write-Host "❌ Onboarding incomplete!" -ForegroundColor Red
    Write-Host "Please complete the failed items before proceeding." -ForegroundColor Red
    Write-Info ""
    Write-Host "Next steps:"
    Write-Host "1. Review the failed checks above"
    Write-Host "2. Consult ONBOARDING_CHECKLIST.md for detailed instructions"
    Write-Host "3. Run this script again after fixing issues"
    $ExitCode = 1
}

Write-Info ""
Write-Info "For detailed onboarding instructions, see:"
Write-Host "- ONBOARDING_CHECKLIST.md (comprehensive guide)"
Write-Host "- docs/QUICK_START.md (5-minute setup)"
Write-Info ""

# Pause if running in a new window
if ($Host.Name -eq "ConsoleHost") {
    Write-Host "Press any key to continue..." -NoNewline
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

exit $ExitCode