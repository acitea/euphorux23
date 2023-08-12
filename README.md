Euphorux 2023
=============

Website to Facilitate Euphorux 2023 Operations
----------------------------------------------

For 2023's rendition of Euphorux, I have built this website to serve the  Organising Committee, Gamemasters, Facilitators and Participants (the freshmen). Each target audience is specially catered to with through account/state management for the best possible experience for each of them. 

Do note that this website is meant for MOBILE ONLY.

All Listed Features
-------------------


All features are for All unless stated otherwise.

OC - Organising Committee ONLY\
GM - Gamemasters ONLY\
FC - Facilitators ONLY\
PPNT - Participants ONLY

+ **Gallery**
    - List a bunch of photos from 2022's Euphorux
>
+ **Account-Based Tailoring** _(OC, GM, FC, PPNT)_ 
>
+ [**Scoreboard for Teams**](#scoreboard)
    - Highlighted rankings & positions _(FC, PPNT)_
    - Breakdown of activities with attained points
        - Addiional context of submitted results used to compute points
>
+ **Members List**
    - Default View
        - Lists the participants _(OC, FC)_
        - Lists the facilitators _(OC, PPNT)_
    - [Attendance Taking](#attendance) _(OC, FC)_
        - Mark down present participants
        - Save changes
        - Visual cue for absentees

    _For those listed, a direct hyperlink to their telegram profile will be shown_
+ **Bingo**
    - Randomly generated for the team upon creation _(FC, PPNT)_
    - [View challenges](#bingo) _(OC, FC, PPNT)_
    - [Submit challenges](#bingo) _(FC)_
    - Additional game-related 'power-ups' i.e. zap/swap with other teams _(FC)_
    - [See overview](#bingooverview) _(OC)_
    - Auto scoring
>
+ [**Movement Tracking**](#movementupdating)
    - Display current activity _(FC)_
    - Update next acticity _(FC)_
    - Movement summary _(OC)_
        - Team, arrival timing, departure timing, activity, remarks
>
+ **Hyperlinks to Useful Pages**
    - Facilitator's handbook _(FC)_
    - Points submission _(OC, FC)_
    - Sign up links
    - Social media pages
>
+ **Gamemaster's Page** _(OC, GM, FC)_
    - Points submission
        - Tailored inputs for activities
        - Cross-teams sabotage prevention
        - Duplicate submission prevention
    - Granting powers _(excluding FC)_
        - Enable Bingo power-ups to be used by teams

Some Demos
----------

|Landing Page|<span id="scoreboard">Scoreboard</span>|<span id="attendance">Attendance</span>|
|:---:|:---:|:---:|
|<video width="390" height="844" src="https://github.com/acitea/euphorux23/assets/108735127/8fc937c5-1f90-4b10-81c1-c517ec1c473c"></video>|<video width="390" height="844" src="https://github.com/acitea/euphorux23/assets/108735127/cfae6cd9-f24f-4dd8-8935-9746ae43ca1b"></video>|<video width="390" height="844" src="https://github.com/acitea/euphorux23/assets/108735127/5e238d17-dfcf-45a2-a69c-d19b844e15e4"></video>|

|<span id="movementupdating">Movement Updating</span>|<span id="bingo">Bingo</span>|<span id="bingooverview">Bingo Overview</span>|
|:---:|:---:|:---:|
|<video width="390" height="844" src="https://github.com/acitea/euphorux23/assets/108735127/5aba3647-6ef9-4046-beb1-c4910dc1ea6b"></video>|<video width="390" height="844" src="https://github.com/acitea/euphorux23/assets/108735127/3408b5f2-ad71-49ea-b09d-72e0de001c44"></video>|<video width="390" height="884" src="https://github.com/acitea/euphorux23/assets/108735127/be015605-1ed6-4dc0-85a3-b4c18ace7bdb"></video>|

Built Using
-----------

Tech Stack – Vue JS, Express JS, CSS3, MySQL

>Frontend hosted on Vercel\
>Backend ExpressJS client hosted on Google Cloud Run\
>Database hosted on Google Cloud SQL

#### Setup

Create .env files in the listed directories with the listed variables
1. /BACKEND
* DB_NAME
* DB_HOST
* DB_PORT
* DB_USER
* JSON_SECRET
* ORIGINS
2. _root_
* VUE_APP_API_NAME

Create a local MySQL Database
Restore a backup found in ```/BACKEND/BACKUP CLEANED.sql```

in /BACKEND, run 
> npm i\
> npm start

in _root_, run
> npm i\
> npm run serve

#### End Notes

This is the first and only camp that I know which has integrated a website into its operations, participation and functioning. This is the product of many weeks of development by one amateur developer, collaboration with the programmes & marketing department and feedback from Facilitators themselves to get this up and running smoothly & usefully. Know that whilst building this, there are LOTS of "spaghetti code" which could definitely be refactored to be better, and MORE features that could be great to have like the following:

1. A photowall page where users can upload a photo with captions & timestamp to share "What's happening now"
2. A horizontally rolling sponsors list on the landing page
3. Another tab in the scoreboard page to show overall clan scores
4. A nicer gallery implementation, possibly using masonry
5. Better visual cues for the attendance list
6. Improvements to UI & Design for the OCs
7. Better UAT...

But alas, the priority is to get the main functions working! I will leave it up to any future batches who may be interested :)

Thank you to all those during Euphorux 2023 that used the website as it means that it has served its purpose well. Special thanks to those that encouraged the development, despite some traction. Feel free to contact me :D
