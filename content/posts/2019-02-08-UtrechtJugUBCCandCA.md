+++
title = "Two days with Uncle Bob, Robert C Martin @ Rabobank / Java User Group Utrecht"
date = 2019-02-01T00:00:00+00:00
tags = []
categories = []
+++

Although I have never read "Clean Code", by Robert "Uncle Bob" Martin, it's known as one of the books you have to read if you want to grow as a developer. Writing code that's running is one thing, making sure it is understandable and maintainable by yourself and other developers in your team is essential to deliver business requirements in a timely fasion.

It did not take me long to sign up after I saw Java Usergroup Utrecht, together with my old customer Rabobank, posting 2 meetups with Uncle Bob. One is about Clean Code, the other one is about Clean Architecture. After I was confirmed, I checked with my employer, who thought it was no problem at all to attend. Normally I do this the other way around, but I reckoned this would sell out really quickly. Turned out I was right. There were 400 slots for each day, with a big waitlist eager to jump in if someone could not make it.

In this blog, I share what I have learned on these two very interesting days.

# 07-02: Clean Coding with Uncle Bob
I was running late, but fortunately I made it before the first talk. The agenda looked very promising.

Agenda
======
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
TBD