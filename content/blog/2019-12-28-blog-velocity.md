+++
title = "Velocity Berlin, 2019"
date = 2019-11-01T00:00:00+00:00
tags = []
categories = []
draft = true
+++

# Bas @ O'Reilly's Velocity Conference 2019 - Berlin

Within SynTouch, I try to be on top of the next big thing from infrastructure perspective. Therefore, I went to O'Reilly's Velocity conference, in my opinion one of the best conferences someone in my area of expertise can go to. This blog is my report on my experience. I wrote down what I took away from the conference and most important, my lessons learned. This blog is a mixture of my own opinions and those of the speakers.

## Travelling with great Velocity

Six months ago, I've started a consulting job with a young fintech startup in Amsterdam. After years of doing Infrastructure as Code, GitOps and other modern infrastructure practices, I checked with my manager at SynTouch if I could attend [Velocity](https://conferences.oreilly.com/velocity/vl-eu) in Berlin this year.

In my opinion, Velocity is the best conference for people in my line of work to attend. Other conferences often focus on one vendor or product, but Velocity is focused around the opensource ecosystem, with a focus on performance, resilience and security. It's not strange to see that the people in report to really like to see me learning more about this stuff.

I packed my backs and went for Berlin at the end of business on Monday November 4th. After a pretty smooth trip with some small delays, I had a nice veggie burger when I arrived. I went for bed pretty early, because Tuesday promised to be an intense day!

## Tuesday: Hands on tutorials to learn new tools

The day is split in tutorial sessions, taking the entire morning and afternoon. After this, architecture kata's are organized, followed by a social event.

### Observing and understanding distributed systems with OpenTelemetry Monitoring, Observability, and Performance - by Liz Fong-Jones (Honeycomb), Yoshi Yamaguchi (Google)

[session](https://conferences.oreilly.com/velocity/vl-eu/public/schedule/detail/78883)
[slides](https://docs.google.com/presentation/d/1KetPD8hTUGqo9bjZywoKbA_yzj4w5WElHZoWW53pI64/mobilepresent#slide=id.g64b6f960d1_0_0)

This was an amazing way to start the day. Initially, I was pretty overwhelmed by all the Go code and the pace the tutorial moved at. After I got a bit of help and caught up with the rest of the room, it went swimmingly. Go is an amazing language I learned over the summer, and adding telemetry to a sample fibbonnaci application was a breeze to do with some instructions. After the telemetry was programmed in, it was also really easy to export this data to Jaeger, which is a system you can send telemetry data to and use this tool to analyze it.

After we got our data into Jaeger, we fixed some bugs to clarify the data sent to Jaeger. After that, we exported to Honeycomb.io as well. That really looks like a tool I want to spend some attention to in the future!

### SRE classroom: How to design a reliable application in three hours - Jesus Climent (Google), Akshay Kumar (Google)

[session](https://conferences.oreilly.com/velocity/vl-eu/public/schedule/detail/79297)

I looked forward to this one. I strongly believe that SRE is the future of operations. In my view: radical automation, a lot of systems programming and a lot, a lot of architecture! I was not disappointed.

We were split in groups of six and we thought about how we would build a geo-redundant PubSub system spread over 3 datacenters across the United States. We started small and came up with a solution for one datacenter which we then scaled to the end state. We took into account constrains. A few of them were:

- All request should be handled within 500 milliseconds
- One complete datacenter should be able to disappear any time
- We should store 100 days of message retention

Basically we were redesigning [Kafka](https://kafka.apache.org/).

It was amazing to learn how the SRE's at Google tackle this problem. I also realized there is a bunch of planning and designing in SRE. Operations as we know it is really going to change and moving much more to development and architecture. We will not be managing systems by hand again.

### Architecture Kata's

If you have worked with me, maybe even only for a couple of hours, it's not a secret to you that my ambition is to move into an architecture role. These kata's were the thing I looked forward to the most when going to the conference.

Sadly, it was a bit of a disappointment. Only 30 people could participate, the others were able to watch and enjoy free drinks. I didn't want free drinks, I wanted to architect stuff.

## Conclusion of Tuesday

Although the day ended with a downer, it was a fun day. I'm still amazed by the level of the people who attend this conference and I really enjoyed talking to a bunch of fellow attendees. The tutorials were very in-depth and I feel fortunate that I was able to attend them.

I went to a nice restaurant to have some dinner on my own and ponder on what I have learned today, and called it an early night.

## Wednesday: Keynotes and sessions

## Day one Keynotes

The overall theme of today is shared language between different types of roles within your IT operations. Something the writer of this blog is struggling with on a daily basis.

### My love letter to computer science is very short and I also forgot to mail it - James Mickens

[session](https://conferences.oreilly.com/velocity/vl-eu/public/schedule/detail/79562)

A lighthearted opening about blockchain, cryptocurrencies and the problems they don't solve, next to the old technology that became mature. It's hard to capture this session in words, but it made me laugh a lot. It went on about morals in the tech industry. If I need to summarize this session in my own words, we should use our tech skills to make the world a better place.

### Kubernetes at scale: The good, the bad, and the ugly - Karthik Gaekwad

A talk about the managed Kubernetes platform by Oracle. We recently moved to Azure Kubernetes Service at my current customer, so I was curious about the lessons learned by a team building a similar service.

OKE (Oracle Kubernetes Engine, as Karthik calls it) is one of the most popular services on the Oracle Cloud. When developing this, they started with a full stack team doing everything around this service. They learned that k8s is a too big of a topic to be done by one team. Multiple developers are getting deep experience in different areas of k8s. The team was split in the Control Plane, Data Plane and a Platform team.

When you have a small team, there is a constant balance issue between fixing issues and firefighting. Firefighting tends to turn out in apathy and burnouts. This can be fixed by empower the teams to fix issues, grow the team to lessen the operational burden and prioritize bug fixed and features equally. And rotate on calls between feature teams.

Also Kubernetes is not always the answer to your problem. When you hold a hammer everything tends to look like a nail. You should pick the solution for your problem and not what everyone else is doing.

### Observability: Understanding production through your customers' eyes - Christine Yen

This is a field that's changing rapidly at the moment if you ask me. Christine started about the big difference in priorities and views ops and dev has in the day to day operations. Developers care about shipping software quickly. Operations care about reliability. THey use a different set of tools to look at application behavior. In 2019 a lot of companies are blurring the gap between dev and ops. Developers are on call and need to support their application in production. Operations folks are starting to program.

Observability can be summarized by "What is my software doing and why is it behaving this way". A common language between Dev and Ops they can use to communicate. According to Christine, the next step is to make observability tooling useful for other roles as well. (Sales, Finance, Product, Marketing and Support)

### The power of good abstractions in systems design - Lorenzo Saine

A Soviet scientist found that 90% of the problems in engineering had been solved with 40 basic principles. An engineering principle called TRIZ, or "Theory of Inventive Problem Solving", was mentioned. It is curious to see a lot of problems are already solved in a different discipline.

Often 2000 years ago.

This is a system problem, and not an individual problem. Abstract problems need abstract solutions that might be applicable for different concrete problems.

Lorenzo makes the case that how bigger the problem space is abstracted, the more reuse of existing solutions can be applied. It makes me realize it is often a good idea to take a step back and look at the bigger picture. Understand the constraint might not be equal for your specific problem.

### Secure reliable systems - Ana Oprea

Security and reliability need to be core concepts in your designs. Although it is easy to qualify them as "100%", this is undesirable. It's very expensive and most often, your customers don't need it. Match the design of your product to the risk profile of your customers.

You manage security risks by understanding your adversaries. You need to map the actors and their motives to determine actions and the target of the attack. Map out what harm these actors can cause. It's undesirable to make security choices that are not in line with the attack patterns and make the operational burden bigger. Security design principles are the usual suspects. Least privilege, Zero trust, multi-party authentication, auditing and detection and recovery. It's interesting to see that reliability design looks a lot like security design. An important step in this is "Zero Touch", as your systems should be managed by automated tooling and not being accessed directly by engineers.

It is also important to manage your 'error budget'. This is the difference between the SLO set by your stake-holders and 100% reliability. You can then check on the tradeoffs in your application. Be aware that insider attackers exist as well, both intentional or accidental.

### Everything is a little bit broken; or, The illusion of control - Heidi Waterhouse

The more optimized something is, the less room there is for problems. These problems can be classified as your error budget. I've learned that planes have an error budget too.

In your daily work, a bunch of abstractions are used. We develop in languages like Java and Go, not assembler. This talking to the CPU directly has been abstracted away, we are standing on the shoulders of giants. Technical debt is inevitable as well. We need to address it, put it on some kind of backlog. Otherwise it'll rot.

What we build stands upon the reliability of others. Your cloud provider, the writer of your compiler or runtime. We should be more aware of that. There is technical debt in that as well. Heartbleed is a good example of this.

We choose suppliers as good as we can manage, but we are relying on the quality of our suppliers. Heidi goes as far as calling control an illusion.

Let's learn from this when we build our systems to be better. Make stuff fail in a correct way without too many side effects. Again, Error budgets, SLO's, and harm mitigation. People make bad choices, let's not let them make fatal choices. This is where circuit breakers are for. Put them in your network, but also in your software. Also, make sure you have a rollback plan without an emergency deployment. Make sure there is layered access to prevent you from destroying your complete application.

A powerful quote: "Everyone's back end is someone else front end", this goes on until we are back at the fundamental rocks we though to think, which was a nice reference to the origin of computers.

## Conference day one Sessions

### Creating a scalable monitoring system that everyone will love - Molly Struve

An interesting talk! Molly starts by explaining how she started out in a mess of different systems monitoring several things and a bunch of alerts sent to mail, slack, sms and calling mobile phones. She describes how she picked Datadog to consolidate all the other tools, and reduced the alerts to a more manageable portion. Benefits are easy onboarding of new employees and developers who are on call as well have a clear incentive on what to do because every alert should require some sort of action.

The presentations hits home to me, because I've been at the monitoring mess in the beginning myself and it's hard to overstate how much your life will improve with a functioning monitoring system with a single view over the entire system without the alert fatigue.

### eBPF-powered distributed Kubernetes performance analysis - Lorenzo Fontana

This one was a bit far from home to me. It is a talk on how you can use Kubernetes pods to interface directly with the underlying Linux Kernel. Although the support for Kubernetes is up and coming, it looks like it's already usable to debug programs running in Kubernetes.

I don't think I'll be using this soon, but it is very interesting to learn about possibilities of Kubernetes and the Linux kernel which are a bit outside of my comfort zone.

### Autoscaling in reality: Lessons learned from adaptively scaling Kubernetes - Andy Kwiatkowski

As I'm solving scalability issues with Kubernetes at my current customer now, I was happy to attend this talk. Andy makes a point that in a traditional datacenter setup, you need to provision for your peak load. In the cloud, this is a waste of resources. This is where auto scaling comes in.

At Shopify, they implemented a custom autoscaler. They do use the Horizontal Pod Autoscaler which is "included" with Kubernetes. But because a new node needs to be span up, it can take a couple of minutes before all the Kubernetes pods scale up. This does not match with their sudden flash sales which will cause a large increase of requests. During these flash sales the scale up takes longer. Sometimes longer than the flash sale runs.

Way. To. Slow. This is why Shopify wrote and operate their own scaler. They know when the flash sales run, though. So product managers can scale a scale-up in advance so the compute is there before the traffics hit the pods. A pretty smart way to do it without an engineering person needing to run kubectl manually.

They can also set a target utilization. So if the servers are 70% busy, and they are above or below that, the system will scale up or down to meet this utilization. This will scale with improvements to the system or conditions that occur that might make the system utilization go up. A cloud autoscaler for GKE or AKS most of the times scales much more aggressively which is very expensive. Shopify wrote a tool which uses real life load data to simulate the auto scaler behavior. They also use an override to scale differently when they run, for example, load tests.

At my current assignment, our load is pretty constant, so we only scale down in the weekends and the nights to save cost. If the load increases or becomes more unreliable, we might need something like this as well, but probably the capabilities of vanilla Kubernetes will be enough.

### Deploying hybrid topologies with Kubernetes and Envoy: A look at service discovery - Lita Cho and Jose Nino

An interesting view from 2 engineers at Lyft about Kubernetes and how to manage a sudden load because people apparently need a lot of cabs.

Envoy is injected as a sidecart in all pods for easy inter-pod communication. It knows about the details so your pods don't have to. All the Envoy processes form a mesh network which abstracts the network away.

Service discovery is the pairing between logical services and physical network addresses. Before Kubernetes, Lyft used a Python service backed by DynamoDB. This is now done by Envoy. This way of working gives you the capabilities to transparently route traffic, do incremental rollouts and give yourself the capability to roll back. Envoy is able to use the Kubernetes Control Plane and create routes to the correct services it needs to use.

The service mesh is a technique I was very doubtful about during this conference as it sounded unnecessary complex to me. I've seen some more talks later on and my opinion shifted to a more favorable stance to service meshes. At the moment, I would state my opinion as "It Depends". As most of my opinions are.

Practical case studies are often the most clear way to place a certain technology in perspective. I really appreciate this talk.

### M3 and Prometheus: Monitoring at planet scale for everyone - Rob Skillington and Łukasz Szczęsny

We're using Prometheus at the office, so I'm curious how to move to planet scale. ;-) I wasn't sure what M3 was before I got into this session.

M3 is build by Uber as a datastore for Prometheus and supposed to scale horizontally. Prometheus is the well known monitoring system lot of  DevOps professional uses. You can add M3 as a remote read and a remote write target in Prometheus, which might be more favorable as a long-term monitoring storage source for Prometheus. This advantage is there because M3 is able to scale over multiple nodes where Prometheus is bound by a single node configuration storage wise. I can see how this might solve scaling issues with Prometheus which we did not run into yet.

First live demo of the day as well. I would lie if it wasn't a bit refreshing.

## Thursday: Even more keynotes, sessions and the inevitable trip back home

## Conference day 2 keynotes

### How to deploy infrastructure in just 13.8 billion years Ingrid Burrington (Independent)

A talk about the history of the universe and how we got to computer. It was a very abstract talk, but in the end, I think the gist is that computers are still a very young field and we should work on the future of the technology instead of maintaining the status-quo of the systems of today.

Ingrid told us we, as distributed computing engineers, have more power than we might think because we can look and understand the scale, which will probably shape the way we will compute in the future. And we have to think about the impact it will make to future generations. Hard to describe a concrete take-away of this talk.

### The ultimate guide to complicated systems Jennifer Davis (Microsoft)

Jennifer starts with Hitchhikers guide to the galaxy references which is a win on its own. Companies have problems figuring out how to move their infrastructure and software to the future and start talking about a bunch of popular buzzwords.

When building new projects, documentation is important. Planning is important and checklists are too. We need a shared understanding of what we are building. We also need to prepare for trouble and make sure we understand outages will happen in ways we didn't plan for. Jennifer also states that snowflakes are cool and they should be described and documented properly. Also, change is inevitable. You probably end up with something else then you planned for when you started building it. You probably have scaling issues. It's important to understand that you need problem solving skills when you are on the way to your end goal.

It's also important to take care of your own mental health and physical health. Watch out for burn-out and anxiety. This seems to be an increased problem in our industry.

It's also important to keep learning. On new industry stuff, but also learn from the systems you build. Also, don't think you need to do what everyone else is doing.

### 5 things Go taught me about open source? Dave Cheney (VMWare)

Looked forward to this since I really like go. I learned it over the summer and I am applying it at work already!

According to Dave, everyone in IT has been impacted by Opensource software. I know my career has. But since Velocity is not a software development conference, he takes a step back and looks at the circumstances and the why of how a opensource project becomes popular. Using Go as an example.

The languages used before had a high burden on management. You need to manage a language runtime like the JVM or the Python runtime. Golang simplifies this by producing a single binary that runs on a big amount of different machines. Cross compilation is dead simple. This makes the first user experience a breeze and that is really important.

Marketing is important too. The gopher mascot is a big recognition point to the language. The logo is a nice example on how you can contribute to an opensource projects without writing a line of code, but using other skills. Those contributions should be acknowledged as well.

If you are going to invest time and money in a new technology, that implicitly means you are going to let your current skills lapse. If management asks people to learn new stuff, they also ask them to let their current skills go.

Go got lucky as well. Docker, Kubernetes, the Hashicorp software, all written in go. It's the same as "writing a hit song". Luck and coincidence.

Golang also makes sure they are very inclusive and their code of conduct, which is important because it sets a precedence on how your community will behave. Golang waiting too long with tackling this. He advices to have a code of conduct in place in your projects from day one. It's required for a healthy, inclusive opensource project.

Next to opensource, you also need open governance. Because otherwise, the party holding the governance is a hard group to join and that's not really inclusive.

### Building high-performing engineering teams, 1 pixel at a time Lena Reinhard (CircleCI)

A talk about how to build distributed team is hard. It needs more attention than a local team because there is no watercooler banter. Less organic forming of a team occurs. A team geographically spread is the most complex distributed system we know. In order to succeed, you need equal opportunities to contribute. This is based on psychological safety, dependability, structure and clarity, meaning and impact. After introducing this, Lena breaks it out and shows how we can implement this in our team.

Trust is build by small actions and moments to connect. Small, "pixel sized" actions. It is important to make room for human interaction in your workspace. Gitlab does this by making people schedule remote coffee moments to get to know your colleagues. It's important to define expectations, lifting each other up and express praise. A difficult thing to implement, but a very important one, is to make sure feedback is shared. According to Lena, this is hard, but your feedback muscle can be trained.

To make more room for Collaboration, it's important to stay humble. This way, you make space for others. Build relationships and make sure 'hero culture' is battled consistently so we reduce pressure on individuals. It also weakens teams. It's a result of an organization failure,  which is a statement I agree on. It's also important to show what you don't know, so an opportunity to learn stuff and improve documentation is created. It is also important to create a culture that encourages experimentation.

communication is hard. It's hard to communicate bad news. Learn to write better: use crisp, short sentences. Be inclusive, avoid cultural references, and add emotion. Make sure you do some editing before you hit send. IS the message clear, what is the expectation you set and what can  you anticipate. By making sure you document you invest in your future.

The last piece of building great teams is continuity. It's never done. It's something you invest in every day. Using connection, collaboration and continuity. One pixel at a time. ;-)

### Controlled chaos: The inevitable marriage of DevOps and security Kelly Shortridge (Capsule8)

Kelly states that infosec can't remain in a silo and needs to be build into your software distribution pipelines. Starting out with chaos engineering, which is a way we randomly break stuff in order to test our resilience, we also should make sure we test our security controls in the same way. This means we have to architect our security controls in a way that we expect them to fail. This also goes for users causing security incidents.

According to Kelly, we should not avoid security incidents, we should hone our skills to respond to them. A good way to do this is to organize game days and use them like planned fire drills. In order to prevent security incidents, you need to raise the cost to exploit your systems. We also need to align infosec be to Distributed, immutable and ephemeral.

Service meshes are a great way to raise the cost of an attack as it abstracts the network away and an attacker needs a way to break out of these to get to the iptables rules. immutable infrastructure, which are infrastructure bits that do not change after they are deployed, provide a bunch of security as well. Remove shell access. Patching is no longer a nightmare because your images are version controlled and complete systems get redeployed. Rollbacks are way easier this way as well. Ephemeral makes our infrastructure have a very low lifespan. Infrastructure that can die any moment makes it hard for an attacker to persist. This raises the cost to attack with a huge factor.

Another fun excersize, shuffle your IP block regularly to confuse attackers and make your infra less predictable. Also, inject errors in your service mesh to test your authentication schemes. Immutable infra is like a phoenix rising from the ashes. The way infrastructure can be gone any time forces attacker to stay in memory. Get rid of the state, get rid of the bugs

This talk was an inspiration. I'm trying all infrastructure projects I architect for to move in this way. I'm going to watch this talk on Youtube once more. This was my favorite keynote.

## Day 2 Sessions

### Cultivating production excellence: Taming complex distributed systems Liz Fong-Jones (Honeycomb)

In previous lives, the server was either up or down. Because systems get increasingly more complex, the state is more in between both states now. We need to do reliability work, and we are adding complexity. Liz also makes the point that heroism isn't going to work because the heroes are burning out. Production ownership needs to be defined in a better way. A lot of complexity is added by conference hype. Do think if you need Kubernetes! A complex environment is hard to operate and people tend to forget who operate these systems. It's easy to understate the human factor and the importance of human happiness. Invest in people, culture and process.

Systems need to be clear and friendly to the people operating them. All people how have a stake in the system need to be involved and you need to make up how to create this. Create a culture in which asking questions in encouraged and learn about the system together. Make sure you see the difference between essential complexity and unnecessary complexity. The latter is also known as technical debt.

A concept from site reliability engineering is service level indicators, service level objectives. The way you graph this is by looking for the event in context, which you can map as a customer journey. We need to know if an event is good or bad. Set thresholds. For example, successful is an http 200 with a response of < 200ms. We also need to check if the event is eligible. Is it a real user, or a botnet?

Then set a SLO and check if you meet it. window and target percentage is important here. So an SLO can be 99,9% of good events within 200ms in the last 30 days. Then monitor if the SLO is in danger. Decide on how long it will take until you will not longer meet the SLO to decide if you need to page someone at 4 AM. You can also use this to decide if it's feasible to do a feature release that might impact the reliability. Or tell the PM now is not the time to experiment.

Iterate on this, remind perfect is the enemy of good. You can't predict future failures as well. You need to be able to debug cases in production. Observability goes much further than break/fix and add a human touch to it. Include non-engineering departments as well.

Do game days, chaos engineering, train for outages. Lack of observability is a system risk. Lack of collaboration is also a system risk. Production Excellence is the key ingredient to success.

### Knative: A Kubernetes framework to manage serverless workloads Nikhil Barthwal (Google)

Serverless is great because there is no hardware for you to manage, but I was always a bit skeptical because it also sounded like the new AWS/Azure/GCP vendor lock-in. Knative is a serverless platform running on Kubernetes, which is cloud agnostic. This all sounds very interesting since you are in control with which vendor gets your money while also abstracting the platform away for your developers.

The room was packed. People were sitting on the floor. The time was too short. There wasn't enough time to demo. This talk is really encouraging me to learn more about Knative but mostly, start playing with Knative as it looks like it's an abstraction upon Kubernetes. It feels like it's still too much of an infrastructure platform and not enough of a developers platform, but I figure it is hard to find the correct tradeoff between complexity and portability.

### Stateful systems in the time of orchestrators Danielle Lancashire (HashiCorp)

Containers are ephemeral and can be destroyed at any moment. But sometimes, you want to save your state somewhere. In Linux, you do this by mounting storage to containers on some kind of persistent storage. Managing this is hard, but it's getting better. Danielle starts out with how Nomad and [cap theorem](https://en.wikipedia.org/wiki/CAP_theorem) works, after which she moves on to the container storage api, to be used as an industry standard to connect orchestration platforms with their storage. This api is to be implemented by the storage provider, and will be controlled from the controller service of the orchestration plane. Basically to create, attach or delete storage.

Secret management is a problem here as the controller needs a long lived secret for it actually to work. After the secret is inserted, the storage provider will then create, format and provide the storage to be mounted. This unfortunately requires privileged containers. It will not solve all problems though, since the API does not specify how it should be used by applications.

Interesting: In Kubernetes, if you run a statefulset and the node goes away, that statefulset will not recover if you do not manually (force?) delete the pod! I didn't know that yet.

A nice explanation about a problem space we are still in the progress of solving.

### Revolutionizing a bank: Introducing service mesh and a secure container platform Janna Brummel (ING Netherlands), Robin van Zijll (ING Netherlands)

I've been at a bank in the past. I know how good they are at adopting new technologies and moving away from old patterns. Yeah, not too good, but probably for good reasons. I wanted to attend this talk because I was really curious how they break out of the old paradigms.

It was an interesting summary of the journey of ING moving from a separate dev and ops organization to devops, and after that a busdevops, with the product managers joining the teams. IT risk and security are of extreme importance. This made their environment composed out of software written by themselves and they really wanted to keep stuff in their own control.

ING wanted a secure container platform because the future of banks is unclear. New competitors are working on payment solutions, like google and apple. ING needs to prove they can add value an IT plays a big role in that. Views need to be real-time, and they need to deliver relative functionality. They waste a bunch of time spending time on things a customer does not directly benefit from.

ING build a container platform on the public cloud. This is a accelerator which they used to use services they didn't want to build themselves. Containers are used because it is vendor independent and very portable. They use a service mesh because it improves observability and security. Public cloud meets their internal SLO. They can learn from other parties by adopting more generic ways of solving their problems.

I was interested about the service mesh. They use it because it's easy to change things like mutual tls by an update instead of 10 weeks of manual replacement. It also centralizes control. Combined with SRE exprecience they improve the observability across the application landscape. It's also much easier to expand or introduce traffic or network policies. Also, IT does not need to spend as much on security since the service mesh takes care of that. This talk sold me on the service mesh. I'm going to take some training on this.

They use Azure Kubernetes Service, with Envoy / Istio as their service mesh. The advantages are that they can use chaos engineering, zero trust and they have no direct access, but everything is in a pipeline.

This talk was reassuring. We're on the right track at my current customer.

### Test-driven development (TDD) for infrastructure Rosemary Wang (HashiCorp)

So many relevant talks! I was tired when attending this, but I might looked forward to this session more than all the other ones. We want to adopt Terraform and really redo the way we do infrastructure at my current customer, and being able to TEST your actual infrastructure is vital.

In test driven development, you normally write tests first, then write code for the feature, then refactor. Red, green, refactor. It helps you to keep the scope of your feature clean. It also ends in more modular, testable code. In infrastructure, we do a lot of end-to-end tests with a bunch of manual testing.

I expected Rosemary to use Terratest, but she started out with the [Open Policy Agent](https://www.openpolicyagent.org/docs/latest/terraform/) and validate against a policy. It's easier for operation teams as they do not need to learn a programming language. (Like Golang, which is used by Terratest)

In the end, testing infrastructure code is hard. But it's a good idea to invest in this so you get a feel for what the blast radius of your changes can be.

## Takeaways

This was my first, and also my last Velocity ever. Because it's the last Velocity ever. I've learned a lot about my craft, even when I was reviewing the things said on the event remotely by shared slide decks. The conference had the amount of depth in architecture and site reliability engineering.

The new conference in 2020 will be "Infrastructure and Ops", I hope to attend this conference as well, as I learned so much on this conference I have issues bringing it to words.

For any remarks, or questions, feel free to reach out! bas.langenberg@syntouch.nl is probably the easiest way to reach me.