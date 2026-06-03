---
type: source
title: SAP data walk-through (transport sector)-20260603_093206-Meeting
date-added: 2026-06-03
---

Recording
June 3, 2026, 11:32PM
29m 32s

Donguk Kang started transcription

Yinlun Pan   0:03
and what is in SAP for transport. Our understanding is there are some kind of forms that are submitted on the field will go through SAP. So I think, yeah, so I guess we will just let you kind of give us an overview if you also across that just so that we understand.
the actual data sources and where they are stored.

Bhupesh Balani   0:27
So when you talk about SAP, SAP is...
Very vast for financials. When I am talking about financials, I'm just talking about the month end results for the transport sector contracts. So the report that I've done in Power BI for transport is only gives them the information of what.

Yinlun Pan   0:37
Mm.
Mm.

Bhupesh Balani   0:51
they have spent, how much they have claimed for the month, for the selected month, for that current year. That also gives them the detailed line item from SAP, again coming from controlling document in from BW, not from Databricks.

Yinlun Pan   0:53
Mhm.
Yeah.

Bhupesh Balani   1:10
The other thing that it also brings in is the open commitment data, which is the procurement data that comes from Databricks tables that are built for the enterprise.
So I can just give me a second. Let me just quickly open up my report and I can share my screen.

Yinlun Pan   1:25
Yeah.

Bhupesh Balani   1:35
Yes.

Yinlun Pan   1:35
Actually, sorry, can we take one step back just so we understand your role a little bit? Maybe Duke, because he kind of did the intro, but we probably missing some context for the bigger group from Andrea. So I want to understand what you are actually looking after. So yeah, so we know where.
Uh, if I guess that's the area we need to.

Bhupesh Balani   1:55
So, sure, sure. Yep, that's fine. So I was in transport until January this year. I was the business process improvement manager in transport under finance under Matt Fuller. So I was looking after all the automation and

Yinlun Pan   2:12
Mm.

Bhupesh Balani   2:16
business process improvement for the finance team and the ops team from starting getting the data from SAP or AV or whatever the source is. So was trying to build reports or ease of the data ingestion issues.

Yinlun Pan   2:36
Yeah.

Bhupesh Balani   2:37
Now I am in, I have been seconded into enterprise reporting team. So I work in Ben's team now. But yeah, I'm still looking after some of these key reports that I have done for transport.

Yinlun Pan   2:43
Mm.
Yeah.
Yeah.

Bhupesh Balani   2:53
Financials is one of them, yes.

Yinlun Pan   2:55
Yeah, understood.
Yeah, so sorry, when you say enterprise reporting your new role, is that still, is that for everything or different departments, not only transport?

Bhupesh Balani   3:07
That's correct. So at the moment, what I'm doing is working on the reports that will be in enterprise at an enterprise level, not just transport.

Yinlun Pan   3:08
Okay.
Mhm.
And I guess those enterprise level reporting, it's not part of the obligations for each contract. It's just.
I guess it's just a reporting that's required for the business to understand the overall performance or other purposes.

Bhupesh Balani   3:33
No, it's other purposes. So the one that I did first was the open commitment report, which is again, gives the financial information to the contracts for all the sectors as to how much they have left on their.

Yinlun Pan   3:35
Yeah.

Bhupesh Balani   3:51
purchase orders. The next one was the flash report, which was the month in flash, where they can input because SAP closes on working day five for everyone. So what the CFOs.

Yinlun Pan   3:53
Mm.

Bhupesh Balani   4:10
not CFO, COEs were after was a flash report on working day two or working day three, where every finance team will enter where they land for the month so that they can preempt the result for that month.
Pan.

Yinlun Pan   4:31
Yeah.

Bhupesh Balani   4:32
So that, so it's more around what the enterprise needs. It can be financial or it can be other things as well, but I have only worked with financials at this stage.

Yinlun Pan   4:32
Yeah, I'm stick.
Mm.
Yeah, understood. Yeah, so I'm not sure if Duke has to give you an overview of what we're trying to do. So we were brought in by Jay's team. I believe if I need to make sure that I don't butcher the names of data, AI and innovation that she's I think leading. So we're now looking into

Bhupesh Balani   4:59
Mmh.

Yinlun Pan   5:10
and project called integrated data assets. So we started with transport. So we're trying to, I guess, doing discovery at this stage and trying to understand the current state. So how we can, I guess, if there is a way we can standardize some of those data assets.
Do you think, I guess, yeah, so do you think your, I guess, preview role will be more relevant to our purpose or?

Bhupesh Balani   5:30
Shaun.
I would say so because and are you only looking at SAP data or are you looking at all the system, all the sources that we currently have?

Yinlun Pan   5:39
Mm.
Yeah, it will be order systems, 'cause we don't know what we don't know, so we're gonna make sure that we cover all the grounds.

Bhupesh Balani   5:51
I Kang.
Shaun.
Okay, so yeah, the financials, I can still tell you what is available and what is not. For say, for example, for asset vision, I will suggest Pranav Kumar to contact, to be contacted because he will, he is more closer to that.

Yinlun Pan   6:02
Mm.

Bhupesh Balani   6:14
The other data sets for transport are quick check in Databricks, but that is mainly only for NZOtherDomainServers business, and it's only bringing the data from vendors database so that we can report on our fleet management.
But with regards to financials, yeah, I'm not using Databricks data at this stage because it doesn't give me that granularity that we want for the ops team.

Yinlun Pan   6:38
Okay.
Yeah.
Okay.

Bhupesh Balani   6:52
The plan is to switch over to Databricks data after October, once we get the new, once we move to S4, because we will get a new table in S4 that will have all the information that we need.

Yinlun Pan   7:12
Sorry, what is S for?

Bhupesh Balani   7:14
So S4 is the SAP upgrade that we are currently working on.

Yinlun Pan   7:17
Oh.
Okay, sorry. So that can I, is my understanding correct? So the data source, so where data is coming from is the same as from SAP, but then you, the two different way to store it, you have data bricks and you have another platform or.

Bhupesh Balani   7:37
BW Business Warehouse, yeah, SAP Business Warehouse. So we, I extract the data directly from, because before Databricks, that was the only method that we were able to extract the data from SAP.

Yinlun Pan   7:41
Ohh.
Right.
Okay.
Right, so the true data warehouses, basically, data bricks, um, you saying and BW and data brick, it's not accurate at this stage because, ohh.

Bhupesh Balani   7:59
And BW, yep, yep.
No, no, it is accurate. It doesn't give the details that we need for the ops team.

Yinlun Pan   8:11
Ah, okay.
Right.
So, when they, I guess, when they built the data pipeline on Databricks, they didn't bring in the most granular level.

Bhupesh Balani   8:22
I won't be able to explain that to you, but from what I understood is...

Yinlun Pan   8:24
Right.

Bhupesh Balani   8:29
BW has more functionality where we can link multiple tables and bring data in one table. In Databricks, we extract data from SAP in their raw table format.

Yinlun Pan   8:32
Nhung.
Mm-mm.
Interesting.
Yeah.
Okay.
Yeah, yeah, okay.

Bhupesh Balani   8:47
So someone needs to merge and link all the files, all the tables that are relevant to build that data set.

Yinlun Pan   8:53
Yeah.
Mhm.
Okay, understood. So is there, I think you mentioned that there's a plan to migrating to Databricks or is it?

Bhupesh Balani   9:06
No, yes, so my transport plan is to migrate after we go live for S4, because there is a new table coming in S4, which is AC doc A, which is the combination of controlling and financial documents in one table. So we are hoping, we haven't seen what the output will be, but we are hoping that

Yinlun Pan   9:14
Mm.
And.
Yeah.

Bhupesh Balani   9:28
all the details will be in that table, one table, and then we will be able to switch easily.

Yinlun Pan   9:30
Yeah.
Yeah, gotcha. When that will be, do you have a rough time on? Oh, that's right. Sorry, you mentioned. Yeah, okay. So, and in terms of the data that you're looking after, and I think the ones that you're describing, they're all finance-related data.

Bhupesh Balani   9:36
October, I think 12th or 14th of October, yep.
Yes.

Yinlun Pan   9:53
Okay, would you be able to give an overview? I think you did a little bit, but just so that we understand what I guess finance data and tell for transport.

Bhupesh Balani   10:04
So for transport, it's, give me a second, I'll just quickly share my screen.

Yinlun Pan   10:08
Yeah, yeah, feel free to do so.

Bhupesh Balani   10:13
So for transport, the financial data is based on...
So it's this whole report is security based. So every contract has access to their contract only. So what they see is, say for example, if they work in QTSA business, they'll only see these three projects in the dropdown.
but then they can see the WBS structure, they can select what they want, cost object they want to see, and they have a view of all the WBSs under their business, all the, sorry, cost objects and WBS under their business, and how they're performing in that selected month. So for May, they can see what the revenue was and what.

Yinlun Pan   10:59
Mm.

Bhupesh Balani   11:01
the other costs were, then they can drill into an individual WBS to see what work orders were underneath that WBS and see their performance as well.

Yinlun Pan   11:02
Mm.
Yeah.
Yeah.

Bhupesh Balani   11:17
And if they select one work order, they can see all the line items as well. And these are all detailed line items coming from SAP.

Yinlun Pan   11:25
Wow, okay.

Bhupesh Balani   11:28
So they don't have to jump on SAP or they don't have to wait for the finance team to give them that this information. This is refreshed every three hours in a day. So they have the latest information coming through for their.

Yinlun Pan   11:28
You.
Mm.
Mm.

Bhupesh Balani   11:48
review and yeah for their analysis. So this has got this is all finance data. The only other thing in here is this open commitment which is coming from the enterprise tool that I've done which gives them the yeah open PO's.

Yinlun Pan   11:51
Mm.

Bhupesh Balani   12:06
for their project for any given month.

Yinlun Pan   12:10
Gnd.
Wow, okay.

Bhupesh Balani   12:13
The others have already been migrated to enterprise solutions. So earlier we had this open commitment for transport sector only, but now it is in an enterprise solution. So everyone in the sector, everyone in the enterprise can view this report.

Yinlun Pan   12:20
Mm.

Bhupesh Balani   12:33
No.

Yinlun Pan   12:33
Yep.
Yep, nice. So probably I would.
So it seems like the reporting is already centralized for finance.

Bhupesh Balani   12:44
Yes.

Yinlun Pan   12:45
Would you say that? Yeah, okay. And then the audience was this one that you show in its PMs and

Bhupesh Balani   12:52
So, this is, this is, this is anyone.
from project engineers, supervisors, to PMs, to GMs, CFO, anyone.

Yinlun Pan   13:05
OK.

Bhupesh Balani   13:06
Okay.

Yinlun Pan   13:07
How?

Howard Gu   13:11
Hi, I was just going to add, so in terms of the like lines on the table here, cost, I assume these are different things that we're doing that have a cost associated, like whether it's a, you know, a subcontractor has to go out and fix something or other. Is there more than just a cost object name? Like do we group
by, call it types of service, if you will, like is it a repair job versus a safety fix versus equipment failure? Do we categorize that in any way?

Bhupesh Balani   13:38
Mm.
Not in this report, and it is a bit hard at this stage, given we have multiple work order management systems within transport, so...
to combine the data from all systems. That's where we are struggling in, that's where we have been struggling in transport to combine and bring that cost, activity-based costing.

Howard Gu   14:12
Yeah, okay. And sorry, can you just help me understand? Sorry, this is probably really obvious to you that revenue here means what the client or the contract is paying Ventia.
And then.

Bhupesh Balani   14:23
The client is paying Ventia is what we are claiming from the client.

Howard Gu   14:25
And then...
Yeah, okay, and then materials, subcontractor, payroll, plan, etc. Those are our costs.

Bhupesh Balani   14:33
Our costs, yes.

Howard Gu   14:35
Kang.
Cool. Thank you.

Bhupesh Balani   14:40
And it also brings the year to date and life to date cost as well, because transport is one of the sectors where we have long running contracts. So it can last from anywhere from 8 years to 25 years or 30 years. So the life to date contract, the cost becomes very important for us.

Howard Gu   15:03
Yeah, well, and is there anything in here around, like, because like, this is sort of like, whenever the client's paying us, but do we also know if the client has like a maximum budget, like per year, per month, per quarter or anything like that?

Bhupesh Balani   15:19
Not in here, no.

Howard Gu   15:21
Okay.
And then sorry, one more question was the...
One second.
Ahh.
And sorry, this includes all of the transport projects, did you say, or is there any exception? Is everything here?

Bhupesh Balani   15:38
Yes, yes. Not all of transport and the JV in transport as well.

Howard Gu   15:45
Okay. And what about, is it, does transport have any like SLAs or abatements? Like if there's a certain KPI or SLA that we don't meet and then we have to, does that show up in this table as well?

Yinlun Pan   15:54
Yeah.

Bhupesh Balani   15:55
Every contract has that, yeah, yeah.
No, because that is different because every contract, say for example, Shrap C, has their own KPI report in Power BI that they have built based on AV data or whatever the source is.

Howard Gu   16:08
Okay.

Bhupesh Balani   16:19
And that's why I was saying, if you want to look after AV, look into AV, then Pranav will be your guy to talk to.

Yinlun Pan   16:27
Mm.

Howard Gu   16:29
Yep.

Bhupesh Balani   16:31
Because KPIs can be very different to for every contract. So we can't just put a standard report in a sector page for, yeah, for every contract. And every, like, I think Strap C has 27 or 20.

Howard Gu   16:32
Thank you.

Yinlun Pan   16:37
Yeah.
I.

Bhupesh Balani   16:52
I think somewhere around that number of KPIs that they report on every month.

Yinlun Pan   16:59
Yeah.
Mm.
So I think similar to Hal's questions on the list of projects, so if it were to, you know, grab the active list of projects under transport, would finance data be the source of truth?

Bhupesh Balani   17:23
Say that again.

Yinlun Pan   17:24
So you know how you got the sub sector and then contract filter. So if I just extract that as a list to assume that that's all the transport projects or contracts that you guys have, would that be the source of truth or given that you guys have the finance data?

Bhupesh Balani   17:28
Mhm.
Not necessarily, not necessarily because this is this report, this filter base is based on whether there was cost in that selected month. So you can, yeah, you can see a contract this month and maybe not next month.

Yinlun Pan   17:54
Right, okay.
Yeah, but I guess then we'll find it.

Bhupesh Balani   18:02
But there are data sets, yeah, there are data sets that we you can connect to in Databricks or BW, where you will see all the contracts within a sector.

Yinlun Pan   18:07
Mm.
Ahh, OK. Is that is that possible if you can point us to that table?

Bhupesh Balani   18:19
Show.

Yinlun Pan   18:19
Yeah, okay. I'll follow up in an email with all the questions. Yeah, that sounds good. And then I, so I noticed that you mentioned there's this, I think, pain point, current pain point. You said activity-based costing is currently missing.

Bhupesh Balani   18:25
Okay.

Yinlun Pan   18:40
Would you be able to elaborate that a little bit? And then also, I think I'm also keen to understand if there are other pain points.

Bhupesh Balani   18:48
So, with activity-based costing, given that we have got Asset Vision Maximo, we use client AVM system to manage our costs and to sorry to report activities and then report on.
quantities and amounts in that. It is.
At the moment, we don't have a solution that can read all the different data sets and bring it into one report that gives the meaningful information to the ops teams.

Yinlun Pan   19:22
Mm.
Right.
So you mentioned asset vision is could be one data source. I think I missed you.

Bhupesh Balani   19:33
Maximo, Maximo is the other one, and then there's a client system for for NZOtherDomainServers. We use client asset management system.

Yinlun Pan   19:36
Asuncion.
No.
Okay.

Bhupesh Balani   19:45
We have the connection to their data, but someone has to work through that, all the different data sources, to give us a logic of what and how we can read and bring that data into the report.

Yinlun Pan   20:00
Yeah, I guess, yeah, okay, so this is very interesting. So I guess what determine like which platform they use? This is just.

Bhupesh Balani   20:00
Set, and that is it.

Yinlun Pan   20:10
Based on contract, would they agree with their clients?

Bhupesh Balani   20:14
I won't be able to tell you that, but for NZOtherDomainServers, as I said, it there's only one option, the client, because for all NZOtherDomainServers business, the client, all the clients uses the same application, so that's why we have to use that same application.

Yinlun Pan   20:17
Yeah, yeah.
Mm.
Mm.

Bhupesh Balani   20:34
For Australia roads business, we had asset vision. So it was deployed on five, I think, five of the contracts. But the issue is that every contract has a different configuration of asset vision.

Yinlun Pan   20:47
Mm.
Hmm.

Bhupesh Balani   20:54
So, all asset vision itself is not consistent across the contract, so, so you got you've got five different versions of asset vision on different contracts, and then now we are switching over to Maximo, so Sydney Harbor Tunnel is the first contract that is on Maximo, and then future contracts would.

Yinlun Pan   20:59
Yeah.
Yeah.
Gnd.
Mm.

Bhupesh Balani   21:14
most probably be going on maximum.

Yinlun Pan   21:17
Right.
Yeah, okay.
Okay, so in order for that line item cost to show up, there needs to be a connections between maximal asset version to SAP, is that?

Bhupesh Balani   21:35
and a translation guide somewhere that tells us which field from Maximo is same as a field in AV.

Yinlun Pan   21:46
Yeah.
Right.
Sorry, what is AV?

Bhupesh Balani   21:50
Asset vision.

Yinlun Pan   21:52
Oh, oh, so that, oh, sorry, that is, okay, that's just the acronym, gotcha.
I see. Okay. Yeah, I think we would love to understand a bit more on asset vision or maximal, given that that's the new platforms where you keep track of all the assets and costing, as you mentioned. You mentioned someone.
Pranav, that's the.

Bhupesh Balani   22:19
Pranav Kumar. Pranav Kumar is the contact person for AV.
for Maximo and for the client.
AWM or AVM, they have just renamed the application in NZOtherDomainServers. I'll suggest you contact.
Gnd.
Liz, Liz Jessop.

Yinlun Pan   22:48
Ohh, OK.
Yeah, I think we are scheduling a call with her, but um...

Bhupesh Balani   22:53
Because Liz is currently working on building a solution. So I had a catch up with her and Adam on Monday regarding what Damien wants for transport sector as a dashboard. But the first question was how.

Yinlun Pan   23:03
Mm.

Bhupesh Balani   23:12
Do you want to do the activity-based costing from all these systems? So she knows all these things. So yeah, you can contact her as well for that.

Yinlun Pan   23:18
Mm.
Yeah.
Yeah, amazing.
Oh, sorry, Maximal, Maximal, so you mentioned there that there's this problem with different configurations between projects that make it harder to, yeah, and then is that still a problem for Maximal given that I guess you guys just started using it?

Bhupesh Balani   23:35
NAV, yes.
I'm not, yeah, it's only one contract, but from my understanding, I think we haven't got maximal connection or data in data breaks for Sydney Harbour Tunnel, but we are hoping for future contracts, the conflict will be.

Yinlun Pan   23:44
Yeah.
Mm.
Mm.

Bhupesh Balani   23:59
change and we will bring the data in Databricks. So again, this is my understanding. I haven't looked at Maximo data yet, so I don't even know where to go. So Liz will be your best contact for that as well.

Yinlun Pan   24:02
Yeah, easier.
Mm mm.
Mm-mmm.
Yeah. Yeah. Awesome.
Okay. So I guess besides that activity-based costing, that's a little bit, you know, it's missing for while reporting and analytics. Is there any other pinpoint?

Bhupesh Balani   24:32
For financials, I don't believe so because all we can extract data from, so we have got most of the tables from SAP in Databricks. The granularity at the moment we are bringing from BW, so I don't think there is a pain point. The only pain point becomes when BW.

Yinlun Pan   24:33
Yeah.
Oh.
Okay.

Bhupesh Balani   24:52
just fails and it doesn't bring the correct data so we have to raise the IT ticket to get it fixed. That's the only pain point.

Yinlun Pan   24:59
Yeah, okay. I guess all the financials or the metrics related to that will be part of the reporting obligations for each contract as well.

Bhupesh Balani   25:18
The report that we did it for transport, it's just purely based on what the contract managers need for their financials. Nothing to do with the contractual requirements. It's purely

Yinlun Pan   25:27
Mm.

Bhupesh Balani   25:35
how they are performing in Ventia on their contract.

Yinlun Pan   25:37
Yeah.
Yeah.
Do you know if providing that is part of the contract requirements?

Bhupesh Balani   25:48
I don't believe so because the contractual requirements for reporting is very different. Financial is only one part of that reporting.

Yinlun Pan   25:58
Yeah, okay.
Yeah, okay, I will probably want to understand what that looks like from each country.

Bhupesh Balani   26:03
That will be, yeah, so that that will be based, that will come from the contracts itself, because most of them or all of them currently do that in Excel, so getting the data from somewhere, yeah.

Yinlun Pan   26:10
Yeah.
Beautiful.
Ohh.
Do they use the same data as you guys? Do they use, you know, any of the...

Bhupesh Balani   26:21
I'm hoping the financials they should be using this data, but for Shake or any other data sets, they will have to go to other systems.

Yinlun Pan   26:31
Sorry, what was the other data points that you mentioned?

Bhupesh Balani   26:34
The check, the check is the safety data.

Yinlun Pan   26:38
Ah, okay.

Bhupesh Balani   26:38
When, when save, when save data.
That's again, that is an enterprise tool that is being managed by the enterprise team, not our enterprise team. Sheik has a different reporting team that manages that Power BI report.

Yinlun Pan   26:43
And Sim.
Ting.
Yeah, okay.
You have a contact for that, just in case. I'm not sure if we reach out at this stage, but...

Bhupesh Balani   27:08
Uh...
Hi, just give me a second. Let me just open that report and see if there is a contact on that report.

Yinlun Pan   27:17
Yeah.
Oh yeah, if, yeah, I'll, if you could share those links to different reports, that might be helpful as well, just at least get our head around things and see what, you know, other aspects to enterprise or project reporting, that would be good.

Bhupesh Balani   27:34
Show, yep, OK, can do.

Yinlun Pan   27:37
Yeah.
Awesome. Is there any other questions from my chain?

Bhupesh Balani   27:48
And I've.

Howard Gu   27:48
Can we get access to it? Probably just the main one as well. Is there any reservations? Can we get access to the dashboard that he shared as well? Or if there's any sensitive here?

Bhupesh Balani   27:52
Sorry, Silva.
Okay.
Ah.

Howard Gu   28:00
Yeah.

Bhupesh Balani   28:01
The problem will be I won't be able to give you access to the whole sector. If you want to understand the logic, I can give you access to one of the projects that you can see how it works. But yeah, the data.
I have either you.
You can request access from Damien. If he approves, then I can give you access to the whole sector.

Yinlun Pan   28:31
Yep.

Howard Gu   28:33
Why don't we raise it with Adam Charlotte at 10:30.

Yinlun Pan   28:38
Yeah.

Howard Gu   28:39
You should be able to help with that.

Yinlun Pan   28:40
So, access.
Okay.
Awesome.

Bhupesh Balani   28:47
Okay.

Yinlun Pan   28:48
In that case, yeah, really appreciate your time and they're all very useful and helpful. So we'll summarize some of the, I think, the ask in an email. So like the table and access or report and all that. Yeah, so we can go from there. Yeah, if you've.

Bhupesh Balani   29:05
And also I've seen you've requested access to Databricks schema for transport. So all of you want access to that? The read-only read access? Yep, I can. Yep, I'll get that. Yep. Yep, I can. No worries.

Yinlun Pan   29:12
Yep.
If that's possible, yeah, yeah, rate is totally fine.
Awesome. Thank you so much. I hope you have a good week. Bye.

Bhupesh Balani   29:26
Okay, thank you.
YouTube, thanks. See ya, bye. No worries, bye.

Howard Gu   29:29
Thanks, Bhupesh. Appreciate your time. Bye.

Donguk Kang   29:30
Thank you.

Donguk Kang stopped transcription
