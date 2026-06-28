---
type: source
title: DB walkthrough with Pranav Kumar
date-added: 2026-06-01
---

DB walk through-20260528_235953UTC-Meeting Recording
May 29, 2026, 11:59PM
50m 9s

Pranav Kumar   6:48
So, what exactly do we want to have the walkthrough of?
So, the whole data bricks, how we have set it up, or...

Howard Gu   6:55
Cool, so.
Look, we probably less that. I think that unless there's anything that Kale is not across that you can run us through. Otherwise, I think Kale has already done that with sort of some of some of the team already. What I'm hoping for, if you're the right person, is to give us a little bit more of a view across like what the transport sector looks like within Ventia
overall, because like my understanding, that's obviously quite big, that there's a number of different contracts at play, right? But I guess we're still sort of trying to figure out what that exactly looks like. We've met a couple of the teams, if you will. The main one being the Sydney Roads team, and then I think Liz Jessop heading up the Ramsey bid.
as well. But like, I'm sure there's more and I guess we don't quite know what that more looks like. So if you can maybe paint us a little bit of a picture of what that transport sector looks like, that would be super helpful.

Pranav Kumar   7:56
So if you talk about transport sector itself, so we have got both New Zealand as well as Australia. In Australia, we have got contracts in four different states. So Queensland,

Howard Gu   8:05
It.

Pranav Kumar   8:15
New South Wales, Victoria, what is it, Western Australia. And now we have recently got this South Australia as well. So these are these states we have been working on. So the Sydney Road, the one which you have been, you have visited, SRAPC contract, Sydney Road,

Howard Gu   8:26
Yep.
Yep, same.

Pranav Kumar   8:39
Performance contract, so that is one of the one of the contracts in New South Wales. Other than that, we also have a contract for Sydney Harbor Tunnel and Western Harbor Tunnel.

Howard Gu   8:41
In.
Yep.
Good.

Pranav Kumar   8:55
Sydney Harbor Tunnel is, they are set up on Maximo at the moment. The data is not syncing to Databricks right now, but there are future plans to get that data as well into Databricks. Western Harbor Tunnel has not started yet.

Howard Gu   9:14
Thanks.

Pranav Kumar   9:16
It is still in construction. So once that construction finishes up, then we'll start doing the maintenance on that as well. So I think it is going to get, we'll go, we are going to get the tunnel in 2008, 28, I think.

Howard Gu   9:17
Yeah.
Okay.

Pranav Kumar   9:36
So that's when we start that. So other than that, there is also a few contracts for motorways and tunnels. So but that contract is going to finish up, I think it has already finished up or it is going to get finished soon. So that comprises of all the.

Howard Gu   9:36
Yeah.
Yep.

Pranav Kumar   9:55
motorways and tunnel around the city. So that includes CCT, Western Distributor, M5 East, LCT.

Howard Gu   10:05
Based.

Pranav Kumar   10:07
So all those ones. So I think we did not get the renewal of those contracts, so that is going to go away anyway. So that is about the New Zealand business, sorry, New South Wales. In Queensland, we have Ramsey, or we call it as

Howard Gu   10:08
And.

Pranav Kumar   10:27
QSTC project, Queensland State Transport Project Contacts. So in that one, we have one project as Ramsey.

Howard Gu   10:30
Yeah.

Pranav Kumar   10:37
Now, Ramsey is the biggest contract, it is going to finish up soon. So that's where we are in the process of rebuilding that same contract. Other than that, we also have Port of Brisbane and Brisbane Airport contract corporation. So we are maintaining the roads around those two areas as well.
For these ones, the data is coming into Databricks, so that's fine.
Then that is again in the Queensland business. Now coming to Victoria, Victoria we have Western Roads upgrade. That is one of the few contracts when we initiated, when we started with Asset Vision. These were the first one.
To get, we got this application on board on this contract, first of all, and then this SRAPC was the second one. Now, Western Road upgrades, then along with that, we also have, we are currently mobilizing VRMC, Victoria Road Road.
maintenance contract. That is, we have got two regions out of three, which is Grampians and Metro East. So those two regions are being mobilized right now. The go live date is 1st of July for that one. So

Howard Gu   12:03
Sorry, dumb question. Do you have this in? Is there a giant list of this by any chance? I like in a Power BI report with dates or anything like that instead of like you going through it? Not that I don't appreciate you doing it, but is it easier if there's just a list that exists somewhere?

Pranav Kumar   12:05
Mhm.
Oh.
So I can write down the list of those contracts which we have, but unfortunately, there is no centralized, you can say, reporting at this stage, who has the data from all the different contracts. There was one check report which was developed.

Howard Gu   12:23
Chan.
Done.

Pranav Kumar   12:37
long ago. I don't know if it is still active or not, but that did have the data coming from different contracts across the organization where transport was one of the organization and we were having the data in that one. So maybe that is something which you can, you might want to have a look at.

Howard Gu   12:50
Okay.

Pranav Kumar   12:57
Right.

Howard Gu   12:57
Thank you, bye.

Pranav Kumar   13:00
Yeah, so that's that. And again, there is another one, Nell, in Northeast Lincoln.
Victoria, which is also, and there is T2D in South Australia. Both of them are under construction at the moment. Once they get constructed, the maintenance will get handed over to us. And there is another one which is in Western Australia, which is called Joint, which is a venture smart. It is a...
joint venture between two or three companies at the moment. And that is a JV which we are running over there. But their involvement is very much limited because they have their own company. We just sort of...
Like whatever is the output of that company, we just get that information from them. So we do not actively get involved into that particular project.

Howard Gu   13:53
Okay, interesting.

Pranav Kumar   13:55
So that's the highlight of all the ones. In New Zealand, we have two big two key contracts. One is Auckland West, and another one will be Transmission Galea. You would be hearing this name quite often. And there are three or four other projects as well in.
In transport, but again, like not that big of a project, so we usually just cover them off, you know, like...

Howard Gu   14:20
Yeah.
Okay.

Pranav Kumar   14:25
So yeah, this is the you can say high level of overview of how many contracts we worked in different places.

Howard Gu   14:33
Yeah, okay. And so, I mean, just roughly, that sounds like to me, we're probably in the like 20s-ish. Like, there's probably big ones, but then there sounds like there's individual tunnels and corridors kinds of thing. Like, is that roughly right, do you think?

Pranav Kumar   14:47
Somewhere around like 15 to 20 contracts altogether.

Howard Gu   14:52
Yeah, okay, okay, that's not too many. And then in terms of like the data people that we should be speaking to to understand, I guess, sort of what data is available. And I guess from the data perspective, there's probably a couple of lenses we would love to understand a little bit more. One is like, is the client providing, I guess, sort of any...
data that we're managing or we need to send back as part of the contract? And then the second question is, is it using any other internal Ventia data or other data that's not the clients that we're sort of supplementing to sort of support the delivery or reporting? In terms of those contracts, like if there's like 20 contracts, does that mean there's 20 data?
People for each of these contracts as well, or is there like the same person doing across contracts? How do you?

Pranav Kumar   15:40
So, so majority big contracts have their own data person. So, like SRAPC, RU contract, NEL contract, they have got their own data person, RAMC as well. But in case if there is for the smaller contracts, they usually come to us.

Howard Gu   15:47
Okay.
Is gone, yeah, yeah.
Kang.

Pranav Kumar   16:00
to see if they can get some assistance in developing anything.

Howard Gu   16:06
I see.

Pranav Kumar   16:06
In terms of your query around...
the data being owned and hosted by whom. So majority of the contracts which I spoke about, all the tunnel contracts are going to go in Maximo, where we will be the owner of the asset data as well. And we would be maintaining the data. So we would, we are required to provide.
regular, you can see reports to the client saying that these are the status of the set and this and that and that we have to keep on providing them. All the contracts, not all the contracts, but New Zealand, sorry, New South Wales and Victoria contracts are required to submit the.
Asset details, by the end of the day, every day. Now, Victoria is every day for us. It is, I think, once for news, it is once a month, so we provide the delta of the assets and, like, whatever is the change in the asset and whatever, like, any addition or any removal of assets which we have done.

Howard Gu   17:00
Alan.

Pranav Kumar   17:17
on their asset because they are the owner of the asset data and we are not. So that's why we have to keep on providing them that information.

Howard Gu   17:25
Oh, okay, that's interesting. And then in terms of Maximo, that's, I think I just did a quick, like that's a separate IBM system and it doesn't, does it connect to Databricks or is there like, is that part of the thinking or anything yet or no, they're just like separate, separate things and we'll keep it separate.

Pranav Kumar   17:35
Liz.
Gu.
So at the moment, at the moment it is separate, but Maximo, like we have first time implemented Maximo in Sydney Harbor Tunnel, and the plan is to implement it on NZLNNO as well as T2D contracts, because all the tunnel contracts are supposed to go into Maximo.

Howard Gu   17:46
Mm.

Pranav Kumar   18:01
So, having said that...

Howard Gu   18:01
Sorry, all the what contract, all the tunnel contracts did you say?

Pranav Kumar   18:03
all the tunnel contracts. So we classify all our contracts as open roads and closed rd contracts or open roads or tunnel contracts. So anything which is not tunnel is the open rd contract.

Howard Gu   18:05
Yeah.
Oh, interesting. Yeah, OK.
Yeah.

Pranav Kumar   18:19
So that's what we define. So for open roads, we mostly have, because tunnel contracts require those location classification as well. Like I've got a building in that building, I've got along level 10 on room number X, we have got 5 assets and those type of way. Whereas in open roads contract.
The area is vast. We are not talking about the, you can say, same location, but a same GPS location, but multiple levels. But we are talking about different GPS location altogether. So that's where it makes a huge difference for both of the contracts.

Howard Gu   18:54
And sorry, the closed contracts from Maximo, and that's because, like, it just sort of makes sense and it works for closed, but open Maximo doesn't do as well, is that?

Pranav Kumar   19:06
We haven't tried it yet. It is not, because first of all, Maximo is expensive to run. So unlike the application which we are running currently as a vision, it is of the fraction of the cost which we have for, which we pay for Maximo. We implemented Maximo because it was not working out for the tunnel contracts, that's why.

Howard Gu   19:08
Okay.
Yeah, OK.
I think.

Pranav Kumar   19:28
In future, we are also looking at whether we want to go into Maximo for open roads contract as well, or we want to go into SAP for, you know, SAP asset management for that one. So again, like that is a future discussion which we are having at the moment, but that is something which is the cards down the line.
So Maximo, like as I was mentioning, Maximo is integrated with Databricks, but it is not done for us. It is done for the telco sector. Once we have that in place, that we want to get that connected as well, but like nobody has got onto that as yet, and that's the reason why it is missing for now.

Howard Gu   19:59
Yeah.
Yeah.
Okay, but like the connections technically there already for a different part of the business, so it's possible, it's just a matter of, yeah, interesting.

Pranav Kumar   20:09
Art.
Yes, yeah.
Probably we can have a chat with Kale as well to see if it is possible for him to get the data in Databricks for this contract as well.

Howard Gu   20:26
Yeah, okay, super. And then in terms of, I guess, all of the bigger contracts with sort of their own data teams and data people, are you able to just sort of share with us some of the names? I think Conor Murphy has obviously popped up and he's probably the...

Pranav Kumar   20:40
I think I shared that already with Jade earlier.

Howard Gu   20:43
Well, actually, yeah, let me just double check. Is that the, sorry, I do have that. I just want to double check. Is that, so if I just read out the names, is that Conor Murphy, Rui Luan, Toby Lynn, Anna Coville, Hui Yinlun, that's the one? Yeah, okay.

Pranav Kumar   20:56
That, that, that's the one.
Yep.

Howard Gu   21:00
Super.
Cool, so.

Pranav Kumar   21:02
Probably, I don't know, like there is one person as well. She's the business engagement manager in New Zealand business. She has been working on the reports lately A lot. She's trying to develop some sort of reporting for all the contracts. But she's not too much technical around that. She's more of a business person.

Howard Gu   21:23
Okay.

Pranav Kumar   21:23
So I don't know whether we want to include her into this discussions or not.

Howard Gu   21:27
Yeah, yeah, yeah. I mean, no reason not to. What's her name? Sorry.

Pranav Kumar   21:31
I'll put that in the chat.

Howard Gu   21:33
It could be great.
Okay.
And then in terms of, because I think the other one I heard from like Shrapsy and let me know if this is better to just have that session or chat with Conor. I remember him mentioning like they had a data set up, etc. on like Amazon Web Services, like something else on AWS. Do you know much about that or am I maybe I misremembering or misheard?

Tanya Pita de Abreu   21:47
St.

Pranav Kumar   21:49
Uh-huh.
So...
As far as I understand.
They have got two other systems other than Asset Vision, which is Black Moth and Retina Vision.

Howard Gu   22:15
Yep.

Pranav Kumar   22:16
So Black Moth is going to get finished up, other licenses, other contract is going to get terminated by end of this month, oh sorry, next month. So that is, again, like out of the picture. But the data which we have for that particular one, we have got the GPS location captured every one second or two seconds.
for the entire route which the when the vehicle is doing inspections and it also have the links of the snapshots of the pictures of the videos which has been captured throughout those inspections. So that is that data is there for us to use.
We need to get that information into stored into somewhere at our side, because at the moment it is currently sitting on the black mark side. So that is one thing. Another one is Retina Vision. Retina Vision is the AI processing tool for defect identification. This one.

Howard Gu   23:14
Okay.

Pranav Kumar   23:14
at the moment is not integrating or is not talking to any other systems for now. And the data which is being recorded is stored in their servers, data innovation servers. I think it is set up on AWS. I think probably that is what Conor might be talking about.

Howard Gu   23:15
Okay.
On.
I see. Okay, so I see. Okay, so it's bound. Okay, so it's more limited by the other external vendors and tech we're using and wherever their data is basically, I guess, making available.

Pranav Kumar   23:44
Yeah, so they have the API available to us. If we want, we can get that information into on our side. But the intent was to get that application integrated with asset vision so that we can, they can interact among themselves and we can see the defects, existing defects on retain vision side and.
Retina vision identified defects on asset vision side. So that was the idea, but like we haven't implemented that integration as yet.

Howard Gu   24:12
Got it. Okay. And if you don't mind me asking, what's the distinction between like...
Like what sits in the contracts world versus like what makes it into Kale and his team's world from a data bricks lens? Is there a...
I don't know, like a standard or a framework as to how we're thinking about that today or not really, still early days.

Pranav Kumar   24:32
So.
So anything in production is the responsibility of Kale and his team.
We do not have any edit read-write permissions on the production side. We do have a read-write permission, I would say, to execute data definition and data manipulation as well as data selection.

Howard Gu   24:48
Yep.

Pranav Kumar   25:02
transactions or SQLs in our dev environment. Once we have created it, tested it, and everything is working fine for us, we advise the data Kale team, okay, this is the thing which we have developed. We want to move that into production. And then after the, somebody from their team will go and move it into the production environment.

Howard Gu   25:06
Yep.

Pranav Kumar   25:23
So that's how it works. Other than that, most night, like almost all the views and the, so probably I'll share my screen. I'll show you what exactly we have different in both contracts.

Tanya Pita de Abreu   25:30
Yeah.

Pranav Kumar   25:42
The.
So, in this one, if even if in I'm in Bevan one minute at the moment, so these are the tables for asset vision, so we are trying to eventually this whole data set will be refreshed with this data set, so again, like that is something in the it is going on, so what we have done for...
transport, we have got this catalog created for us, which is transport dev. And in that one, we have one particular schema for each contract. So you can see this is Auckland West to Brisbane Airport contract. This is the finance one which we created separate. Then it is FNDC, SDC, NZLNNO.

Howard Gu   26:35
Yes.
Yeah.
Wow.

Pranav Kumar   26:44
and so on. So these are all the contracts which we have. Now, if I go into, like, for example, this is for Srap C. If I go inside Srap C, you'd see that, like, we have got a lot many tables and views created. So UTBLs are the user tables and UVW is the user views. So we have created all of these.

Howard Gu   26:46
Yep.
Yep.
No.

Pranav Kumar   27:04
views, which is we have created and we just ask their team to go and update into the production. So production has also got the same thing over there, but just that like the ownership and the movement is more strict and it is limited to the Kale team, not to anybody else.

Howard Gu   27:22
Yep.
Yep.

Pranav Kumar   27:24
We can do anything if the user has access to this schema, depending on the read and write access, that person can have or we can play around anything in this particular schema.
Also, another thing is if I go into, probably I should go into catalog, that way it will be easier.
So if I go and select any of these items, so like for example, if I do this and select this one, so if you see that currently the owner is Carla Lauda. So if she's the owner, I cannot do any changes to this particular item. So effectively.

Howard Gu   28:04
Yep.

Pranav Kumar   28:06
In case if I have to do that, like what mostly we do is we try to, once we have made our changes, we try to put that under the group's name instead of the owner to be the group rather than the person itself. So that anybody belonging to that group and go and change the record. So that's how we manage internally.

Howard Gu   28:25
Yeah.

Pranav Kumar   28:27
So, yeah, that that's pretty much it.

Howard Gu   28:27
Yep, makes sense.
OK, amazing, and so I'm gonna guess across those different schemas, like some are gonna have more content than others, right? Like, so some are some are probably blank, like that one, that last one is...

Pranav Kumar   28:37
Yes.
So you would see the most complex and most a lot many reports, a lot many views and schemas will be a lot many views will be in the row contract.
WRU contract, then the second number will be a scrap C contract.

Howard Gu   28:57
Because WRU probably has the most, does it? Okay, that's good context.

Pranav Kumar   29:00
Yes, I can show you that as well. So if I go to WRU for this.
So, WRU.
So, if you see that they have got these money tables, so...
All together, they have bought seventy-eight tables and views in here in their own setup.

Howard Gu   29:25
Okay.

Pranav Kumar   29:25
So, so now if you see here that, like, that's what they have done, so, and once we they have created, they have assigned the owner to the group instead of that particular person, and that's so anybody in this group is going should be able to go and edit it.

Howard Gu   29:34
Thank you.
Then if, can I ask, so with the data that's in here, what are we using it for today? Is it just used for, like what is it used for, like downstream reporting? Is it used for like reporting to internal Ventia or external to the clients? Are we doing, yeah, like what are we doing with this data today?

Pranav Kumar   29:44
Uh-huh.
So any sort of reporting which we want to do, it is, and if it is done from Databricks, we are trying to convert them into a simplified view or view which is more relevant to them. And then after they are developing reports out of it, whether it is in the form of a dashboard or if it is in the form of a, you can say a document report or like Word report,
But they get the data prepared over here, and then after puts that into respective reporting platform.

Howard Gu   30:29
Then, reporting platforms, Power BI, is it, or is there other questions is should just have you?

Pranav Kumar   30:31
Yeah, like 90% times it is Power BI, but sometimes it is also like Excel spreadsheet. They just download it and on Excel spreadsheet and then after work through charts and so on.

Howard Gu   30:40
Sure.
OK, cool. Excellent.
That's really helpful. Thank you. The other piece of information that I would love, which I don't know if it exists, is that for every one of those, call it projects or contracts, do we have like a copy of the actual contract, which sort of spells out what exactly we're doing and the types of services we're providing and like any SLAs, etc. that we have?

Pranav Kumar   31:14
Definitely all the contracts should be having one, but I don't think we might have to reach out to individual contracts to get that information. So what are their required KPIs and SLAs around that? So if you want to get into, delve into that one, a few of the contracts does it nicely. So like Rui contract has got a very...

Howard Gu   31:26
Kang.
Yeah.

Pranav Kumar   31:36
detailed reporting around the KPIs because they are required to present that to their clients on a regular basis. So that's why they have got it done nicely. Our SRAPC contract also does it, but they are doing it in a different manner. So some of the items are there on the.

Howard Gu   31:39
Yep.
Mmh.

Pranav Kumar   31:58
The dashboard, some of them aren't, so is the Sydney Hubbard now.

Howard Gu   32:00
Yeah.
Right.

Pranav Kumar   32:03
For Ramsey contract, we developed a majority of the items which they have to use into their monthly report, which goes in the form of a PDF. But it is developed, the dashboards are developed in Power BI, and then after they take the snippets out of that one and put that into their reports.

Howard Gu   32:23
Got it. Okay.

Pranav Kumar   32:23
Reply.

Howard Gu   32:26
And then, are we allowed to see these power, is there any, like, are we allowed to see those Power BI reports for ourselves as well, just to get a sense of like the types of employment?

Pranav Kumar   32:35
I can share you the reports which we have, so you can have a look at that.

Howard Gu   32:38
Okay.
Yeah, okay, amazing. And sorry, let me just clarify. So it sounds like the WRU1 and the Strap C are probably the two most advanced contracts from a capability perspective. Yeah, okay, cool. Okay, so we'll definitely, I think, need to do more on those two things.

Pranav Kumar   32:50
Yes.
Ohh.
See, if you are talking about the reporting perspective, I would say Rui is more advanced in term of reporting. However, if you talk about the technology and the way of doing things, SRFC is more advanced in that one. So, so again, like you will have to juggle a bit between both of the contracts.

Howard Gu   33:05
Okay.
Love it. Yeah.
No, that's really, that's good to know, actually. That's really helpful. Okay, I guess maybe flip it the other way. What do you think is the biggest opportunity across transport? I guess, do you have any views on, you know, what Jay is trying to do to create sort of this enterprise transport data asset? What do you think is the, yeah, I guess biggest, biggest value?

Pranav Kumar   33:39
Again, we tried to do this, you can say sort of sector level reporting earlier as well. We wanted to do the activity based costing of the activities which we have done across the sector. But there were a lot many challenges which we faced at that stage because

Howard Gu   33:53
Yep. Yep.

Pranav Kumar   33:59
our cost was coming from SAP. And majority of the contracts which had the link between SAP and NZAllowAccessHubServers, they sort of not using those links at all because the costing they do, the reporting in such a manner is quite different than what we had.

Howard Gu   34:03
Yep.

Pranav Kumar   34:20
in there. So that was one of the biggest challenges which we had because each contract has been set up in their own way. And as a result, to have them aligned in one way is rather difficult than what we imagined it to be. So that's where we could not progress onto that one any further.

Howard Gu   34:32
Not.
Yeah.

Pranav Kumar   34:41
In terms of few of the data sets is quite standardized. So if you are trying to work out some sort of reporting from the, you can say, asset visions perspective itself, it might seem easier, but actually it is not because.

Howard Gu   34:55
Yeah.

Pranav Kumar   35:00
In asset version, any job or activity which we have done is determined based on the specifications. These specifications have got three level: activity category, activity, and the intervention.
Now, each contract has set up these three levels in the way that suits them. So as a result of this, there is no uniformity among all those contracts as well if we talk about that. So when we want to go into the details of those type of like jobs inspections and so on.
it becomes rather cumbersome to get the things going. A few other areas like check and check, for example, it is, everything is in the same platform, in the same format for all the contracts. So it is easier to create a report and I think there is already an existing report for that.

Howard Gu   35:35
Yes.

Pranav Kumar   35:58
Other than that, if we are going about the KPIs as well, so all the contracts are having their own KPIs, which might vary A lot.
So that is something which you might also want to consider that what exactly we want to track out of it. So because the challenge which I see personally is everybody wants to develop something at enterprise level, but nobody knows what they are going to develop. So that is the biggest challenge which I see in all the.
enterprise level reporting. I have been the part of it on and off as well. But like again, like I see so much of noise, but no actual bits which is happening around that. Like what exactly we want to achieve in there. And like if that is finalized, then how we are going to achieve that is the next step we are going to do.
So again, like from this perspective, I would say the first thing we need to identify that what exactly we want to achieve out of it. Yes, Jade did mention that we want to have some sort of AI capability developed to understand what is giving us, what telemetry data from BWS is giving us, and we want to compare them.
comparison of those, what is that giving us actually? We are not doing the evaluation between the system of BWS system and the EWG system at the moment. So that doesn't add any value to me.
But again, like in case if we are going to talk about, okay, if we are going to use the engine data, then like was it in a longer run, it is going to be helpful for us. Like, I don't know, like if it is going to be a battery issue or like how many maintenance we have done on that particular vehicles. So, and like whether we can forecast any maintenance on those vehicles as well. So these type of information, if we can predict on that one, so that is something which is.
which we can help, which is internal to Ventia. Similarly, in case if we are talking about the predictive maintenance of the assets in different contracts, so something which we can think of is around how we can do this predictive maintenance for now. So at the moment, few of the contracts are doing the...
Have fault code fault code analysis as well, along with their along with the protein fixing or the standard jobs which they do, so...
In case if we can look into that and see if that can the same can be implemented across other contracts as well to ensure that like when we are fixing a pothole, we see what caused this pothole as well along what what fix we have applied to that. So that in case if we are seeing there is an increase in a particular area.
that because of the flooding, the potholes are increasing, then we need to ensure that we want to do some predictive maintenance in that area, that to ensure there is no flooding so that the pothole count can be reduced. So these type of activities which we might want to go at that level eventually. But again, like first of all, we also need to see whether the data is there.
or prepare contract to adhere to that data capture as well. Because that is another challenge which we all will be facing, that the contract doesn't want to do anything extra, which they are not supposed to do as per contractually, from their contractual obligations. So that is something which again needs to be looked at as well.
First, whether the data is available for them, and if it is not, whether they are happy to capture the data, and if they are happy to capture the data, then whether the back-end data is available to them or not, because...
When we are talking about, for example, I'm just taking one example of failure codes as well. So when we are talking about the failure codes, we have got about 10s of thousands of interdifferent interventions, and there might be 100 failure codes which might be useful for us. And we might have to distribute those 50 or 100 failure codes.
among those 10,000 interventions in such a manner that like pothole can have 10 different failure reasons for them. But again, like cracking can have 15 different failure reasons for them. So these type of bits, you might have to prepare the back end data as well.
So that is another challenge which I would say. SRAPC contract wanted to implement that. They started with doing that, but I think they didn't get to the point where they have the whole list available to them. One thing which was done, this was done nicely in the...
tunnel contract for Sydney Harbor tunnel. So Sydney Harbor tunnel, you might find that failure codes has been set up very nicely in Maximo. So that is, again, like there are several bits which we can think of and how we want to do it.

Howard Gu   40:51
Fascinating. So I think in terms of the sort of call it enterprise value and like what is the value add, right? So I think we sort of came up, I guess, with there's only four possible areas. Again, it's not like, you know, there's this sort of a really, really wide net, right? So I think the first one was
if there's anything we can do to help win new bids. And so that one, to be honest, is I think like, you know, in the bid write-ups, like how much information can we provide to capture, you know, all of the existing history, work, experience, et cetera, that we've got. That's potentially one. The second one, I think, was in the mobilization of whatever it is we need to do. So like, do we already have vehicles in the right place? Do we have the right people?
in the right area, availability, that kind of stuff. The third one was, I think, if there's anything as part of the delivery, and so reporting may be a little bit in there, like if we can obviously make reporting a little bit more efficient or a little bit smoother, there's probably a win there. But I think to your point around like the predictive maintenance trade-off versus the...
you know, just sort of fix it now. Again, that one ideal, but I agree in the sense that that's pretty far down the line. There's a lot of work that needs to be done to get to that. And then the 4th one, which I think is a little bit murkier and to be discovered as well, but I think it was raised a few times now around things like just benchmarks.
So like knowing what the, you know, maintenance on average is going to cost per year, et cetera, et cetera. You know.

Pranav Kumar   42:24
was the activity-based costing which I was talking about earlier.

Howard Gu   42:26
Yeah, yeah, exactly right. And so like whether or not that is then another service that you add on or just part of the reporting that you provide, we think there's probably some value there. So that's sort of the like 4 broad buckets. I guess, do you see it that way as well? Is there anything we're missing? Is there one where you're like, oh, probably not.

Pranav Kumar   42:38
Mhm.
So, no, I definitely understand your point. And like, frankly speaking, when I was helping the one of the contracts that which I was working on earlier, I was under the impression because what happened like that one was an IDS contract and we were trying to
get some sort of predictions done at our end. So what would be our maintenance cost for that? And we were sort of trying to replicate SRAPC and Rui contract at the same time, so that because SRAPC's ITS contract was something which they was the.
type of work, how they are doing the work, and whereas we want to see the landscape of Victoria and then how it is going to work for them. So probably in case if we are going to go on to that path for helping the bids actually, then what I might suggest is there are different type of assets.
what are the probability of failing in a particular area, any factors associated with those. So if you can have and what will be the associated cost of maintaining that. Like for example, if you're going to fill a pothole, then what is the cost of pothole and so on. So if you can mix that information, have some sort of.
You can see a dashboard or a readily available data for anyone where we can have some sort of probability, okay, what is the 90, 95th percentile of failing this particular asset and so on. So these type of information, if we can have those information readily available for all the contracts.
Maybe we can use that for bidding purpose, so which, let's say, for example, a particular state we are looking into, or a particular type of asset we are looking into, we can just go and straight away reference this data, because I know because I had to go and sort of develop the whole dashboard or develop whole data for this, and it...
It took me like 2 to 3 weeks to get just to do that, which could have been awarded if it was already there. So, so yeah, again, like those type of bids is definitely would be available. Again, like similarly is the cost around that, so that is for the, you can say, bidding part, I would say.

Howard Gu   44:44
Yeah, OK.

Pranav Kumar   45:01
The solution which we have on the platter at the moment, that is definitely there. Another bits which we are sort of, sort of everybody's trying to push that through in the whole package of asset information management system which we have. So that.
to have our AI engine separately set up, which is which we are the owner, and then after we can just play around. Because at the moment we do have our autopilot from SS Vision, but autopilot is something which is linked internally within SS Vision, and we don't have any ownership of the data and so on. So that's where we were trying to see if we can have retina vision.
which does the same job as autopilot, but we own the data and we have access to all the data in whatever waveform we want. So again, like we can use that information to build some smarts and have a package solution that, okay, this is the solution which we are having offering as a part of a certain information management system.
And that is something which can be included in the bid. So again, like these are my thoughts around the bidding part. From the mobilization perspective, we are fairly, it is fairly straightforward because whatever has been agreed in the bid, that is what we try to implement.
90% times we do have, whatever is the existing solution that suffices the requirement, 5 to 10% times we have to add some, put some add-on on top of it. One thing which, again, like I don't know whether it belongs to.
reporting or not, but we sort of needs to need to have some sort of specified applications for the different type of activities which we do.

Howard Gu   46:50
Yeah.

Pranav Kumar   46:51
Because at the moment, some of the contracts are using some different application for the same job, somebody is using something else and so on. So that is something which, and again, that is another initiative which is I think going on at the enterprise level as well to ensure that we have one single application and simplified solution across the organization. So yeah, mobilization is around that.
In terms of the contract itself, again, operationally, somehow all the projects has adapted to whatever suits best to them. For now, for the new contracts, that is definitely, we can have a look. But again, that will also depend on case-to-case basis, how we want to do it.
So, few standard reports which can be helpful for them and which can be, again, like standard reports which is for the sector level, which is, which I think...
what the senior management want to see, that will be more of on the lines of when we try to do some enterprise or sector level reporting. If we want to go into the granularity of it, we might have to check like what exactly the project wants. But again, like if we are going to go into the...
KPIs, individual KPIs of those contracts, I think it will be too much at this stage.
So if we take it small to see what the senior management wants to look into the dashboards, probably we can start from there and channel it down to see what exactly data we have at the moment and what we can or cannot do out of it.
So that would be my take around these points.

Howard Gu   48:39
Yeah, OK. Super. Thank you. No, that's really, that's really helpful.
OK, I think that's yeah, I guess Tanya, did you have anything else on on your mind to to ask Pranav was we got him here? Otherwise, I think...

Tanya Pita de Abreu   48:54
I think you covered pretty much everything, yeah.

Howard Gu   48:58
Yeah, okay.

Pranav Kumar   48:58
Yeah, and like for easiest way to reach out to me is through chat. So like I might check or not check my emails or might check my emails at very absurd time where I'll say I'll reply it in the morning and I forget most of the time. So easiest way is to just ping me on the teams and I'll probably reply you as soon as possible.

Tanya Pita de Abreu   49:02
Yeah.

Howard Gu   49:09
Beats.
Yeah, yeah, yeah.
Super. We might just share some things for you to look over just to make sure we haven't misrepresented and are capturing the right things as well, I think as we're progressing. So again, the probably first part of what we're trying to do is just get an idea of the lay of the land. And so that will try and sort of document as best as we can. And then if you can help, we'll go over and go, actually, you guys missed this. Can you go talk to this person over there? Or hey, that information.

Pranav Kumar   49:26
Sure.

Howard Gu   49:42
is not quite correct, please let us know. And we'll just sort of try and build a consolidated, I think, information of what data, et cetera, there is for us. And then also the steadily progress to use cases and what else we can do.

Pranav Kumar   49:44
Uh-huh.
No.
No problem.

Howard Gu   49:56
Awesome. Thank you, Pranav. Really appreciate your time this morning.

Pranav Kumar   49:57
Yeah.
No problem at all. I'll let me know if you have any further questions as well.

Howard Gu   50:02
Thank you.
Have a good Friday. We'll speak soon. Thanks, Conor. Bye.

Pranav Kumar   50:06
You too. Cheers. Bye.

Tanya Pita de Abreu   50:08
Yu.

Tanya Pita de Abreu stopped transcription
