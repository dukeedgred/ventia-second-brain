---
type: source
title: Transport Data Asset Stakeholder Interview-20260603_110443-Meeting Transcript Rui Luan Part 2
date-added: 2026-06-14
---

Donguk Kang   0:05
Yes.

Rui Luan   0:13
Can you see the screen?

Yinlun Pan   0:14
Yeah.

Rui Luan   0:15
Yeah, so each one of these is an individual contract that we get from Asset Vision, essentially. So, for us, we run off the VicRoads 1 because we are in Victoria, and then in there, what we get is actually the standard tables. So, Asset Vision is a system that we use.

Yinlun Pan   0:32
Mm.

Rui Luan   0:34
So all of these are standard across all of these databases. And then in terms of the actual structure, the mandatory fields are all the same. However, for each contract, we have bespoke custom fields or custom forms that we built because all the requirements are slightly different. But the actual, the basic data, it's all there.

Yinlun Pan   0:46
Yep.
Yeah.
Yeah.

Rui Luan   0:54
It's all the same. So from there, what we will do is we write our individual views for.

Yinlun Pan   0:55
Mhm.

Rui Luan   1:01
our data sets, so all of these are views that we've done. And then from there, then we'll build dashboards for, like, say, KPIs and stuff.

Yinlun Pan   1:09
Mm.
Yeah.
Yeah, that's the...

Rui Luan   1:25
But I think this is sort of standard across all the transport sectors. I think they all have their own dashboard to track all of the KPIs. So KPI wants your inspection dashboards, and then you're going to have your response dashboards, which is the jobs. So that's standard across all of our contracts. You have your inspections.

Yinlun Pan   1:34
Mm.

Rui Luan   1:45
then you have your jobs. So those are the kind of main thing. So inspection job defects, that's pretty much how all the contract works if you're talking about transport. But then depends on what contract you're talking about. They might have slightly different things in terms of delivering those works. So for us, we call it FMRP.

Yinlun Pan   1:48
Mhm.
What?
Rui.
Yeah, okay.
Mm.

Rui Luan   2:04
those type of work you need to do some kind of modeling outside of it, which is going to be slightly different for Shrapsy, it's going to be different for Ramsey because they might not even have a KPI.

Yinlun Pan   2:09
Mm.
Mm.

Rui Luan   2:17
But...

Yinlun Pan   2:18
Interesting.

Rui Luan   2:19
The system that we use to run those models is slightly different. So at a basic level, we're all using this system called DTP to do our pavement modeling.

Yinlun Pan   2:29
Okay, so what was it? Sorry, I didn't.

Rui Luan   2:29
I don't know if you heard of it.
The team.
I will put in the chat.

Yinlun Pan   2:36
Yeah, that would be great. Sorry, what kind of modeling that is that is for? Is it pavement?

Rui Luan   2:40
So, pavement, pavement.
Yeah, so I'll give you...
Chow it will help.

Yinlun Pan   2:46
Or is that just to kind of envision how the end state will look like? Is that?

Rui Luan   2:51
So each contract should be different. So on else we have a very stringent requirement. So we'll measure everything based on roughness and running. So it's essentially your writeability of the network. So this is not D teams, by the way. This is just a QGIS. Yeah, yeah, that's right. So like we will map out. So we do surveys on the road to identify how rough the road is. So this is roughness data.

Yinlun Pan   3:04
This is cute. Yeah, QGIS.

Rui Luan   3:12
And then, how much we actually have? So, we load this information, we use DTP to keep to produce what this is how we do on our contract with Scrap C, I think they do it slightly different. So, what we do is we load everything into the system, we set up trigger points, we understand at a certain point you need to do a certain...

Yinlun Pan   3:24
Yeah.
Mhm.
Yeah.
Yeah.

Rui Luan   3:33
type of treatment. So we run that, we generate every single scenario that could actually happen on our network, and that'll take that information elsewhere. And I use, I don't know if you guys heard a programming language called Julia.

Yinlun Pan   3:35
I see.
Mm.

Rui Luan   3:47
Have you heard R? So it's kind of similar. So I wrote a script where it kind of optimizes that. So you have like a million different combinations and then you optimize.

Yinlun Pan   3:47
It's what I yeah.
Mhm.
No one.

Rui Luan   3:57
using linear programming essentially to optimize that and then you get an output where you actually satisfy our annual performance requirements.

Yinlun Pan   3:59
Mm.
Yeah.
Yeah. Amazing.

Rui Luan   4:05
For Strap C, similar thing, they load this kind of information into D teams, but they're just using D team to run optimization because they only have one KPI they need to meet. Whereas us, we have like, I don't know, 16 different KPIs that we have to meet on an annual basis. So it's like, it's very different. So that's why you can't run it in D teams because.

Yinlun Pan   4:08
No.
Mhm.
Yeah.

Rui Luan   4:26
you only optimize saying, this is the score I want to achieve with a minimum amount of budget. That's all it does. So.

Yinlun Pan   4:33
Okay, gotcha. Gotcha. So some sort of optimization model with budget as constraints and with all the KPI as constraints. Okay. Wow, okay. So that's quite advanced. Actually, so I think there are a lot to unpack.

Rui Luan   4:38
Yes, yes.
And then you have your KPI. Yeah, that's right.
Yeah.

Yinlun Pan   4:53
If you don't mind, can we just take one step back? So I want to understand, because you're the first one, one of the asset managers that we're interviewing. Could you help me understand what that role means? And then do you look after a few specific projects? How do you, I guess, work with other asset managers? I noticed there are a few.

Rui Luan   5:03
Mhm.

Yinlun Pan   5:16
people in the same role.

Rui Luan   5:18
Yeah, so I can't speak on behalf of other projects because they all run slightly different. So like from just the project I'm on, so Western Roads Upgrade projects, what we look after is our structures inspections, so our L1, L2 inspections. All the

Yinlun Pan   5:23
Yeah.

Rui Luan   5:37
Don Pavement.
routine maintenance inspections, so if that's your drainage, your guardrails, all of those kind of condition inspections.
But we look after the actual pavement condition inspection, which is once a year. So that's the data that you saw and then doing the processing. And then my team is responsible for generating the capital. So the capital works are the big periodic works. So we do the modeling, we do the, you know, programming of those for both structures and pavement.

Yinlun Pan   5:49
Mhm.
Yeah.

Rui Luan   6:10
And then we pass it on to the delivery team. They go out and validate and then go deliver those type of work. So within my team, there's another component called third party works. So imagine if you have a road network, the developers always come in, making changes to the network. So we have a team dedicated for that to ensure that when they come in, when they do the job.
they do the right thing and then not actually damage our assets and any modification made to that project, we capture as well. So we have an asset engineer that dedicated to actually update our inventory just to make sure that they're being kept up to date. And then we do the reporting side of things, what I showed you before, the KPIs and so on and so forth.

Yinlun Pan   6:46
Listener.
Alright, sorry, this is the roles and responsibility for your team or for... Okay, so what is that team's name? Sorry, I... Oh, okay, so as the manager, management actually take care of all of this. Oh, okay, because my understanding, I thought you guys are just mainly dealing with...

Rui Luan   6:55
That's right.
Asset Management.
Yeah.
That's right, yes.

Yinlun Pan   7:10
Data, but it seems like you're looking after the, I guess, parts of the end-to-end as well, where it triggers the...

Rui Luan   7:17
Yes, so that's the whole point of the asset management is from planning all the way to like disposal. So from the very beginning all the way to the end. So like when there's change to a network, we capture that change and then we work really closely with the routine. So if we see any improvement,
improvement efficiencies we can make, we recommend that. And at the same time, we actually develop the actual program to go there, deliver for the capital works.

Yinlun Pan   7:40
Yeah, yeah. And that is, I guess, federated. Oh, probably not the right word. So, like asset management sits under a project, so it's not a centralized function. Okay, so which project or project?

Rui Luan   7:50
Mhm.
So we used to have a centralized team, but then that team, they lost a lot of knowledge within that team. So I don't know whether it's been best utilized. So Adam Lloyd probably can speak more to that. So yeah.

Yinlun Pan   8:02
Yeah.
Yeah, different, I guess, business models. So sometimes you, some organizations will like to bring it all together and have like different teams look after different projects, but so you guys are more isolated.

Rui Luan   8:19
That's right. So yeah, so at Diana, it's more of that. So like you have your central team that assists each of the project, but at Ventia, it's more individual project have their own asset manager to actually own the process. So yeah.

Yinlun Pan   8:26
Mm.
Yeah.
Yeah, which if I don't know, I think I missed it. Which project or contracts that you're under, Ramsey or?

Rui Luan   8:40
Western Road Upgrade, WIU.

Yinlun Pan   8:41
Okay, so that's the prime primary contract you're looking after.

Rui Luan   8:44
Yeah.
Yes.

Yinlun Pan   8:49
Okay, okay.
I see.
Okay, understood. That's a lot of information. Just trying to digest. Okay, this is really interesting. So maybe I know you kind of help me describe like what you're looking after, but if we could just kind of simplify it, summarize into
And, like an end-to-end workflow, so it's like you mentioned inspection, so that's often when it triggers.

Rui Luan   9:19
We get data, we get data, we look at the data, we analyze it, and then we tell the delivery team what to do, essentially, if you want to think it that way.

Yinlun Pan   9:27
Yeah, so data, so how do you get data? That's through inspections.

Rui Luan   9:30
inspection defects and then so on and so forth, historical analysis, PCS data, so pavement condition surveys and stuff. So yeah.

Yinlun Pan   9:35
Yeah.
Right, so there are different trigger points that could lead to works. Yeah.

Rui Luan   9:42
Yes.

Yinlun Pan   9:45
And they are all.

Rui Luan   9:45
But a lot of them, you wouldn't be overthinking it because you have a very short response on the contract. So if you see a defect, sometimes you need to respond within two hours. There's no planning involved. You just got to go there and do. But there will be stuff smart into smart where we can introduce to look at how we do our inspections. So if we
So, there's also actual triggers where, like, for certain roads, you have to, there's a different inspection frequency, but if you schedule it, optimize it in a way that's less traveling for an inspector or you try to inspect a similar area, then when you will know the job will always generate, you know, a specific area, then you can, you know.
be more efficient in terms of dispatching your crews as well. So, yeah.

Yinlun Pan   10:27
Yeah, yeah, that makes sense. So yeah, so how do you guys structure those inspections? So they're regular, I guess you mentioned that it could depends.

Rui Luan   10:39
Yeah, answer Vision. Yeah, so for, yeah, so this will be across all of the road contracts that you will talk about. They all have inspection schedules that they have to adhere to under the contract. They're all slightly different. So for the Victorian contracts, there's a thing called rd maintenance class, so RMC classes.

Yinlun Pan   10:41
Oh.
Mm.

Rui Luan   11:00
So imagine your Parramatta rd or any of those like major roads that were at a higher class, essentially. Those things need to be inspected more frequently than the other. So depending on the contract, some of them could be twice a week, some of them could be once a week, some of them will be once a month, and so on and so forth. So we need to schedule.
all of those things put into the system to make sure that all of these roads gets inspected. While you're doing the inspections, defect will pop up.
Some of them is a very short time response, you go there and do. And then, and on top of that, we do a pipeline survey, pipeline condition survey that generates the annual program. You go there and fix a whole lot. If we see this multiple small jobs always popping up on this road, rather than constantly going back, fixing them.

Yinlun Pan   11:31
Mm.
Gotcha.

Rui Luan   11:51
or press that, then you don't need to go back and do those things anymore.

Yinlun Pan   11:54
Yeah, yeah, who has the call to say we can bundle this up and we will have to do it.

Rui Luan   11:58
K.
Yeah, so that's my team, yeah.

Yinlun Pan   12:00
Oh.
Oh, okay. I see. Okay, so I think I'm clearer on the end-to-end and how that looks like for you guys. It sounds very interesting.

Rui Luan   12:14
Yeah, sorry, I sorry, my contract, Shrap C, Ramsey will be very similar, but for your now your Sydney Harbor tunnel could be slightly different, so you might want to talk to them.

Yinlun Pan   12:24
Pan.
Yeah.

Rui Luan   12:27
Yeah.

Yinlun Pan   12:28
Yeah. So on Asset Vision, I think that's quite interesting because that's, I guess, the data source, if you like to call it. So.

Rui Luan   12:39
Mhm.

Yinlun Pan   12:42
And you mentioned that, well, obviously you only know what you know under your projects, but I think I heard from another person that they said the different configurations. I think you mentioned that as well under Asset Vision. But it seems like, to your point, it's actually not that different.

Rui Luan   12:55
Mhm.
So the actual core stuff, it's all the same. So your defects, your inspections, your jobs, they're all the same. The configuration is your process flow or additional fields you wanted to capture. So that's where it might be different.

Yinlun Pan   13:07
Mm.
Yeah.
Nhung.
Mm.
Okay.
Because we also know that one of the pain points within organisations or within transport is that they don't currently have, what do you call it, like the item level costing. And so do you think that in your opinion, you also mentioned the connections between assets to yourself and that's not connected.

Rui Luan   13:36
Yes, that's correct.
Mm-hmm.

Yinlun Pan   13:46
Um, but...

Rui Luan   13:48
Trap C is connected, so you can talk to them about it. The reason why we haven't connected is because the way our contract is set up, everything's a lump sum. There's really no incentive to do that.

Yinlun Pan   13:49
Okay.

Rui Luan   13:59
one to one connection because we can't claim our individual asset level or individual job level. For Ramsey, I think they do have that as well. So where if you have a job you wanted to put forward to the client, then you need to track it. And then when they get approved, there's a standard rates that you get given back for each of the jobs. So from there, you get to measure how much you get paid and also you can track how much you spend. So then you can
understand your profit margin for these type of jobs. But for us, they just gave us, like, say, hypothetically speaking, $20 million, you need to go fix everything. So there's really no incentive for us to do that sort of connection. So, yeah.

Yinlun Pan   14:32
Yeah, yeah.
Yeah, yeah, I should say, so I think that's a good segue into, I guess, the project level requirements related to data assets or reporting. So, I guess usually for contract or maybe just speak to your projects, what are the non-negotiable?

Rui Luan   14:43
Mhm.

Yinlun Pan   14:55
data and reporting requirements. I'm not sure if you're actually looking after that at all.

Rui Luan   15:03
So, what do you, can you go a little bit more detail in terms of that? What do you?

Yinlun Pan   15:06
So I guess you mentioned that the cost part, so the item level costing, there's no incentive to provide that because that's not part of the project requirements. It's more so I think benefit Ventia for us to understand our costing and that, you know, give us

Rui Luan   15:13
That's right.
Yes.
Mhm.

Yinlun Pan   15:25
More insights later for different bits, um, so, but I guess...
So, so what is...

Rui Luan   15:32
There is incentive, but it's not really actual requirements. With the other contracts, it's actual contractual requirements, so they're forced to do it, but as the incentive from the company itself, it also gets that information as well. So for us, it's just like on the backbone, because there's so much other stuff going on. Why are we wasting all of these to set this up?

Yinlun Pan   15:40
T.
From a purchase.
Yeah.

Rui Luan   15:52
Even though it's not a contractual requirement, we don't need to do. So that's, I think that's the reason why we haven't done anything with the SAP integration.

Yinlun Pan   15:56
Yeah.
Yeah.
Yeah, yeah. So then you what usually a client will require you to provide when it comes to data or reporting.

Rui Luan   16:08
So we need to let them know whether we have our inspection KPIs. So if we say we're going to do twice a week on this road, we need to demonstrate them either through a dashboard or some sort of way to show them, look, we have done 2 inspections on this road. Same thing with defects and

Yinlun Pan   16:14
Okay.
Mm.
Yeah.

Rui Luan   16:26
jobs and stuff, there is a requirement for us to respond within a certain time for every single job that we raise on the network. We need to demonstrate that to the client saying we have before and after photo to say, all right, we've done this job within the time frame. And on top of that, the capital works is where we propose the work that we're going to do.

Yinlun Pan   16:32
Okay.
Yeah.

Rui Luan   16:46
Once we complete those work, we can for sure, and to say that we actually pass your pavement performance targets as well. So that pavement condition survey data you saw there is a measure for us annually. So that's our KPI. Once you get that information, you process it.

Yinlun Pan   16:46
Mm.
Yeah.

Rui Luan   17:07
we need to show that like 99.9% of the network is less than a certain RI value and then so on and so forth. So our major capital works will be there to kind of making sure that every year when we do this survey, we meet those targets.

Yinlun Pan   17:24
Yeah, understood. So the, I guess the on the client side, from the client's perspective, they only need to, they only care about if you're meeting SLA, meeting KPIs. And yeah, that's, yeah.

Rui Luan   17:37
Correct.
Where are you going to do the work as well? So like the capital work, they need to know where you're going to go. Yeah.

Yinlun Pan   17:43
OK, you gonna, and then...
And to your point, that's why they don't care about the lower level stuff as long as you don't hit the budget, you don't go over it, they don't care how you use them.

Rui Luan   17:53
There's no budget. They give you a flat number for our contract. They give you an X amount of number. If you don't meet your target, we find you. If you meet it, way under, good for you. It's like, yeah, that's kind of how it works on my contract. But for the other contract, it's different. So other ones, you will be, we found a job. Do you want us to fix it?

Yinlun Pan   18:04
Yeah.
Yeah.

Rui Luan   18:12
They say, yes, they give you the money to fix it. So for us, it's like, we'll give you X amount of dollars. Here's your target. You need to meet all of these KPIs. If you don't meet it, we'll find you. If you can meet it under the budget, that's your profit. If you need to overspend to still meet your KPI, that's on you. So there's no risk. So they just give you money and then they walk away, but you need to meet all of your.
Targets, essentially.

Yinlun Pan   18:34
Right, sorry, I so then why why do you say there's no budget, but it seems like there is a fixed number, a flat number.

Rui Luan   18:43
Yeah, so they will give you, say, $12 million for routine, but there's no breakdown in terms of how much for pothole repair, how much for inspection. It's just whatever, however you wanted to spend. So this, whereas in the other contract, a pothole repair, we provided them with a schedule rate, say X amount of dollars per square meter. Do you want us to fix it? This is the cost. You're like, they're like, yes.

Yinlun Pan   18:48
I see.
Mhm.
Yeah, gotcha.
Yeah.
Yeah.

Rui Luan   19:03
then you track it. So that's why there's an incentive for them to track individual things.

Yinlun Pan   19:03
Gotcha.
Yeah, okay. So, so for WRU, for the project you're looking after, it's almost like they're giving you a drawdown. That's how much we want to spend per year. And you got to, yeah, okay. And that's why I think, especially for WRU, the item level stuff is less populated.

Rui Luan   19:14
That's right. That's exactly right. Yeah.

Yinlun Pan   19:25
You have less coverage.

Rui Luan   19:27
Yeah, but I think we should still be doing, to be honest, I think is there is definitely a benefit, but it's just something that we haven't really looked too much into, that's all.

Yinlun Pan   19:33
Mm.
Yeah, yeah, gotcha. Awesome. So understood, I think, so it seems like you guys are also looking after the KPIs, reporting, etc. Is that under Asset Management? Okay.

Rui Luan   19:47
It's a different team, but we build the dashboards, but we understand all of the KPIs, so yeah.

Yinlun Pan   19:53
What would that team be? The one.

Rui Luan   19:56
Performance, business performance.

Yinlun Pan   19:59
OK, and that's again a product.

Rui Luan   20:01
But if you need to, yeah, I can speak to how the data gets pulled out and how the actual, yeah, like pretty much the actual reporting, like whether we're meeting, yeah, so if you need any questions, I can still answer that as well, that part, yeah.

Yinlun Pan   20:15
Yeah, yeah, yeah, so yeah, maybe not going into too much detail at this stage, but yeah, we're gonna take you up on that offer for sure. Okay, so as a Vision, I actually want to talk more about that.

Rui Luan   20:25
Okay.

Yinlun Pan   20:34
And so, so my understanding is it's like a vehicle with some sort of cameras. Is that how you use that? Like, do your inspections?

Rui Luan   20:44
Ahh.
Yes, you sort of right. So, so there's a mobile app of the S Vision where there is a function we can you can all pin to have the camera turned on, so it captures the image of where you're driving every five, 10 meters. So, imagine you kind of building your own Google Street View essentially every time you do inspections. This ability for you to rewind those

Yinlun Pan   20:47
And, and.

Rui Luan   21:08
video footage as well to see what happened the last time we did the inspection too, so on and so forth. So there is an option for that, but I'm not sure. Actually, I think all of the existing contracts are using that function. I know for the VRMC contract that we just recently won, they're not going to use that. They're going to use Regional Vision, which is a separate thing, and I think Shrapsy is already using that.
some of that, but the actual process is very similar. So Regional Vision, I think, is once every 3 meters, you capture the image and there's AI detection. So SA Vision has that as well, but I don't think it's as advanced. But again, there's no actual direct integration between Regional Vision to SA Vision. And Regional Vision, there's no actual modules. It's just literally.

Yinlun Pan   21:39
Mm.
Mm.

Rui Luan   21:51
a dash cam if you imagine. You drive the network, it just captures of videos, but it captures and it identifies defects for you. That's it. But it doesn't create jobs orders, it doesn't create inspection records, it doesn't do assets, it doesn't do any of that stuff. So, yeah.

Yinlun Pan   21:54
Oh, okay. Dash.
Mm.
Yeah, okay. So is that how it works for people on the field? They just, is that how they do the inspection? So they will just drive the car around through the roads that they need to inspect and all the image they will capture after they're done?

Rui Luan   22:23
So...
It's different for each contract. For Shrap C, there's a requirement for them not to get out of the vehicle, so they can't, so obviously they can't go out and do. For us, we have to capture the photo out on the spot. So we'll have two people doing inspection. One person driving, the other person could be doing some fun and fix minor jobs, because 60% off all of our jobs, it's literally just picking up rubbish off the road. So there's no point for us

Yinlun Pan   22:39
Mm.
Ohh.
Wow.

Rui Luan   22:48
to drive there, create a job to send another crew to go there. So we actually will stop the vehicle, pick up the stuff and then go. And then there will be jobs where the signs slightly turn, we just go turn the sign. So it's like a lot of those small jobs. But obviously for the bigger ones, we'll raise the actual job for the crew to dispatch a crew to go there and do. The actual reviewing of the image itself for us is more for claims. So when the

Yinlun Pan   22:49
Okay.

Rui Luan   23:11
the client comes back to you saying, oh, you missed this thing on this day. We use that image to prove. No, that wasn't the case. So it's more for that.

Yinlun Pan   23:12
Yes.
Yeah.
Yep, Duke.

Donguk Kang   23:24
Does the image get processed into like a structured data format or is it just going to be pure image?

Rui Luan   23:29
Yes, I think I think it stopped. Yeah, it's there's a URL link, you can directly access that image, if that makes sense.

Donguk Kang   23:38
Yeah, right. So it's just going to be a pure image, like you're not going to have like matter that data regarding the image? No, okay.

Yinlun Pan   23:44
Yeah.
Didn't you say it has that defects alert for you on the spot?

Rui Luan   23:52
So the actual image itself won't be, but then the image...
has direct link to the jobs to everything. So the actual record itself, you will have, imagine you have a photos table in there, it tells you from which defect, from which inspection, from what type of defect, what it is, but then you just have a field also with the URL link to the image itself where it's been stored. So that's, yeah.

Yinlun Pan   24:14
Mm.

Rui Luan   24:15
That's your photo record, if you want to think of that way. So the actual image itself, it's not really embedding any of those records, but the record is actually stored in the data services.

Yinlun Pan   24:16
Yeah.
Yeah.
No.
And that's in data breaks as well. Oh, okay. Yeah, I might, I might.

Rui Luan   24:26
Yeah.
That's right.

Donguk Kang   24:31
Can you show us some? Oh, sorry. Chow, go ahead.

Yinlun Pan   24:33
No, no, I'm asking the same questions.

Donguk Kang   24:36
Oh yeah, go ahead.

Yinlun Pan   24:39
Oh, so would you be... no, no, you go, go, sorry.

Donguk Kang   24:43
Ohh, I think I think we already know. Yeah, can you walk us through some of the tables that are connected to Asset Vision?

Rui Luan   24:53
Yeah.

Yinlun Pan   24:54
And if you can...

Rui Luan   24:55
I just develop a server, but it's the same thing. Actually, I'll go.
So that's what I was talking about before. So that's your photos table. We'll just go to sample data.

Yinlun Pan   25:05
I'm interested.
Mm.

Rui Luan   25:14
So, in here, you have your actual photo I.D. What's actually, but with us from inspection, which inspection it is, the URL to the actual image, so...
So, um...
There you go, that's your image.

Yinlun Pan   25:37
Oh, nice. Wow.

Rui Luan   25:38
So that's all pretty much there. So if we wanted to build dashboards to directly take data out, that's very accessible. Obviously, when you have this link, you can go to the inspection table to pull out all of your inspection records of that particular thing as well. So it's all
normalized. So you just have to join all the tables together, that's all.

Yinlun Pan   25:57
Yeah.
Yeah, but I guess the so that's the current stage and then you mentioned that what you were actually wanted to on the workflow to look like is that actually triggers the job order so that you don't need to manually put it in. Is that the?

Rui Luan   26:15
Well, that's your ideal world. I think that's what we want.
I'll show you both.
Oh.
So this is a test data from the Regional Vision system.

Yinlun Pan   26:55
Gu.
Yeah.

Rui Luan   27:09
It's not there anymore.
Alright, they removed the data. Alright, I got no test data anymore, but anyways, I'll show you what W.I.U. Asset Vision one. It's very similar.

Yinlun Pan   27:19
That's so good.

Rui Luan   27:29
Sorry.
Actually, we'll just say the ones we did, okay?
Yes.
I wonder why they released it.
Actually, I think they might have.
I think they went out yesterday, actually.

Yinlun Pan   28:28
Mm.

Rui Luan   28:35
Ah, cool, cool, cool. They actually do something. So, so you will go in here, you see how it sort of picks up the defects.

Yinlun Pan   28:41
Wow.
Mm.

Rui Luan   28:45
Ideally, if these can directly shoot through and then create jobs automatically, it's in a perfect world, but I think it's probably another 10 years away, to be honest. So in a perfect world, this will automatically show us up as jobs, then the inspector don't need to get out of the vehicle or anything like that, because it should pick.

Yinlun Pan   28:46
No.
Yeah.
Mhm.
Yeah.
Mhm.

Rui Luan   29:03
It does pick up your actual dimensions from there, then it triggers the different intervention level under our contract. That's an ideal stage.

Yinlun Pan   29:06
Yeah.
Hmm.
Mm.

Rui Luan   29:16
Uhh.

Yinlun Pan   29:17
So neither of the tools, Retina, Vision or Asset Vision could do that.

Rui Luan   29:25
Yeah, so I said which you can, you can create job orders and stuff, but the thing is you don't want to do that because you're going to get baited like crazy because the accuracy or the stuff that miss is just too much, even with Regional Vision as well. Regional Vision is good in terms of when they see a defect, it's actual legitimate defect, but...

Yinlun Pan   29:27
Oh.
Gotcha. Yeah.
Yeah.
Yeah.

Rui Luan   29:45
it's not, it might not necessarily relate into your network or there will be small stuff that you just completely ignore. So you're going to miss a lot of stuff as well. So for example, this graffiti got nothing to do with us, but you will show up as a job. So there's a lot of like,

Yinlun Pan   29:47
Yeah.
No.
Yeah.
Mhm.
Right.
Yeah.

Rui Luan   30:00
Cleaning, cleansing is required. So I don't know if you can see this. So this is Asset Vision where you drive the networking and see all of these. So all these individual lines that you see here are actual detections that they done.

Yinlun Pan   30:01
Yeah, yeah, yeah, yeah.
Mhm.
Well...

Rui Luan   30:15
So...
This are cracking, which is in the pavement, so, and then I don't know what this is.

Yinlun Pan   30:18
Mhm.
Amazing.
I don't think I will personally notice any of that. You look very minor to me.

Rui Luan   30:28
Yeah, so, so this, yeah, it is a cracking 'cause in the pavement, but then you can go here and you can create a job and then, and then it just creates the actual workflow for you, so...

Yinlun Pan   30:32
Mhm.
Well, okay.
Awesome, wow, okay, so it seems like it's pretty advanced already. So if they don't leverage that functionality, so their workflow will look like, so they have the driving to inspect and then have this defect detector, do they just either do it, finish it, come back to the car?
Lock the work order for tracking purposes.

Rui Luan   31:02
So with us, with our contract, so stringent, like say for example, if you drove here, you saw that branch, that's supposed to be a 116 job. If you come back in the office, lock that job afterwards, you're already over because you did the inspection at this exact time and you didn't race this job at this exact time. So that's

Yinlun Pan   31:20
Mm.

Rui Luan   31:21
That's our contract. For other ones, you probably can't have the ability to come back, review the footage, and then create the jobs later on. So that's what Conor does, like on Shrapsy. So they're using Regional Vision, so they can use these, and then manually go back to Asset Vision and create those jobs. But you can also utilize Asset Vision.

Yinlun Pan   31:24
Mm.
Mhm.
Mm.
Mm.

Rui Luan   31:40
If you using the Auto pilot, you can just create a job like that, and then you will use that photo as the as the job.

Yinlun Pan   31:47
Yeah, so sorry, so how are you guys for your project, how do you lock job orders?
Yeah.
Mm.

Rui Luan   31:58
the vehicle, create a job manually because the sign's leaning, you need to fix that. And then you do the job on the spot and then you drive off and then you keep going. And then when you see a job that's way too big, say for example if there's like a pothole here, you erase that job on the spot and then you drive off.

Yinlun Pan   32:01
I see.
Yeah.
Yeah.
Yeah, yeah, yeah, that's it.
Mhm.
Mm.

Rui Luan   32:18
We're not actually using this because by the time you use this footage to create stuff, it's already too late. You're already over the due time.

Yinlun Pan   32:18
Yeah.
Yeah, yeah, gotcha. Understood. Okay.

Rui Luan   32:27
Yeah. But again, you don't want to automatic generate because you're going to have freaking 10,000 jobs and none of them is not related to us. We're going to get baited again. And then this client be like, oh, what are these jobs? So it's, yeah.

Yinlun Pan   32:31
Yeah.
Yeah.
Yeah.
Yeah, yeah.
Yeah, yeah, you need the human in the loop. So, so I, since I remember you mentioned some of this input data, like people in the field are not so tech savvy. Is data input a problem for you guys and what, what?

Rui Luan   32:42
That's right.
So the part I'm talking about is not necessarily the inspectors. Mostly inspectors are very switched on. So there's two process. You create the defects. So this part here, it's literally generating the job. The crew, imagine the crew that goes out there doing pothole repairs and stuff. It's those people that's

Yinlun Pan   33:01
MMM.
Mm.
Yeah.

Rui Luan   33:14
putting in their time sheets. So if you go to a time sheet, when they complete a job, you gotta select all the material that you use. So we use a vi fix, did we use anything else? We use a crack mat, how much quantity, other stuff that we use, so we also put a sign in there, which vehicle we choose,

Yinlun Pan   33:17
Oh.
Mm.
Yeah.
Mm.

Rui Luan   33:35
who we with, all of these things seem to populate.
Imagine, yeah, like a tradie going there to go and then putting every time when they do a job, they've got to make sure all of these are done correctly. That's probably the most challenging part. Yeah. Because they'll be like, I already fixed the job, why am I need to go there and create all of these? And that's kind of the detail that you need.

Yinlun Pan   33:48
Yeah.
Yeah, okay.
Yeah.
Yeah.

Rui Luan   33:58
to send it back to SAP so you can track how much you actually, the actual cost for this job.

Yinlun Pan   34:01
The costing.
Okay, and so I guess the problem of that data input quality is really just on the costing. So there's no, I guess, no other impacts on other areas.

Rui Luan   34:16
It doesn't it doesn't impact the client or anything; it's just for us internal use, yeah.

Yinlun Pan   34:18
It doesn't impact, yeah, we can't track our profit, I guess. Yeah, okay.
Yeah, I don't know. Not.

Rui Luan   34:28
And then the other things we need to understand is these kind of things for our contract, those open roads ones, you're going to, a crew could be doing like 20 sign cleaning jobs in one day. You don't want them every single time you go there and you fill out all of these time sheets. And it takes more time to do those time sheets than the actual job itself.

Yinlun Pan   34:39
No.
much about me.

Rui Luan   34:47
then it kind of defeats the purpose, right?

Yinlun Pan   34:47
Yeah.
Yeah, yeah, so if there is an automated process, that's where I guess where the area should help with instead of creating.

Rui Luan   34:50
Yeah.
So the system already sort of automating it, like it keeps a record of your previous job, what actual equipments, what vehicle you already use, so you don't have to reuse that. But then obviously the material, you have to go in there and put that in for every job, because it's all going to be different. So.

Yinlun Pan   35:00
Mm.
Yeah.
Mm.
Mm.
Yeah, yeah, interesting. Awesome. I have a few other questions. I think we have 10 minutes left. So you talked about that modeling. I think that's really, really cool. That's such a cool stuff that you guys leveraging, you know, a little bit, a little bit of prediction, predictive and...
analytics as well. Is that just a thing that you created for WRU or is well used in other contracts? Do you know?

Rui Luan   35:45
So D teams, it's been rolled out for like a whole bunch of different contracts, but then obviously every contract has different requirements, so you need to set up the system differently. But the other part, the Julia script, it's completely outside of it. It's a bespoke kind of.

Yinlun Pan   35:56
Yeah.
Gnd.
Yeah, yeah, yeah.

Rui Luan   36:04
thing for WRU just because we're the only contract that has this set of requirements. None of the other contract has that, so.

Yinlun Pan   36:08
Yeah, yeah.
Yeah, yeah, gotcha. Okay. Yeah, so if we, I guess if we wanted to understand a little bit more, that could be an area that we set up another call with with you guys. Is that, are you the, I guess, the best person to talk to on that? Okay, awesome.

Rui Luan   36:25
Yeah.

Yinlun Pan   36:29
Okay, I think that's pretty much everything, but before I let you go, just also wanted to understand, is there any other pain points? I think it seems like from your perspective, everything running quite well. You guys obviously have a lot of advanced processes in place, the tools seems to be...
doing this job as well. Is there any pain points on your line of work?

Rui Luan   36:53
Well, I think it's literally the stuff that I mentioned that we're not doing. So it's the SAP integration, understanding how much we actually spend on each individual jobs. So like when you're doing forecasting, when you're doing the budgeting, it's a bit hard because it is a drawdown contract. So it will give you X amount of dollars for this whole entire area. But then, yeah, we need to understand how much money we're actually spending on each of the activities. So I think that's.

Yinlun Pan   37:01
Mhm.
Yeah.
Yeah.
Yeah.

Rui Luan   37:16
Yeah, you mean if you talk to finance, that's something that I don't think WIU is actually doing that well. That's probably the area for improvement.

Yinlun Pan   37:19
Yeah.
Yeah, are you personally I guess responsible for putting together those those views? How much you spend?

Rui Luan   37:31
No, so that depends on each of the team. So we have the lifecycle team, which that looks after the budget for the actual delivery of the capital works program. That my team that we look after the inspection budgets, essentially. And then we have the routine maintenance that's for, you know, the

Yinlun Pan   37:40
Mm.
Mhm.
Yeah.

Rui Luan   37:48
the minor repairs and stuff so that they have their own budget for that.

Yinlun Pan   37:51
Mm.
Yeah, yeah, so that cost level cost problem is, it's I guess at the at the project level is not something that directly related to you. Yeah, OK. What about I guess yourself? Any any other like pain points just in your day-to-day that?

Rui Luan   37:58
Correct, that's right.
That's right.
just too many interviews for VRMC because I'm helping with the mobilization for VRMC and then they just, yeah, I had to interview people. It's too much of that.

Yinlun Pan   38:19
Oh, sorry, what kind of interviews? Like, is that something similar to what we're doing now?

Rui Luan   38:24
No, no, no, no. It's just like, I'm just, it's got nothing to do with everything to be honest. It's just interviewing people to make sure that they actually have people to start on day one of the project. That's all. So it's got nothing to do with anything else.

Yinlun Pan   38:25
Oh.
Oh, okay.

Rui Luan   38:37
Probably just resourcing. I would say that's the pain point. So if there's a lot of stuff that I wanted to implement, but it's just having the time to do it. It's just...
For us to run like just BAU stuff that takes a lot of resource and a lot of time. So if we wanted to roll out something in program, we just, I'll just need time. That's all.

Yinlun Pan   39:00
Yeah, yeah, yeah, if you want to, I guess, like, like a Juliet, is a Juliet program, like similar things you want to do.

Rui Luan   39:06
That one's not, yeah, that one's not too, I don't intend to do too much, but like in terms of optimizing inspections, how we can.

Yinlun Pan   39:11
Mm.
Oh.

Rui Luan   39:15
go out and inspect a certain area so it lines up with the oil crews at the same time and so that way you don't actually dispatching them like everywhere around the network, those kind of things and whether we should do cyclical work rather than always reactive work and those kind of things like.

Yinlun Pan   39:16
Mm.
Yeah.
Ohh.
Yeah, yeah, yeah.
Yeah.
Yeah, okay. Yeah, I think...
I think that's actually something we wanted to help with. I guess how we approach it is, I guess, through data, just building that lens, a centralized lens, and see what we can do with it. But I think that's what you describe as probably aligned with our final goal, our ultimate goal as well.

Rui Luan   39:55
Mhm.
Yeah, because one of the things we're looking at is how long it actually takes us to do each a road. So we have a general baseline, then, you know, we kind of do like a normal distribution graph. So like typically it would be this, and it depends on what inspector, sometimes they do more, they do less, and then we get an idea in terms of what's the capacity, how much they actually can inspect A day.

Yinlun Pan   40:11
Mhm.

Rui Luan   40:18
can we reorganize in a way we can eliminate a whole day altogether that's like a cost saving, all of those kind of things. So, but just no time, that's all.

Yinlun Pan   40:20
Yeah.
Yeah, yeah, yeah.
Yeah, yeah. Do you think that kind of optimization and routing can be grouped together between projects as well, or that's even too hard?

Rui Luan   40:35
Not necessarily, because all of our contracts are very different. You can't use the same crew to drive it to a different area because their actual response time, the actual intervention level, everything's completely different. You've got to retrain the whole crew and they will get confused in terms of what they're looking at anymore.

Yinlun Pan   40:46
Yeah.
Yeah, yeah, okay. Yeah, okay, interesting. Well, really appreciate your time. This is really insightful for us. Yeah, I think the whole end to end, you help us understand, you know, how, how your world look like and how, you know, people in, on the field, how that looks like for them. So

Rui Luan   41:01
Nice.

Yinlun Pan   41:13
Really appreciate that. I think just one, a few things before we close. Are you able to send through some of those data bricks tables? I'm not sure if we will have access yet, but we can probably deal with the access problem ourselves, talk to the right person.

Rui Luan   41:31
Are you going to be interviewing Pranav as well?

Yinlun Pan   41:34
We already talked to talked to Pranav.

Rui Luan   41:36
Maybe get after Dalla, just because I, because he's like actually our centralized person for all Acer Vision stuff. Might be easier because I'm just be conscious of my time, that's all, because I still need to help with the memorization, that's all. So I don't know how much actual data you need as well.

Yinlun Pan   41:38
Oh.
Okay, yep.
Oh, that's okay. Yeah, yeah. Okay.
Yep.
Yeah.
Yeah.

Rui Luan   42:02
Not sure what he has done for the other contracts, so he might give you a better view in terms of putting everything together, rather than a only a pocket of like the transport, like what I can give you.

Yinlun Pan   42:06
Awesome.
Yeah, yeah.
Yeah, yeah, yeah, yeah, definitely. So that includes, I guess, a bit of finance data and the Asset Vision data or photos.

Rui Luan   42:18
Yeah, he will be able to provide you with everything. So all the tunneling projects, all the open roads project, he should have a better view than me because I'm only working on this, whereas Pranav is working across all of them. So, yeah.

Yinlun Pan   42:22
Mm.
Mm.
Yeah, yeah, yeah. Awesome. Yeah. No worries. Awesome. Thank you so much, Ray. And I appreciate your time. Thank you. See ya. Bye.

Rui Luan   42:32
All right, no worries. All good.
All good. Thanks, guys. All right, bye.

Donguk Kang   42:36
Thanks so much, Ray. Yeah.

Tanya Pita de Abreu   42:38
Thank you.
