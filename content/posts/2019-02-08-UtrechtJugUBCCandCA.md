+++
title = "Two days with Uncle Bob, Robert C Martin @ Rabobank / Java User Group Utrecht"
date = 2019-02-01T00:00:00+00:00
tags = []
categories = []
+++

# Introduction

Although I have never read "Clean Code", by Robert "Uncle Bob" Martin, it's known as one of the books you have to read if you want to grow as a developer. Writing code that's running is one thing, making sure it is understandable and maintainable by yourself and other developers in your team is essential to deliver business requirements in a timely fasion.

It did not take me long to sign up after I saw Java Usergroup Utrecht, together with my old customer Rabobank, posting 2 meetups with Uncle Bob. One is about Clean Code, the other one is about Clean Architecture. After I was confirmed, I checked with my employer, who thought it was no problem at all to attend. Normally I do this the other way around, but I reckoned this would sell out really quickly. Turned out I was right. There were 400 slots for each day, with a big waitlist eager to jump in if someone could not make it.

In this blog, I share what I have learned on these two very interesting days.

# 07-02: Clean Coding with Uncle Bob

I was running late, but fortunately I made it before the first talk. The agenda looked very promising.

## Agenda of day 1

09.00 Opening</br>
09.15 Clean Code I</br>
11.00 Clean Code II</br>
12.30 Lunch</br>
13.30 Break-out sessions</br>
14.15 Are You a Professional?</br>
15.30 3 laws of Test Driven Development</br>
17.00 Drinks

## Clean Code I and II

After the opening we started with Uncle Bob giving his Clean Code talk. He started out about computers being everywhere nowadays. On his body, carrying an iPhone, smart watch, clicker for the beamer and a sound system so we could actually hear him, everywhere are processors. In a reasonably modern car, there are 100 million lines of code! Also dealing systems companies use to trade are full of code. Aneckdotes about breaks not working and software killing people, and losing 450 million dollars in 45 minutes were told.

The idea behind these stories is that you should see your programmer job as a craft. We should become craftsmen and women and therefore, take it upon us to have a high standard and an ethics code. Because if we will not regulate ourselves, we will be regulated by goverments one day in the future, or at least that's what Uncle Bob thinks.

And I tend to agree with this statement.

Writing Clean Code is hard and noone does it the first time. It takes roughly the same amount of time after writing working code to clean it up. The problem here is the definition of done. Is code done when you have the code working, or is code done when it is working and it is clean?

After showing us some code which was not very clean, and how he ultimately ended up refactoring it, there were a bunch of lessons learned on which he elaborated. These I found the most interesting.

- Don't repeat yourself. A common pattern on avoiding duplicate code;
- Every line of a function should be on the same 'level'. It is considered rude to have a low lever String function next to a high level concept you implemented yourself;
- Soft rule: Maximum of three arguments per function;
- Do not pass a boolean as a arguments value;
- Make classes easy to extend and avoid modifying them; (Open-Close in SOLID)
- Make sure functions do not cause side effects in your program;
- Comments only as a last resort. They should be treated as a failure. You were unable to express the comment clearly in your code;
  - Although some comments are acceptable!
- Function names should be smaller if their scope is big;
- ... And variable names should be smaller if their scope is small!;

## Break-out session: My, my code and I by Rosanne Joosten

An interesting talk of which I hope I can find the slides later. I enjoyed it so well I forgot to make notes. The gist of the presentation was that certain style of coding is a pointer to personality traits a person has. I hope to find the slides online so I can link them here. A real treat!

## Are you a professional

After the break out, Uncle Bob came back and gave us more. Coming back to the standards we should keep ourselves to in order to evolve our profession into a craft. He started with a few pointers.

- Schools prepare kids terribly for the job market;
- Ethics are important but lacking in our profession;
- The amount of programmers is doubled every 5 years
  - 50% of the programmers therefore has less than 5 years of experience

Robert pretended to be our new CTO. He atmitted he would do a terrible job at administration, but he would lay the following standards upon us.

- ***We will not ship shit***
- We will always be ready
  - Technically ready, so we should always be able to deploy to prod. If the business is not ready, that's a different cookie.
- Stable productivity
- Inexpensive adaptability
  - Making changes should be easy
- Continuous Improvement
- Fearless Competence
  - Boy scout rule: Leave everything a bit cleaner than you found it
  - Tests, Write tests. Then write some more tests.
- Extreme quality
- QA will find nothing
- Automated!
- No fragilities
- We cover for eachother
- Honest estimates
- You say no
  - Tell if something is not possible, and stick with it
  - If they ask you to try anyway, tell then you already did and you failed

## The three laws of Test Driven Development

Uncle Bob jumped right in and presented us with his 3 laws:

1. You are not allowed to write any production code unless it is to make a failing unit test pass.
2. You are not allowed to write any more of a unit test than is sufficient to fail; and compilation failures are failures.
3. You are not allowed to write any more production code than is sufficient to pass the one failing unit test.

The arguments made for testing were made after this.

- Test are documentation about how you code works
- Tests written before the implementation is done will make your code easy to test
- Tests before gives you confidence your code will work
- Tests makes your code decoupled
- Tests reduces debug time
  - The code you wrote is written a few minutes ago if you practice TDD. So you are completely aware of what you are trying to do

Consideration to note:

- Tests for gui's are hard to write
  - Make sure you remove all logic from the gui so you can test in the backend
- Accountants are using this strategy for a long time already. People are forced by law to enter every transaction twice. Once as an asset and once as a liability. When comparing these two, the resulting value should always be zero.
- TDD takes practice before you take it to work. A few months of experimentation during your lunch break is neccesary to get the patterns and confidence needed to use it in production work.

After a really interesting day one, I went home inspired, but tired.

# 08-02: Clean Architecture with Uncle Bob

The day I was most excited for was this day. I am an aspiring architect for a looooong time now and I want to learn how to become a good one so I can get a position with a company looking for a good architect. :-) Today went on a lot about good architecture in software development which learned me I should continue walking my current path to becoming a good developer first while always taking architecture concepts into my mind. This excites me a lot, so I made sure I was on time today and had my notepad ready to make notes.

## Agenda of day 2

09.00 Opening</br>
09.15 Clean Architecture & Design</br>
10.15 Architecture: The Real Software Crisis</br>
11.15 Short break</br>
11.30 Break-out sessions</br>
12.15 Lunch</br>
13.15 Break-out sessions</br>
14.00 Short break</br>
14.15 Agility & Architecture</br>
15.15 Specification Discipline</br>
16.00 Drinks

## Architecture: The Real Software Crisis

## Clean Architecture & Design

This was the most interesting session of the two days. It's not a secret I aspire to become a solution architect someday, and that day better be sooner than later. Starting with this slogan "It's not about the technology, it's about the people", uncle Bob took us on a trip down common architectural patterns. Starting by Stating that every developer should involve himself in architecture, I know I am on the correct path to my current carreer goal.

Architecture is something that is alive. If you place it within the big Agile picture as you should, it is the same thing as code. It constantly changes and adapts. Architecture is a living thing. You cannot make it up beforehand, it evolve with the system it tries to describe. Magic happens when software is right, be it clean code or a correct architecture. Effort to maintain or adapt is minimized. Functionality and flexibility are maximized. Software design and architecture are the same thing.

Architecture:

- Minimizes the required human resources;
- If effort done to improve the system is always the same or decreases, this means there is good architecture;
- If effort done to improve the system is inceasing, this means there is ***bad*** architecture;

You can recognize bad architecture if more people are thrown at the problems at hand. Make a mess and fail because your product is not maintainable. Decline in productivity when the mess builds. Clean code and clean architecture are very important to succeed.

Having clean architecture means you should have diciplines into place which make sure your quality is top notch. Diciplines make you feel like you are working slow. Make sure you do not link your self worth to your speed, that's not fair to yourself.

It boils down to two rules:

- Do your job, make the code do what's expected by the business;
- Make sure everything is structured;

Only after these two things are done, your job is done.

Stakeholder might want changes faster then you are able to execute rule one and two. When you run into this problem / discussion, remind yourself that stakeholders have ***NO SAY*** about the architecture. Also, senior people, learn how to deal with people.

Also remind yourself you are a stakeholder as well. Your salary, self worth, and good name as a programmer depends on the quality of the work you do.

Also, make sure to understand that architecture is decoupled from the frameworks you use in your applications. Floorplans of buildings describe the intent of the building, not what it is made of.

Within good architecture, boundaries are set. Frameworks should be decoupled from your business logic, database engines should be decoupled from your business logic. The web is just one big I/O device and should therefore be decoupled from your business logic.

<<<< INSERT PICTURE HERE>>>>

Make sure all the lines point to your business logic, this is the most important. Making sure your business logic is in the center is making sure your code can be properly tested.

Make sure that for every framework you add, you make a costs/benefit analyses. The framework might be free of cost, but the time or overhead it puts on your team is also a cost you need to take into consideration. They should absolutely be decoupled from your app. For dependency injection, only inject critical things. Keep it all in main, so it does not clutter the code.

Also, make sure you make architecture decisions as late as is responsible. Good architecture maximizes the amount of decisions not made.

## Break-out sessions, part 1

Here I picked the session by Roy van Rijn, who I've seen at the Rotterdam Java User Group. He describes a project he did at the port of Rotterdam. Let's sum up what I learned!

- Teaching is learning
  - Which reminds me to speak more!
- Don't do Agile (Which is the way consultants do it), be agile;
- Always design for change;

Something I found ***very*** interesting, make sure you have a 'servant' architect. Just like a scrum master is a servant leader. This person acts between teams. He is free from sprint work to worry/think about possible architecture problems which might occur in the future. He acts as a filter between management and the teams.

He is a shit filter.

## Break-out sessions, part 2

Second break-out session I did today was about modules vs microservices by Sander Mok. He wrote a book about modules in Java 9. He defended the design of a good monolith versions defaulting to microservices. The challenges microservices bring are for example:

- Introduces a bunch of new problems like complex monitoring, network architecture and other examples
- Higher startup cost; 

## Agility & Architecture and Specification Discipline

Uncle bob combined the last two talks of the day into one. It was mostly about agile. The usual story, so I will simply sum this up.

- Software planning has one inevitable trade-off. Take 3, you cannot have the fourth;
  - Good;
  - Fast;
  - Cheap;
  - Done;
- Delivery dates are always frozen, the definition of done is never frozen;
- Make sure to put your application in front of customers quickly, it will give you time to adapt;
- When you have a schedule issue, you can fix it in a bunch of ways;
  - More staff, this is risky;
    - Will slow down the people which were already in the team;
    - You cannot predict the outcome;
    - *** Most of the time, this is not an option ***
  - Quality
    - "The only way to go fast is to go well";
    - Quality is the only way to go fast;
    - This is never an option to cut;
  - Scope;
    - Remove features;
    - In discussions about what is achivable, data should win; (Productivity of previous sprints)

Agile is getting the bad news as early as possible. Relative estimates are better than absolute ones. Absolute estimates mean you are lying. The job of the sprints you do are to generate data to predict future productivity.

One last thing about story points and burn downs: If the story points go up, the team is being pressured in getting more work done. If the story points are going down, the application is getting a mess and gets more unmaintainable.

I rather had this talk be another top notch talk about architecture, like in the morning.

# Take-aways, things I like to spend some time investigating

The first two are pretty clear:

- Read Clean Code
- Read Clean Architecture

After this, I will:

- Become better at Java
  - Do Kata's
  - Write apps
  - Read Effective Java, 3rd edition (This one was already on the list)

I think I will focus on this for the rest of 2019.

# Closing words

First of all, I really want to thanks Rabobank and Java User Group Utrecht for organizing this fabulous event. The two days had a completely different focus, but they were equally good. I learned a lot and I hope Rabobank considers to do another "code a better world together" event in the future. I will certainly attend!