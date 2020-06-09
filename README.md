Proposed level of achievement: Apollo 11

Tech Stack:

Flutter

Firebase


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
