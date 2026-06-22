---
type: source
title: Transport Data Product-20260622_153334-Meeting Recording
date-added: 2026-06-22
---

Transport Data Product-20260622_153334-Meeting Recording 

June 22, 2026, 5:33AM 

27m 59s 

 
Shachi Shastry started transcription 

 
Donguk Kang   0:03 
Question as well, yeah. 

 
Shachi Shastry   0:04 
Okay, perfect. Perfect. Yes, now go for it. 

 
Donguk Kang   0:06 
Yeah. 
So we are the consultant from Edge Red. So essentially what we are trying to do is trying to build off an integrated data asset. So what we are lacking as a Ventia as a whole is just because we don't have a standardized data asset, we 
Whenever we try to build up or come up with like an enterprise level reporting or let's say AI capability, it's very difficult for us to bring it in because all the data sources are not in one place, it's everywhere in different sources. 

 
Shachi Shastry   0:32 
One second. 

 
Donguk Kang   0:45 
So essentially starting from transport sector, what we're trying to do is trying to come up with our standard data asset. So later on when we try to build up enterprise level reporting or let's say AI capability, it's easier for us to bring that in. 
So essentially, that's what we're trying to do. 
And what we've been doing is checking the data quality in Databricks, specifically for asset vision for transport sector. I'll quickly share my screen and show you what we've built in Databricks dashboard. 

 
Shachi Shastry   1:20 
Yes. 
So, and Donguk, do you know what we do in the data governance space? 

 
Donguk Kang   1:24 
Yep. 
Ohh, or maybe yeah, it would be good to give you, um, give a quick intro to you of yourself as well. 

 
Shachi Shastry   1:33 
Thank you. So, obviously, I'm Shachi. I'm the data governance Owner for Ventia, and we've actually kicked off the operationalization of the data governance framework. Osaka is a part of my team, but then she's actually from Intelligen, who's an external, who's partnering with us towards actually delivering 
and operationalizing the framework. And we've got another person from Intelligen who's supporting us towards actually configuring Alation. So we've actually got Alation as a tool, a metadata management tool, and a governance tool where we will actually be cataloging all of the data assets as it relates to its respective data usages. 
We are also looking towards implementing and configuring data procs innovation. 
And to Osaka point, what we've been told is transport is actually a data asset that you guys are looking at building for which we will actually come in and partner with you guys in order to ensure that it is actually a well-governed data product in the end. 
So we are looking towards actually embedding data governance and controls by design. So hence why we have actually made sure that we have asked Howard to let us know when you guys are in a position where we can start building that contextual layer. And I think from the last conversation that we had with Howard. 
He indicated to us that I guess he's happy for us to give him a sort of a template or a checklist or requirements to you guys for which you can provide us with the necessary metadata information that we will need so that we can actually put that back in or catalog that innovation. 
Does it all sort of hang together now? 

 
Donguk Kang   3:22 
Yep, that makes sense. 

 
Shachi Shastry   3:24 
Perfect, okay. Osaka, anything that you would like to add? 

 
Osaka Tillakaratne   3:27 
No, you covered it. Thank you. 

 
Shachi Shastry   3:28 
Okay, perfect. 

 
Donguk Kang   3:30 
Yeah. 

 
Shachi Shastry   3:31 
A good. 
Okay. 

 
Donguk Kang   3:33 
Yeah, so given that we only have access to the asset vision for certain transport contractors, this was the initial investigation that we ran on what we have on the asset vision data. So essentially what we have is on the left hand side, this is the contract dimension that we standardized. 
And on the right hand side, the metrics is what we have on what we see, some different types of metrics that we have in asset vision tables. But then if you have a look at the metrics and also like the data completeness of each metrics, it's quite sparse. I'm not exactly sure this is what we're expected to see. That's just the first question that we sort of have. 

 
Shachi Shastry   4:11 
Rui. 
Right, okay. Yeah, look, I've not seen asset vision data so far, and I don't really know what the quality is. So I think this is where we will probably need to sort of understand your end product, what are the key data touch points, because then we will actually go ahead and start identifying what is really critical for that data product and also for the overall transport. 
use case and then start understanding how are some of those data points built and developed, what is the transformation logic that sits behind that in order for us to actually build data quality rules around some of these data points. 

 
Donguk Kang   4:52 
Yeah, that makes sense. So the way we built this data, this data completeness table was we essentially just didn't do any transformation. We just aggregated all different source tables and just was checking on data completeness for each metrics. That's essentially what we did. We didn't apply any transformation so that we probably need to understand like how they brought in. 
Uh, the transport data from a certification, I guess. 

 
Shachi Shastry   5:15 
Yeah, yeah. 
Right. And are you able to just give some context in terms of the work that has been carried out so far so that we are, we know exactly where we can actually come and partner with you guys? 

 
Donguk Kang   5:34 
Yeah, so it basically what we were trying to do was just doing the initial investigation of data completeness, and other than that, we've also built some dashboard onto on top on top of it. So, for example, like if you... 

 
Shachi Shastry   5:35 
Okay. 
Yes. 
S. 

 
Donguk Kang   5:51 
Just a Matthew. 
Basically, you can have like a map view on where each contract resides and what where each contract is locating at. And also like other than that, we can have like a days overdue by average, defect hazards. So if you go into the asset and asset level analysis, there's also like some views on like criticality. 
And yeah, but yeah, most of them seem to be like quite sparse and things like that. This is what we're trying to do eventually, but what, but we also need to build like a solid foundation before we trying to come up with like a proper dashboard or AI bringing AI capability. 

 
Shachi Shastry   6:16 
Minh. 
Bhupesh. 
Yeah, OK. 
Sorry, yeah, OK. 
I think what's probably. 
So because Howard mentioned that you guys have been speaking with various stakeholders, what are some of the things that has popped up, I think, as part of your conversations as it relates to data and the understanding of data within asset vision? 

 
Donguk Kang   7:01 
Ohh. 
Yeah, on that, Tanya, could you be able to speak on how the general interview went? 

 
Tanya Pita de Abreu   7:12 
In terms of data, mostly we haven't spoken to that many like data specific people. It's been kind of broad, like project managers and stuff, but what we're mostly being told is just like what is available in asset vision, what's not, what is available in Databricks. 
what's not. That's kind of the beginning like a pretty high level overview of just like what what do they use day to day. 

 
Shachi Shastry   7:43 
OK. 

 
Osaka Tillakaratne   7:46 
And. 
trying to get like get the whole idea. So what exactly is the deliverable from your project? And can you explain to us so that because two of us, we really haven't got the picture of what is happening. So if you can just tell us in a nutshell what exactly I are trying to do. 

 
Donguk Kang   8:02 
Yep. 

 
Osaka Tillakaratne   8:07 
and what's the process you are going to do, like, you know, what steps you are taking. Then we can tell how we can, as a data governance, how we can partner with you to help you with each stage, whatever the broad blocks or things you have in even the data culture level, or, you know, identifying what is critical, maybe some of the stuff which you are seeing may not be. 
be really critical. So I define those critical data elements and however, like, you know, what we can do. If you can tell us what you are doing, then it's easier for us to see where we fitting in this picture. 

 
Donguk Kang   8:44 
Yeah, so as I mentioned previously, what we're trying to do is trying to build like a standard data asset in a for the transport sector specifically. 
What we're given right now is only acid vision table because they mentioned that currently they're still migrating all different data sources into databricks for different contractors. Because let's say like for Sydney Harbor specifically, it doesn't sit in acid vision, it sits in Maximo. 

 
Osaka Tillakaratne   9:16 
Mm. 

 
Donguk Kang   9:17 
So yeah, we just starting from asset vision, very small subset of transport contractors, and we're going to try expanding based on that. 

 
Osaka Tillakaratne   9:27 
You are taking, sorry, I have a question. You are looking at what is in data bricks or are you looking at what is not in data bricks as well? Like, are you taking data bricks like as what is in data bricks as your source of truth or are you looking at externally what is missing, like, you know, other stuff as well? 

 
Donguk Kang   9:29 
Yeah, yeah, go ahead. 

 
Shachi Shastry   9:29 
Go, go, go. 

 
Donguk Kang   9:46 
We are also looking at what's what's missing, what's missing as well. 

 
Osaka Tillakaratne   9:51 
OK, yeah, so this is what is in Databricks, so is it considering what is this is what is in Databricks, so, so... 

 
Donguk Kang   9:57 
Yeah. 
Correct, just what's in database so far? 

 
Osaka Tillakaratne   10:01 
Yeah, and then as part of your project, you will say that in order to fill these gaps, you need to bring in these stuff in. Is that what you're going to be doing? 

 
Donguk Kang   10:14 
Partially, yes. And also we also trying to understand in different data sources for different transport sector or contractors, what are some of the fields that are available and what are some of the metrics that are available. 

 
Osaka Tillakaratne   10:24 
Minh. 

 
Shachi Shastry   10:30 
Okay. 

 
Donguk Kang   10:30 
Because we are only looking at asset vision, but we don't know how it's like for the other projects. 

 
Shachi Shastry   10:36 
So as part of this data product or this data asset, is that focusing only on asset vision or would you also be looking at maximum? 

 
Donguk Kang   10:47 
Eventually we want to try bringing in Maximo, but what we are given right now is only acid vision, so that's why we are only checking like the data completes for that. 

 
Shachi Shastry   10:54 
Haigh. 
Okay, and my second question then is, are you targeting a specific contract or this is looking at all contracts across transport? 

 
Donguk Kang   11:05 
Are all contracts across different transport? Yes, correct. 

 
Shachi Shastry   11:08 
Okay, and then my last question is, what is the outcome? So what is the data product or this data asset going to answer? So what are some of the questions that you've been asked the business or you like based on your questions or interviews that you've had with the business, what is the problem that this data asset is going to solve slash data product? 
I think that will give us a better picture. 

 
Donguk Kang   11:30 
So. 
I guess, um, some of the... Oh, sorry, go ahead, Osaka. 

 
Osaka Tillakaratne   11:32 
Yeah, I think so. 
No, no, no, that's what I was trying to say. Also, I think Shachi articulated it much better than I did. 

 
Donguk Kang   11:42 
Yeah, I said I would say we've been in interviewing different different transport managers and they said they don't have the consolidated KPI for the enterprise level, so it's still a black box on what sort of... 
KPI they are trying to answer, but we just want to, yeah. 

 
Shachi Shastry   12:02 
Okay. 
Okay, that was my next question. What was the KP? But no, that I think that's, thanks for giving an update though. I guess from what I understand, Osaka and the guys, you guys are still in the early stages and you still are sort of collating your evidences and inputs based on the conversations that you're having. 

 
Donguk Kang   12:07 
Yes, yeah. 

 
Shachi Shastry   12:28 
Now, it will be kind of helpful to understand what sort of KPIs have you come across so far. 

 
Donguk Kang   12:35 
So yeah, we do have the summary for the KPIs as well. So for example, like Oakland West or Ramsey, they are reporting at like a job and work order volume. 

 
Shachi Shastry   12:39 
Mm. 

 
Donguk Kang   12:46 
And also like the completion and these are like the list of KPIs. But the thing is, they're not only using the asset vision table, they're also bringing in like data from different sources, which we, which I believe like we haven't brought into Databricks environment. 

 
Shachi Shastry   13:01 
Yeah. 
Would you mind just enlarging this because I might actually be able to pinpoint you to the right people. Maybe KPI reporting to rd safety. So rd safety, safety related jobs. If maybe if we can just have another column because I've got questions looking at some of these as well. So. 

 
Donguk Kang   13:14 
Ryan. 

 
Osaka Tillakaratne   13:18 
The. 

 
Shachi Shastry   13:28 
Just to give you an on what exactly we are doing right, so yes, I gave you an eye level overview of what we are doing, but we are as part of the data governance or data management program, we are also piloting the safety metrics. And this is actually looking from a big pool of externally disclosed metrics. And a few of those are, so there are about 3. 

 
Donguk Kang   13:43 
Yep. 

 
Shachi Shastry   13:50 
main key metrics that we are looking at. And this is specifically targeted across the whole enterprise, across different sectors. So you've got TRIFR, which is total injury frequency rate. Then you have SIFR, 
which is the seriousness of that injury frequency rate. And then you have SAIFR, which is SAIFR, which is the serious accidental injury frequency rate. So I think what would be good is we can definitely, yeah, they'll probably, that'll be one of the overlaps if you're looking at incident KPI and incident reporting. 

 
Donguk Kang   14:22 
Yeah. 

 
Shachi Shastry   14:32 
boarding rd safety KPI. So we will be touching upon rd safety as well. 
Then what else can I tell you? Job compliance, non-compliance reporting. 
Do you have anything in relation to this is planned maintenance completion inspection schedule on time backlog? So there are some, so in the first one, job work order volume completion on time overdue. I would recommend you having a chat with Bhupesh. 

 
Donguk Kang   14:55 
Bing. 

 
Shachi Shastry   15:05 
His name is Bhupesh Balani. Yes, have you spoken to him? Perfect. Okay, because he is also one of the, he's a transport rep for finance enterprise reporting and he's done a lot of work across work order management, operational reporting, et cetera, as it relates to transport. So they might. 

 
Donguk Kang   15:07 
No, Bhupesh. Yep. 
Yeah, yeah, we have. 
Yeah. 
Yeah. 

 
Shachi Shastry   15:27 
be an overlap over there as well, but it's good to actually have an idea of what those KPIs look like and where you will actually find those overlaps because I think there should be some data that's already in Databricks that's been modeled as part of that. There are some few reports that he's already been he's worked on and one of them could also lead into project on a page as it relates to different contracts across different businesses. 

 
Donguk Kang   15:46 
Yeah. 

 
Shachi Shastry   15:52 
sector. So within transport in itself, you might actually have multiple contracts within project on a page. So that is a report. So you can check in with Bhupesh. But look, this is all based on my information that I've got. And as part of that finalized data asset, are you? 
guys working towards what a what KPI do I do does that data asset want to will actually answer or is this data asset going to actually answer many of the many of these listed KPIs? 

 
Donguk Kang   16:20 
Thank you. 
And we're not just looking at the KPR itself, but because later on when we try to bring in like an AI capability, like let's say a chat bot specifically, it doesn't, it won't only answer like the KPR related questions. I would expect it to answer like any sort of, let's say. 

 
Shachi Shastry   16:36 
Gu. 

 
Donguk Kang   16:46 
work orders or smaller questions as well. 

 
Shachi Shastry   16:49 
Got you. 
Yep. Okay. So maybe my recommendation here is probably if we can please be kept in the loop and just give us maybe a weekly update. I'll have a chat with Howard if he's happy with that. On what areas are you targeting because in relation, we are also building data products. 

 
Donguk Kang   17:10 
Yep. 

 
Shachi Shastry   17:11 
And have you heard of Alation before and what Alation does as a data governance metadata management platform? 

 
Donguk Kang   17:19 
Not really. 

 
Shachi Shastry   17:20 
Have you heard of Calibra, Informatica and those platforms? Very similar, right? Almost similar. So we are building data products that will help to answer some of those questions that you've just mentioned. So I think what would be important for us is to make sure that whilst you are actually designing 

 
Donguk Kang   17:22 
Yeah, yeah, we have. Okay, yeah. 
Right. 

 
Shachi Shastry   17:41 
your data asset and while circulating, we are kept informed so that when it comes to us having to configure that on Alation, we know exactly what needs to be curated. 

 
Donguk Kang   17:54 
Yep, makes sense. 

 
Shachi Shastry   17:58 
Do you think Osaka? 

 
Osaka Tillakaratne   18:00 
Yes, but I'm thinking, Shachi, whether there's anything we can help them out. Yeah, like, you know, when they are doing. 

 
Shachi Shastry   18:06 
this point in time. 
It's very early stages. 

 
Osaka Tillakaratne   18:11 
Yeah, very early stages, I know. Yes, there's nothing much we can send help now. 
Yes. 

 
Shachi Shastry   18:19 
I think so from if I think about the data flow, the data lineage, right? So is it just asset vision to data bricks to Power BI? Is that the flow you're looking at at the moment? 

 
Donguk Kang   18:19 
Byun. 
Right now, so basically later on we are not thinking of really using Power BI because it's just what I'm thinking is probably just going to have one consolidated table in Databricks and probably going to build maybe chatbot based on that. 
Yeah, but then the flow right now is probably acid vision to Databricks, but then we don't have the clear view of how acid vision tables are brought into Databricks, but yeah, so what we're seeing is Databricks to Databricks dashboard. 

 
Shachi Shastry   19:02 
Okay. So what we will need to do is for you to create the chat box, you'll have to link data. So we will have Alation connected to Databricks. So it's already ingested the metadata from Databricks. So all of that data will need to be that product, I mean, transport related data. People need to bring in those relevant tables into 
Alation and then based on the metadata that Alation has and you guys can build the chat bot on top of it. That's the way I'm actually seeing it work. But I think. 

 
Donguk Kang   19:28 
Yeah, OK. 
Yeah, OK. 

 
Shachi Shastry   19:35 
Um... 

 
Osaka Tillakaratne   19:37 
Just one question, Shachi. So, because they are going to be functioning within Databricks, how do we, and we have our data curation in Alation at the moment, sorry, in Alation and 

 
Shachi Shastry   19:37 
But I think... 
Yes. 

 
Osaka Tillakaratne   19:55 
They are working in Databricks, so there is no two-way conversation, two-way sync. So what is in LHN doesn't go back to Databricks. So if they're building the chatbot, how would it get access to what we are doing? That's something which we need to figure out now itself. 

 
Shachi Shastry   20:15 
Correct. So and this is a conversation that goes back to the chat with data that we had with the legend. So if you're not using that particular, probably we won't use that functionality. So if these guys are building that AI chat bot, which is going to be used across enterprise wide, then we will definitely have to bring, I agree with you, we will have to start looking at that as another functionality. 

 
Osaka Tillakaratne   20:30 
Yeah. 
Yes. 

 
Shachi Shastry   20:38 
But I think, for yes, Gaurav. 

 
Donguk Kang   20:39 
Based. 

 
Osaka Tillakaratne   20:40 
Yes. 

 
Donguk Kang   20:41 
Yeah, sorry to intervene. It wouldn't necessarily be chatbot, but chatbot is just one of the examples that I could think of because what we're trying to do is just, yeah. 

 
Shachi Shastry   20:48 
I get, I understand. 

 
Osaka Tillakaratne   20:50 
Yeah, yeah. So either way, you will need metadata, right? All these good things which Shachi is doing, identifying critical data elements, identifying, getting data glossary, ownership, all that, which we are curating in Alation, you will, it will help you to give proper answers when. 

 
Shachi Shastry   20:50 
Yeah. 

 
Donguk Kang   20:54 
Yeah, correct. 

 
Osaka Tillakaratne   21:10 
You build your data set. 

 
Donguk Kang   21:12 
Yep, yep, that makes sense. 

 
Shachi Shastry   21:14 
So maybe in terms of next steps, then, Donguk. 
What would be helpful is if you could send, so once you actually have a very clear view of the tables that you're looking at within Databricks as it relates to asset vision, could you please let us give us the visibility of those tables? Then what we will do is we've got certain templates that we would like to have them filled as it relates to metadata so that it would be at least, and to give you an example, 

 
Donguk Kang   21:27 
Yep. 

 
Shachi Shastry   21:43 
is we will collate all the business terms as it relates to this data asset. At the same time, we will also look towards identifying the critical data and assigning and defining what the definition is. Now for us to actually land on a good definition, we will need to work with you or you will need to work with the business. 
to make sure that they agree with that definition and we will need to bring other impacted parties to make sure that definition is agreed across the board so that when you then build your chat bot as an example that you mentioned as one of the outputs or the outcomes, then that definition, it uses the common definition that is agreed across the enterprise. 
So I think in terms of our actions and next steps, can we make sure that you give us a view of the tables that you're actually focusing on over the next week or two as you discuss with the business and you have your interviews with the business. 
And then what we will do is we will try and understand that, or it might be a collaborative effort between the two teams. And then my team will actually send across the template for which we will need information about that relevant data asset. So when I say data asset, it could be table schemas, attributes in our database. 

 
Donguk Kang   23:06 
Yep, that makes sense. 

 
Shachi Shastry   23:07 
Yeah, so have you guys actually landed on the specific schemas and tables at the moment in Databricks that you would be focusing on? Or is that still a bit fluid? 

 
Donguk Kang   23:18 
Still, still investigating. 

 
Shachi Shastry   23:21 
Okay, yeah. So once you guys have formalized on what your focus is on, then please keep us in touch. So would it be okay if we just had another touch base or a touch point next week, maybe on a Monday at the same time? 

 
Donguk Kang   23:22 
Yeah. 
Yep. 
Yeah, yeah, that works, that works for me. 

 
Tanya Pita de Abreu   23:40 
Yep. 

 
Osaka Tillakaratne   23:40 
Yeah. 

 
Shachi Shastry   23:41 
Yeah, cool. Do you have any questions for us? I'm sorry, we've been asking you a lot of questions instead. 

 
Donguk Kang   23:46 
Yeah, yeah, so I don't know. I was a bit lost on your role, I think. 
Um, it's a bit hard to grasp what exactly you are doing. Is there anything that you're still working on, really anything related to Databrick side, or is it just purely like data governance? 

 
Shachi Shastry   24:05 
Oh, we do everything with Databricks. Yeah, we do everything with Databricks, right? So basically what we are doing is we are providing that additional metadata contextual layer that is required for enabling AI. That is #1. And as part of building that business and contextual metadata layer, 

 
Donguk Kang   24:19 
Yep. 

 
Shachi Shastry   24:25 
We are also governing Ventia data assets. And data assets, when I say data assets, is basically Ventia data, right? It can be in any form, starting from the most granular level, from an attribute level to the table to the schema, and to the overall source of the data in itself. So we are actually governing the data. 

 
Donguk Kang   24:38 
Yep. 

 
Shachi Shastry   24:44 
as it's actually produced from that point all the way to how it actually flows and it's consumed and to the finalized point. So if you take report from for an example, we look at how the data is consumed within that report right from the point of production. We understand what the business transformation logic is. We identify what is critical. And then we also 

 
Donguk Kang   25:00 
Yes. 

 
Shachi Shastry   25:05 
build and implement data quality rules across the flow for the critical data that we've identified. And we measure and monitor the critical data and the quality of that data as well. On top of that, we also assess data risks. 

 
Donguk Kang   25:12 
Yeah. 
Yep. 

 
Shachi Shastry   25:22 
And where there are control gaps, we identify and define what that control should be for the teams to implement. Or we make sure that there are relevant controls, data risk controls, in order to bite down any data risks. So that's the role of data governance and data management in a nutshell. 

 
Donguk Kang   25:30 
Yeah. 

 
Shachi Shastry   25:40 
And what we will be doing is when there are teams developing data products, we are embedding our process. So we have a repeatable cyclic approach of how we govern and manage data. We are embedding that process into the project teams so that as part of your design build, so let's say you, I'm sure you will start. 

 
Donguk Kang   25:40 
Yeah. 

 
Shachi Shastry   26:01 
putting together a holistic view of what the data requirements are. So some of the information that you define as part of your data requirements will form a part of that metadata capture. So that's a tick for us, and we take that, put it in a catalog that in Alation as an example, right? So there's different stage gates that you guys go through from. 

 
Donguk Kang   26:05 
Yeah. 

 
Shachi Shastry   26:21 
having that requirements endorsed all the way to the build. So when you guys are developing and implementing the data product, that is when we will actually be helping you to define and implement those data quality rules. 

 
Donguk Kang   26:34 
Yeah, that makes sense. 

 
Shachi Shastry   26:35 
Yeah, so we are kind of working together and embedding the process in. 

 
Donguk Kang   26:36 
So, essentially... 
Yep, that makes sense. So essentially, it's not like... 
Outside from data bricks to data bricks, it's more like data bricks, data products, sorry, data products within the data bricks that you govern pretty much. OK. 

 
Shachi Shastry   26:53 
Yes, yes, yes, so we do end-to-end governance. 

 
Donguk Kang   26:57 
Okay, that makes sense. 

 
Osaka Tillakaratne   26:57 
Not. 

 
Shachi Shastry   26:58 
Yeah. 
starting from the source. So Asset Vision will be one of them as well. So when we catalog all of this inhalation, you will actually see a view from Asset Vision all the way to Databricks, which is a data product in Databricks. 

 
Donguk Kang   27:00 
Oh. 
Yep, that makes sense. 
Cool, I think it's pretty clear. I might stop sharing. 

 
Shachi Shastry   27:16 
Oh. 
Okay, and I think in terms of the actions, we've got those actions, that's why I've recorded this. So we will have the actions transcribed as well. So if you don't mind, I'm happy for us to schedule or happy for you to schedule the next meeting on Monday. So we just keep talking. And we are also both of us, I mean, both teams are across of what each one is doing so that, you know, we can sort of integrate at some point. 

 
Donguk Kang   27:48 
Yep, that makes sense. 

 
Shachi Shastry   27:48 
Sounds good. OK, cool. 

 
Donguk Kang   27:51 
Cool. 

 
Shachi Shastry   27:51 
Thank you for your time. 

 
Donguk Kang   27:53 
Thank you so much for sharing this offer. Thank you for your time. 

 
Osaka Tillakaratne   27:54 
Thank you. 

 
Tanya Pita de Abreu   27:54 
Thank you. 

 
Shachi Shastry   27:55 
All good, see you then. Cheers, bye. 

 
Osaka Tillakaratne   27:56 
A... 

 
Tanya Pita de Abreu   27:56 
Yeah. 

 
Donguk Kang   27:57 
See ya, bye. 

 
Osaka Tillakaratne   27:58 
Jessop. 

 
Shachi Shastry stopped transcription
