# StudyPlan — iOS Coursework & Assignment Tracker

StudyPlan is a simple SwiftUI + SwiftData application designed to help students organize their semester courses and keep track of upcoming assignments and deadlines. Users can manage courses, create assignments with due dates, update statuses, and use a calendar-based view to see what’s coming up.

---

## Features

### 1. Course Management
- Add, edit, and delete courses  
- Store course name, code, term, and color  
- Each course contains its own assignments  
- Cascade delete ensures deleting a course removes its assignments

### 2. Assignment Management
- Add, edit, delete assignments under each course  
- Fields include title, due date, status, and notes  
- Quick status toggle directly from lists  
- Assignments appear in course view and global upcoming view

### 3. Upcoming View (Calendar + List)
- Graphical DatePicker (mini calendar)  
- View all assignments due on or after the selected date  
- Optional status filtering  
- Helps students stay aware of their workload

### 4. Navigation & UI
- TabView with two main tabs: Upcoming and Courses  
- NavigationStack for navigation between screens  
- Sheets for creating and editing items  
- MVVM architecture for cleaner code  
- SwiftData for data persistence  

---

## Tech Stack

- SwiftUI  
- SwiftData  
- MVVM  
- NavigationStack  
- Combine  
- Graphical DatePicker  

---

## Data Models

### Course
- name: String  
- code: String  
- term: String  
- colorHex: String  
- assignments: [Assignment]

### Assignment
- title: String  
- dueDate: Date  
- statusRaw: String  
- notes: String  
- course: Course?

### AssignmentStatus (Enum)
- Not Started  
- In Progress  
- Done  

---

## Project Structure

StudyPlan
├── StudyPlanApp.swift
├── ContentView.swift
├── Models
│ ├── Course.swift
│ ├── Assignment.swift
│ └── AssignmentStatus.swift
├── ViewModels
│ ├── CourseListViewModel.swift
│ ├── CourseDetailViewModel.swift
│ └── TodayViewModel.swift
├── Views
│ ├── TodayView.swift
│ ├── CourseListView.swift
│ ├── CourseDetailView.swift
│ ├── AssignmentEditView.swift
│ └── CourseEditView.swift

---

## Workflow Overview

1. **Courses Tab**
   - Add courses using the plus button  
   - Open a course to manage its assignments  

2. **Inside a Course**
   - Add assignments with due dates and notes  
   - Edit assignments in sheets  
   - Toggle assignment status with one tap  

3. **Upcoming Tab**
   - Calendar-based view  
   - Shows assignments due from the selected date forward  
   - Optional status filtering  

---

## How to Run

1. Open the project in Xcode 15 or later  
2. Run on simulator or physical device  
3. No additional setup needed (no API keys, no dependencies)

---

## Future Improvements (Optional)

- Notifications for upcoming deadlines  
- Course color picker UI  
- Analytics and progress tracking  
- CloudKit sync across devices  
- Widgets  

---

## License

This project is for educational and academic demonstration purposes.
