#!/usr/bin/env python3
"""
Meeting Notes Parser
Parses markdown meeting notes to extract key information for weekly reports.
"""

import sys
import os
import re
from datetime import datetime
import json
from pathlib import Path


class MeetingNotesParser:
    """Parse meeting notes to extract structured information."""
    
    def __init__(self, meetings_dir="meetings"):
        self.meetings_dir = Path(meetings_dir)
        
    def parse_meeting_file(self, filepath):
        """Parse a single meeting file and extract information."""
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        meeting_info = {
            'filename': os.path.basename(filepath),
            'date': self._extract_date(filepath, content),
            'attendees': self._extract_attendees(content),
            'decisions': self._extract_decisions(content),
            'action_items': self._extract_action_items(content),
            'topics': self._extract_topics(content),
            'summary': self._extract_summary(content)
        }
        
        return meeting_info
    
    def _extract_date(self, filepath, content):
        """Extract meeting date from filename or content."""
        # Try to extract date from filename first
        filename = os.path.basename(filepath)
        date_pattern = r'(\d{4}[-_]\d{2}[-_]\d{2})'
        match = re.search(date_pattern, filename)
        if match:
            return match.group(1).replace('_', '-')
        
        # Try to find date in content
        date_patterns = [
            r'Date:\s*(\d{4}-\d{2}-\d{2})',
            r'Meeting Date:\s*(\d{4}-\d{2}-\d{2})',
            r'(\d{4}-\d{2}-\d{2})'
        ]
        
        for pattern in date_patterns:
            match = re.search(pattern, content, re.IGNORECASE)
            if match:
                return match.group(1)
        
        # Use file modification time as fallback
        return datetime.fromtimestamp(os.path.getmtime(filepath)).strftime('%Y-%m-%d')
    
    def _extract_attendees(self, content):
        """Extract attendees from meeting notes."""
        attendees = []
        
        # Look for attendees section
        patterns = [
            r'Attendees?:\s*\n((?:[*-]\s*.+\n?)+)',
            r'Present:\s*\n((?:[*-]\s*.+\n?)+)',
            r'Participants?:\s*\n((?:[*-]\s*.+\n?)+)'
        ]
        
        for pattern in patterns:
            match = re.search(pattern, content, re.IGNORECASE | re.MULTILINE)
            if match:
                attendee_list = match.group(1)
                # Extract individual attendees
                attendees = re.findall(r'[*-]\s*(.+)', attendee_list)
                break
        
        return [a.strip() for a in attendees]
    
    def _extract_decisions(self, content):
        """Extract key decisions from meeting notes."""
        decisions = []
        
        # Look for decisions section
        patterns = [
            r'Decisions?:\s*\n((?:[*-]\s*.+\n?)+)',
            r'Key Decisions?:\s*\n((?:[*-]\s*.+\n?)+)',
            r'Agreed:\s*\n((?:[*-]\s*.+\n?)+)'
        ]
        
        for pattern in patterns:
            match = re.search(pattern, content, re.IGNORECASE | re.MULTILINE)
            if match:
                decision_list = match.group(1)
                decisions = re.findall(r'[*-]\s*(.+)', decision_list)
                break
        
        # Also look for inline decisions marked with keywords
        inline_patterns = [
            r'(?:decided|agreed|resolved)(?:\s+that)?\s*:?\s*(.+?)(?:\.|$)',
            r'(?:decision|agreement):\s*(.+?)(?:\.|$)'
        ]
        
        for pattern in inline_patterns:
            matches = re.findall(pattern, content, re.IGNORECASE)
            decisions.extend(matches)
        
        return [d.strip() for d in decisions if d.strip()]
    
    def _extract_action_items(self, content):
        """Extract action items from meeting notes."""
        action_items = []
        
        # Look for action items section
        patterns = [
            r'Action Items?:\s*\n((?:[*-]\s*.+\n?)+)',
            r'Actions?:\s*\n((?:[*-]\s*.+\n?)+)',
            r'To Do:\s*\n((?:[*-]\s*.+\n?)+)',
            r'Next Steps?:\s*\n((?:[*-]\s*.+\n?)+)'
        ]
        
        for pattern in patterns:
            match = re.search(pattern, content, re.IGNORECASE | re.MULTILINE)
            if match:
                action_list = match.group(1)
                items = re.findall(r'[*-]\s*(.+)', action_list)
                action_items.extend(items)
        
        # Look for TODO items
        todo_matches = re.findall(r'TODO:\s*(.+)', content, re.IGNORECASE)
        action_items.extend(todo_matches)
        
        # Look for assigned actions (e.g., "@John: Complete the report")
        assigned_matches = re.findall(r'@\w+:\s*(.+)', content)
        action_items.extend(assigned_matches)
        
        return [a.strip() for a in action_items if a.strip()]
    
    def _extract_topics(self, content):
        """Extract main topics discussed."""
        topics = []
        
        # Look for headers (## Topic)
        headers = re.findall(r'^#{1,3}\s+(.+)$', content, re.MULTILINE)
        
        # Filter out common section headers
        exclude_headers = [
            'attendees', 'participants', 'present', 'agenda',
            'action items', 'actions', 'next steps', 'decisions',
            'notes', 'meeting notes', 'summary', 'overview'
        ]
        
        for header in headers:
            if not any(ex in header.lower() for ex in exclude_headers):
                topics.append(header.strip())
        
        return topics
    
    def _extract_summary(self, content):
        """Extract meeting summary if available."""
        # Look for summary section
        patterns = [
            r'Summary:\s*\n(.+?)(?:\n#|\n\n|\Z)',
            r'Overview:\s*\n(.+?)(?:\n#|\n\n|\Z)',
            r'Meeting Summary:\s*\n(.+?)(?:\n#|\n\n|\Z)'
        ]
        
        for pattern in patterns:
            match = re.search(pattern, content, re.IGNORECASE | re.MULTILINE | re.DOTALL)
            if match:
                summary = match.group(1).strip()
                # Limit summary length
                if len(summary) > 500:
                    summary = summary[:497] + "..."
                return summary
        
        return ""
    
    def get_meetings_for_week(self, start_date, end_date):
        """Get all meetings within a date range."""
        meetings = []
        
        if not self.meetings_dir.exists():
            return meetings
        
        # Parse dates
        start = datetime.strptime(start_date, '%Y-%m-%d')
        end = datetime.strptime(end_date, '%Y-%m-%d')
        
        # Find all markdown files
        for filepath in self.meetings_dir.glob('**/*.md'):
            # Skip README files
            if filepath.name.lower() == 'readme.md':
                continue
                
            try:
                meeting_info = self.parse_meeting_file(filepath)
                meeting_date = datetime.strptime(meeting_info['date'], '%Y-%m-%d')
                
                if start <= meeting_date <= end:
                    meetings.append(meeting_info)
            except Exception as e:
                print(f"Error parsing {filepath}: {e}", file=sys.stderr)
        
        # Sort by date
        meetings.sort(key=lambda x: x['date'])
        
        return meetings
    
    def generate_summary_report(self, meetings):
        """Generate a summary report for the meetings."""
        if not meetings:
            return {
                'total_meetings': 0,
                'total_attendees': 0,
                'all_decisions': [],
                'all_action_items': [],
                'all_topics': []
            }
        
        all_attendees = set()
        all_decisions = []
        all_action_items = []
        all_topics = []
        
        for meeting in meetings:
            all_attendees.update(meeting['attendees'])
            all_decisions.extend(meeting['decisions'])
            all_action_items.extend(meeting['action_items'])
            all_topics.extend(meeting['topics'])
        
        return {
            'total_meetings': len(meetings),
            'total_attendees': len(all_attendees),
            'all_decisions': all_decisions,
            'all_action_items': all_action_items,
            'all_topics': all_topics,
            'meetings': meetings
        }


def main():
    """Main function to parse meeting notes."""
    import argparse
    
    parser = argparse.ArgumentParser(description='Parse meeting notes for weekly reports')
    parser.add_argument('--start-date', required=True, help='Start date (YYYY-MM-DD)')
    parser.add_argument('--end-date', required=True, help='End date (YYYY-MM-DD)')
    parser.add_argument('--meetings-dir', default='meetings', help='Directory containing meeting notes')
    parser.add_argument('--output-format', choices=['json', 'markdown'], default='markdown',
                       help='Output format')
    
    args = parser.parse_args()
    
    # Parse meetings
    notes_parser = MeetingNotesParser(args.meetings_dir)
    meetings = notes_parser.get_meetings_for_week(args.start_date, args.end_date)
    summary = notes_parser.generate_summary_report(meetings)
    
    if args.output_format == 'json':
        print(json.dumps(summary, indent=2))
    else:
        # Output in markdown format for the weekly report
        if summary['total_meetings'] == 0:
            print("No meetings recorded this week")
        else:
            print(f"### Meetings Held ({summary['total_meetings']} meetings)")
            print()
            
            for meeting in summary['meetings']:
                print(f"- **{meeting['date']}**: {meeting['filename']}")
                if meeting['attendees']:
                    print(f"  - Attendees: {', '.join(meeting['attendees'][:5])}")
                    if len(meeting['attendees']) > 5:
                        print(f"    and {len(meeting['attendees']) - 5} others")
                if meeting['topics']:
                    print(f"  - Topics: {', '.join(meeting['topics'][:3])}")
                    if len(meeting['topics']) > 3:
                        print(f"    and {len(meeting['topics']) - 3} more")
            
            if summary['all_decisions']:
                print()
                print("### Key Decisions from Meetings")
                for decision in summary['all_decisions'][:5]:
                    print(f"- {decision}")
                if len(summary['all_decisions']) > 5:
                    print(f"- ... and {len(summary['all_decisions']) - 5} more decisions")
            
            if summary['all_action_items']:
                print()
                print("### Action Items from Meetings")
                for action in summary['all_action_items'][:5]:
                    print(f"- {action}")
                if len(summary['all_action_items']) > 5:
                    print(f"- ... and {len(summary['all_action_items']) - 5} more action items")


if __name__ == "__main__":
    main()