Proposed level of achievement: Apollo 11

Tech Stack:


FLutter + Firebase

Health-aid
Platform solution for Chronic Illness patient care


   







Uploading your data

Uploading health data (such as Blood Pressure, Blood Sugar level, Heart rate) allows better communication between patient and medical professionals without the patients leaving the comforts of their homes
This also allows medical professionals to get healthcare metric data from patients when face-to-face interactions are not possible



Providing access to medical professionals in a centralised platform

Allowing medical professionals to manage their clients from a singular platform, pinning and highlighting patients who need additional care.
There is an additional layer of consideration for this function, when paramedics and first responders who are on site request medical information, doctors can relay critical  information of patients to on-side paramedics as soon as possible.
As a potential extension, we may implement a chat function from doctors and patients that allows doctors to check-in with patients and patients to consult doctors regarding health issues. Other features such a medication reminders, notification for upcoming scheduled visits can also be implemented under the same umbrella.





Data Visualisation and Trend Analysis

With a large quantity of data, we are considering allowing our doctors to create visualisations and simple analytics to aid insights to plan future care for their patients. For now we consider using Python’s Matplotlib and Seaborn for visualisation. Development tech stack choices for this aspect may change as we go deeper into the development cycle.


Motivation:

With the recent COVID situation affecting everyone, drastically changing the way we work and play. One group of people who are particularly hard hit are chronic illness patients. Due to the current situation, visits to the doctor may be difficult or not possible. These situations can expose chronic illness patients at a higher risk. Hence a communication solution between patients and doctors can alleviate this problem.

Even after the virus situation is over, this solution can still alleviate the problem for patients with mobility issues. The ability to convey medical data remotely means less physical visits to the doctor which can prove to be challenging for physically handicapped patients. This solution also makes medical data centralised so when information regarding a specific client is needed, doctors and caregivers can refer for vital details and dispatch information to first-responders when needed.


Aim:

We wish to make patient information more accessible to doctors and caregivers and facilitate remote health monitoring and consultation when face-to-face interactions are difficult or not possible

User Stories:

As a patient with chronic illness, I can update my doctors about some of my health status so that I do not need to make a trip to the clinic/hospital.

As a doctor, I can manage all my patients in a centralised system so that it is more convenient and clearer for my work.

As a caregiver, I can receive updates on my family member and advice so that we will know how to better take care of them

As a first-responder/paramedic, I can access information that is accurate and timely so that I can help the patient in time.


Scope of project:

The app for doctors and patients serves a different function. Doctors should be able to access their patient’s healthcare data. Whereas the patients should be able to upload their data to doctors and healthcare agencies.

Hence, the doctor interface is more focused on patient and data management whereas the patient’s application is more focused on the reception of messages, notifications and uploading features.


To be completed by mid-June:

Doctor app: Layout of the patient entry system
Patient’s app: Layout of the uploading and reception pages
Backend: Creating a database that supports handling of data from uploading to access for doctors.


To be completed by mid-July:

Doctor app & patient’s app: Chat functionality
Notification system for doctors and patients (If possible, medication reminders)
Uploading system for patient
Data visualisation tools for Doctors
 


How are we different from similar platforms?

Apple health/ Apple watch:
Apple watches and apple health requires ios to access and setup, in addition, it also has a hardware requirement that the client must be an apple watch user to facilitate active monitoring. Our system circumvents this problem by allowing users to manually upload, which albeit tedious is a work around for the hardware requirements.

Salesforce Platform Services (By extension, other CRM related services)
Salesforce and other commercial CRM services taps on cloud and massive assets to manage client data and creates great analytics to generate powerful insights. However they also charge quite a premium for their services. Our goal is to create a service that lowers the barrier of entry for remote patient monitoring



Workflow Chart:



Learning Insights so far:

After attending the Git workshop, we’ve gained a deeper appreciation for git and understood how to manage versions by branching and merging. We are currently planning to import our project on github so that we can work on separate sections and components of our apps and merge them together.

We also attended the Reactjs workshop, however we learnt how reactjs may not be the best fit for our app. We then made the transition from the originally planned Flutter MongoDB and Reactjs combination to a Flutter + Firebase tech stack. 

Flutter is a front end software that allows us to create mobile applications much more easily with the use of widgets and make amendments quickly with their hot reload function where we can instantly see changes made to the application according to the changes in the code. Coupled with Firebase as a backend that stores data for the user registration and information, we are certain that we are able to make our application a reality.

Initially, when we started this idea, we thought that maybe by the end of orbital, we may not have to practice social distancing much longer, so we also prepped for an auxiliary use which is for patients with mobility issues to communicate with their doctors without having to visit them physically. However as the situation played out, we noticed that this may be the new norm and hence these measures are here to stay. If we are to deploy this app, we may have to handle a larger amount of data as user count may not drop for a significant amount of time due to the new norms.


MileStone 2 related Insights and learning points:

We noticed how firebase auth can be tricky to manipulate with asynchronous coding and Future involved as we ran into a few bugs and got stuck with the authentication process. We would try to resolve this by milestone 3 as a Troubleshoot and debug feature.
We initially wanted users to submit health data entries and let them be reflected on the User’s data board. However we noticed we need to update the respective UI by adding additional rows using flutter-fire. We are still trying to figure that out by milestone 3.
As an extension, we plan to implement a chatting function. However due to issues to auth currently, we need to sort out the issues with firebase.auth before continuing with our chat function implementation.
Regarding testing our software, we have already ran into many issues on the software and when accessing the specific data required, we are still trying to resolve some of these problems that are raised such as user authentication and logins, reflecting UI changes with addition of Data entries captured on the User’s end. Once these issues are resolved, we should be able to come up with better methods and ways to test out our software. 

Update: As of 29th Jun 2020, the submission of the milestone, we have been able to resolve the issue of firebase auth by segregating the patients and doctors and making them login into different auth sessions. This allows us to create dedicated auth spaces for the doctors and patients so we no longer have the issue of the”lag” with our login sessions. What we now need to resolve is a myriad of backend issues. From allowing the user to submit their entries and be reflected, to the doctors able to zone in on individual patients. Hopefully by the end of orbital, we are able to smooth out these technical kinks. We are aware that flutter along with Firebase can now create a smooth chatroom between 2 node devices. To this end, we would try to implement the chat as a solution and implement it by Milestone 3.


Good Software engineering practices:

The usage of Version Control Systems. The usage of Git and github allows us to create separate segments of code while still having copies of the original functional codebase. This not only allows us to edit code without worries that we’ll accidentally lose all progress, but it’s also extremely useful during quarantine where we can trade code-pieces and still cooperate.
Regular tests and hot-reloads/hot-restart. With Dart and Flutter, we are able to spin up our UI and check our UI without excessive long runtime of cold-restarts (Stopping the app then starting it from scratch again). We capitalise on this to perform regular hot-reloads and hot-restarts to detect problems early and work methodically. Using Dart and Flutter we managed to finish many of our front-end designs and are transitioning to focus on the backend system.
Example test cases that we are considering includes:
Login and auth system: 
Data entry for patients and data access for doctors
Chat function for Doctors and Patients
Navigation around the app



Test case for SUT:
Login and Auth System:

Input: Entering a registered account	(Patient/Doctor)
Expected output: Successful login with that profile 
Observed outcome: We noticed that our Firebase auth has a tendency to “lag” behind 1 account due to an issue with our firebase auth. We plan to resolve this by Milestone 3 where we’ll try to debug the issue that is most likely caused by an issue with the asynchronous portion of the login system.

Input: Entering an account that has not been registered
Expected output: The system rejecting entry and prompting the user to register before allowing entry
Observed Output: The app works well in this respect, if you do not register with the auth system, the app would deny entry according to the auth protocol.

Input: Entering an account but with the wrong password
Expected output: The system denies entry to the user
Observed Output: The Firebase Auth system did feedback on the wrong password input and denies entry into the app.

Potential improvement in the future: 
Consider adding feedback so that the user knows whether they are using the wrong password or just simply using an account that does not exist.

Data Entry for the patient:

The Data Entry system for patients is not yet fully connected to a functional backend, we need to continue to work on that before being able to provide good testing for the system.

Chat function for Doctor and patients:

Input: Doctor clicks the chatroom button from the App Drawer
Expected output: App shows the list of patients that the doctor can check-in with
Observed Output: The App would show the list of users that the doctor can interact with along with the ability to scroll through the doctor’s choices.

Full chat integration is also currently under work, this segment is connected to the database portion for firebase and requires more knowledge in utilising cloud firestore. We plan to continue working on the app and push for the updated project to include a fully functional entry creation along with the chat feature.




Navigation Around the app

Case: User == Patient:

Input: Clicking the “View Health Data” button
Output: Bringing the user to the Healthcare data section
Observed Output: The actual output coincides with the ideal case of viewing all health data in a listview

Input: Clicking the “Upload Health Data”
Output: Bringing the user to the Data entry form where the user can write their health entries
Observed Output: The app brings the patient to the form where they can fill in their health data. The ability for users to upload their data to the database has not been implemented as for this milestone, for more information regarding the difficulties refer to the section regarding Milestone 2 insights.

Input: Pushing the app drawer on the left of the user appbar
Output: Extends the drawer of all the available functions of the app
Observed Output: Test case fulfilled

Input: logout when the app drawer is extended.
Output: Initiates the logout() function and logs the user out from the app
Observed Output: Brings the user to the login page, test case fulfilled.

