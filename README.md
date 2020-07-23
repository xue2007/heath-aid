Tech Stack:


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


App Architecture Design:




Motivation:

With the recent COVID situation affecting everyone, drastically changing the way we work and play. One group of people who are particularly hard hit are chronic illness patients. Due to the current situation, visits to the doctor may be difficult or not possible. These situations can expose chronic illness patients at a higher risk. Hence a communication solution between patients and doctors can alleviate this problem.

Even after the virus situation is over, this solution can still alleviate the problem for patients with mobility issues. The ability to convey medical data remotely means less physical visits to the doctor which can prove to be challenging for physically handicapped patients. This solution also makes medical data centralised so when information regarding a specific client is needed, doctors and caregivers can refer for vital details and dispatch information to first-responders when needed.


Aim:

We wish to make patient information more accessible to doctors and caregivers and facilitate remote health monitoring and consultation when face-to-face interactions are difficult or not possible

User Stories:

As a patient with chronic illness, I can update my doctors about some of my health status so that I do not need to make a trip to the clinic/hospital.

As a doctor, I can manage all my patients in a centralised system so that it is more convenient and clearer for my work.


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

We noticed how firebase auth can be tricky to manipulate with asynchronous coding and Future involved as we ran into a few bugs and got stuck with the authentication process. 
We initially wanted users to submit health data entries and let them be reflected on the User’s data board. However we noticed the need to update the respective UI by adding additional rows using flutter-fire. We are in the process of fixing the backend and will get it done by milestone 3.
We plan to implement a chatting function as one of our core functions supplementing the exchange of information between the patients and the doctor.There is a great usage of firebase during implementation where time and user is needed which can be tricky.
Regarding testing our software, we have already ran into many issues on the software and when accessing the specific data required, we are still trying to resolve some of these problems that are raised such as user authentication and logins, reflecting UI changes with addition of Data entries captured on the User’s end. Once these issues are resolved, we should be able to come up with better methods and ways to test out our software. 

Update: As of 29th Jun 2020, the submission of the milestone, we have been able to resolve the issue of firebase auth by segregating the patients and doctors and making them login into different auth sessions. This allows us to create dedicated auth spaces for the doctors and patients so we no longer have the issue of the”lag” with our login sessions. What we now need to resolve is a myriad of backend issues. From allowing the user to submit their entries and be reflected, to the doctors able to zone in on individual patients. Hopefully by the end of orbital, we are able to smooth out these technical kinks. We are aware that flutter along with Firebase can now create a smooth chatroom between 2 node devices and have done it with some small bugs. To this end, we would be integrating the usage of chat function to our backend for the different uploading of information in the other parts of the application.We will  implement it by Milestone 3.


MileStone 3 related insights and learning points:

Overview: Milestone 3 is mostly dedicated to the upload function (remote health record system), UI/UX changes, debugging and to resolve various other concerns raised on MileStone 2.

We noticed that the current DataTable model is insufficient to sustain a robust user base and cannot support regular uploads of data to the Firestore system. To address this issue, we created a separate dataRepository.dart file, with dedicated data retrieval and writing methods and the dedicated repository object.
Of course along the way we face issues with the way our data is structured and that cause us to have to redo a large amount of work done in the initial phase. Specifically, the structure of our NoSQL Database has to be reconfigured in order for our client to display the entries properly.
At a future phase of this project, we envision that we need to continuously debug the database and provide support for security. Data privacy for health data has been a major concern over many credit and healthcare platforms. Simply using Firebase’ oAuth system is insufficient to provide the security coverage that many users who use Healthcare Platform expect. In fact the security protocol can be an entire issue by itself.
Other than the entry to database integration, when we conduct user tests across friends, one feedback was that there are UI features that can be pretty confusing. Such as whether to drag horizontally on the patient’s appointment view. Logging in and updating by dragging downwards.
As the final App requires a reading of an ever-increasing scrolling list of data entries created by users, we are unable to fully implement the full project with the upload feature. However, the app can still serve its purpose of facilitating communication between doctors and patients.
Towards the end of this project, we start to feel the constraint that a DataBase system such as Firebase can impose. Having a private data residency is difficult on Firebase without having deeply nested map objects for each individual user which is highly discouraged for cloud Firestore. Because this significantly increases the time needed for Cloud Firestore to perform reads. Given that Firestore is optimised for faster reads, this defeats the purpose of using Cloud Firestore. If we could possibly start over, we would consider using database management systems such as MongoDB or even some AWS solutions such as S3 Buckets, DynamoDB or RDS. These are all services that are pay-as-you use and resolve many data residency issues as well.
Originally we thought we wanted a concept where we would ask the user to fill in separate fields of health-metric data in a separate page and make certain fields optional in order to resolve certain user problems. The funny thing is we noticed a much simpler solution would be just allow users to govern the format that they upload their data. After all, each patient is unique in their own rights. We can provide a suggested format for the users to follow. However, it’s way better for the patients or caregivers to provide what kind of services they want to show.
This is possibly a source of confusion for many users. We noticed that we may need to remove the button for users to fill in the separate fields. And come back to complete this feature at a later timing. Meanwhile a User Guide or tutorial is probably a better way to illustrate the features and explain how to better use the features on the app. 
The members consist of a Data Science Student who started from no experience with Java and Dart to someone who’s confidently coming up with features and hot-reloading to debug them. Using asynchronous programming and Future streams with some helps and prompts, but able to understand certain fundamental concepts behind some database reads and writes. And an Information System student who worked tirelessly to debug issues with code bases from UI/UX to firebase auth. The app at the end may not be the prettiest in the whole group, but we certainly learnt a lot in terms of software engineering concepts.



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
Observed outcome: We noticed that our Firebase auth has a tendency to “lag” behind 1 account due to an issue with our firebase auth. We plan to resolve this by Milestone 3 where we’ll try to debug the issue that is most likely caused by an issue with the asynchronous portion of the login system.For now we have a first page where users can select their respective roles, patient or doctor and login to the correct homepage.

Input: Entering an account that has not been registered
Expected output: The system rejecting entry and prompting the user to register before allowing entry
Observed Output: The app works well in this respect, if you do not register with the auth system, the app would deny entry according to the auth protocol.

Input: Entering an account but with the wrong password
Expected output: The system denies entry to the user
Observed Output: The Firebase Auth system did feedback on the wrong password input and denied entry into the app.

Input:Entering an empty password/username
Expected output:The user would be denied entry into the application.
Observed Output:printing of invalid username/password.

Potential improvement in the future: 
Consider adding feedback such as an animated popup so that the user knows whether they are using the wrong password or just simply using an account that does not exist.



Data Entry for the patient:

The Data Entry system for patients is not yet fully connected to a functional backend, we need to continue to work on that before being able to provide good testing for the system.
For now, Patients can access the entry page through the buttons in the homepage and a form will reveal for them to key in their results.

Chat function for Doctor and patients:

Input: Doctor clicks the chatroom button from the App Drawer
Expected output: App shows the list of patients that the doctor can check-in with
Observed Output: The App would show the list of users that the doctor has already and can interact with along with the ability to scroll through the doctor’s choices.

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
