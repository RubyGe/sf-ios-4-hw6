t# Assignment 6: Core Data

Add persisted data to the provided sample app. The assigned app mimics Apple's Notes app and contains a series of todos for reading from and writing to the database. Implementing these todos will give you familiarity with Core Data and will give you a starting point for using persistence in your final project app.

## Goals of Project
Gain familiarity with using Core Data to keep data around (persist) between sessions on a single iOS device.

## Project Requirements
Your app must meet all requirements laid out in the sample app. Format: Sample app has all input/output TODOs filled out and functioning.

1. In .xcdatamodeld, add a "Note" entity with one String attribute, "text"
2. Create an NSManagedObject subclass, Note. Two files will be output.
3. Add code for retrieving the shared managed object context at the bottom of AppDelegate.swift
4. In the table view controller, import CoreData
5. In the table view controller, get a reference to the shared context
6. In the table view controller, switch the notes array from using String to using Note. You'll need to update cellForRowAtIndexPath as well.
7. In the table view controller, fill in the code for saving to disk. This involves creating a new managed object and inserting it into the context, setting its attributes, and committing the changes to disk.
8. In the table view controller, fill in the function for loading from disk. This involves creating a fetch request, then asking the context to make the request, and storing the result.

## Deliverables
Assignment (code, resources, project file) posted on Github

## Timeline
Due Date: Monday, February 22, 2016 (by midnight).

## Suggested Ways to Get Started
* Understand the definition of Core Data.
* What are the advantages of using Core Data? The disadvantages?
* Write down one use case where you would use Core Data for persistence.

## Evaluation
Your assignment will be evaluated regarding the extent to which you meet the above requirements using our usual rubric, which outlines how your assignment will be evaluated on readiness, stability & performance, and style & readability.