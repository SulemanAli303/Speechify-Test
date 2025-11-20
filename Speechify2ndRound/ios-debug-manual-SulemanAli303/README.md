# Speechify iOS Debugging Challenge

Welcome to the Debugging Challenge round, where you'll tackle three distinct debugging scenarios in an iOS application.
Each task is designed to test your ability to identify, analyze, and fix different types of implementation issues ranging from UI bugs to concurrency problems. 
Your success will be measured by your systematic approach to debugging, understanding of iOS development concepts, and ability to implement effective solutions while working within the provided constraints.

# Development Guidelines

## Do's

-   Write clean, maintainable, and well-documented code and follow the best practices and coding standards.
-   You are free to use any official documentation or language references (SwiftUI, Swift, etc).
-   You can use the debugging tools and native IDE features (only standard Auto-Completion)

## Don'ts

-   Do NOT use any external libraries for the implementation.
-   DO NOT use any Coding Assistants like GitHub Copilot, ChatGPT, etc or any other AI based tools.
-   DO NOT visit direct blogs or articles related to implementation of the tasks.
-   DO NOT use Stackoverflow or any other forum websites.

# Task #0
Carefully review the README file and take the time to familiarize yourself with the codebase. Understanding the structure and key components will be essential before you proceed with the challenge.

# Task #1

## Overview
Your challenge is to debug and optimize a task management application built with SwiftUI. The application consists of two main tabs:

### Projects Tab
- Project List View with search functionality
- Project Details view showing associated work items
- Work Item Details with priority and status information

### Analytics Tab
- Key Metrics dashboard with performance indicators
- Detailed metric analysis with historical data
- Recent Projects quick access section

## Current State
The application is feature-complete with all functionality implemented as described above. However, it contains several implementation issues that need to be addressed:
- Various UI bugs
- Suspected memory leaks
- Potential crash scenarios (if encountered)

## Task
Your task is to identify and fix all implementation issues while ensuring all existing features continue to work as specified.

## Important Notes
- Some files are marked as "DO NOT MODIFY" - these must remain unchanged
- In certain files, only specific sections are marked as protected with clear comments
- Modifying any protected code (either entire files or marked sections) will result in automatic task failure

## Success Criteria
The final submission should be stable and free of bugs, memory leaks, and crashes while maintaining all existing functionality.

# Task #2

## Task
Fix the concurrency implementation in `DefaultReminderService` to correctly handle parallel reminder fetching using three different paradigms:

1. Callback-Based (`fetchReminders`)
2. Combine (`remindersPublisher`)
3. Swift Concurrency (`fetchRemindersAsync`)

Each implementation must:
- Fetch three pages of reminders in parallel
- Return a total of 12 reminders
- Pass all associated tests in `DefaultReminderServiceTests`

## Success Criteria
- All tests in `DefaultReminderServiceTests` pass successfully
- Each method fetches exactly three pages concurrently
- All methods return 12 unique reminders
- Each implementation uses its designated concurrency paradigm
- Each method has a unique implementation

## Important Notes
- Some files are marked as "DO NOT MODIFY" - these must remain unchanged
- In certain files, only specific sections are marked as protected with clear comments
- Modifying any protected code (either entire files or marked sections) will result in automatic task failure
- Work with the existing code structure; do not rewrite from scratch
- Stay within each method's designated paradigm (Callbacks/Combine/Swift Concurrency)
- Do not call other methods of the class within implementations

# Task #3

## Prerequisites
Please switch the `currentScreen` to `.login` in `DebuggingChallengeApp.swift` file.

## Task
Your goal is to pass the login screen by locating and fixing a single bug.

## Success Criteria
Once the issue is resolved, tapping **Login** should transition you to the second part of the challenge.

## Important Notes
- Only one bug needs to be fixed to complete this task
- Some files are marked as "DO NOT MODIFY" - these must remain unchanged
- In certain files, only specific sections are marked as protected with clear comments
- Modifying any protected code (either entire files or marked sections) will result in automatic task failure
