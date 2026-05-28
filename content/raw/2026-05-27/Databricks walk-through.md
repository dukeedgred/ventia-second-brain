Databricks walk-throughsetup-20260527_120407-Meeting Recording
May 27, 2026, 2:04AM
27m 23s

Donguk Kang started transcription

Kale Skinner   0:03
direction you don't care about or not so interested, just let me know and we can resteer it.

Donguk Kang   0:05
He.
Yeah, not a problem. More details are good.

Kale Skinner   0:08
Um...
Go, I will share my screen.
I know when you guys can say that.

Donguk Kang   0:19
Yeah, I can see the screen.

Kale Skinner   0:20
All right, very high level before we jump into actual data bricks. So I guess a bit of context. So yeah, so data engineering manager, I've got a few data engineers and data scientists in my team. We sit in digital services. So we're like a centralized team that basically, I guess, responsible for the enterprise platform, which we'll go through today.
But I think it's important to note with Ventia, you know, it's don't quote me on the number, but it's like 150 different contracts. There are some overlap, but there are essentially like 150 little mini businesses sort of thing, right? That a lot of the time some have data analysts, data engineers, sort of report builders in the contract and some don't.
So we're not so much responsible for the reporting part. That's the business's responsibility. But I guess the key call that is.
Even though we've centralized and got a vast majority of enterprise data within our platform, there is still the vast majority of reporting happening off people's Excel files and off SharePoint sitting in Excel and all these sort of like more citizen developer type solutions that are built out in the business. So more and more we're bringing people in to use our platform and to follow the right principles and processes.
But, yeah, you'll probably soon get to know Ventio. I think it's can be a bit chaotic with, you know, there's a lot of a lot happening out in the business and the contracts that doesn't we're not aware of, and they're not aware of us sort of thing. There's a lot of sort of moving parts, so I guess, yeah, so as far as the platform, very sort of high-level diagram.
Got all our different source systems.
Ingestion predominantly, we are now using Databricks in Azure. We do have more some legacy things that are using Logic Apps, and we've got patterns for Event Hub and IoT for IoT data streams and streaming data. None of them are actually in operation, but we've got the patterns there for them. And then...
Yeah, Databricks sort of sits here. We've got all this sort of capability that we use. We use Azure DevOps for our repo, and then that all sits on top of Azure ADSL Gen 2 Data Lake, where, yeah, typically we'll store the raw files from the source systems, either as native if it's coming from an Excel.
or say Parquet if it's coming from a SQL server or a more structured source. And then predominantly, Power BI is our main consumer of data. There are some scenarios where, you know, again, Databricks, you can access your data via API, and there's a few scenarios where the data goes elsewhere, but Databricks in this stack.
is predominantly built for reporting, analytics, and I guess now AI capability, AI workloads. It's not an integration layout that feeds out to all these other applications and sits in between applications, right? That's a whole other team, Adventure, or the whole different stack around that integration type scenario.
So again, very high level.
I'll just show you, I'm sure Jade will get you guys access to Confluence. I don't know if you already have, but I can share all the relevant pages so you guys can dig through this if you're really interested. But for example, if we go down to our batch pattern, which is by far our most common, this is where it goes through all our different hops and what we do in each of the hops. So say #3, you just go down to three and it explains.

Donguk Kang   3:30
Great.

Kale Skinner   3:42
You know, naming standards, what housekeeping columns we add on, and how we handle CDC, yeah, et cetera, et cetera, right? So this is more sort of for my team and for if we get data engineering consultants in to follow this sort of standard and process.
So, we've also, again, as I said, we've got a patent for near real-time processing and streaming. Again, it's there, but not heavily used. And then this, again, Confluence has got all our sort of, you know, KB articles. It's got, you know, it goes through, again, more Databricks naming conventions and how we break out the different sectors by catalogs.
And you guys predominantly are working in on the transport sector, right? To begin with, is that right?

Donguk Kang   4:27
Yep, that's correct.

Kale Skinner   4:28
Yeah, cool. Um, so...
Yeah, and then so just out of the box data, so...
Top recommendations. So any further questions on that before I actually jump into Databricks?

Donguk Kang   4:44
Not really relevant to our work, but I'm just wondering like how you mentioned that small business also consumes the data. Do you give access to the Databricks environment so they can consume it or are they just accessing directly from Power BI report?

Kale Skinner   4:58
Yeah, so a whole combination. So typically, the more power users or report builders will get access to data bricks, and some of them own their own, like own their own schema, and they'll build out their own views and their own, you know, content in data bricks. We though are then the gatekeeper between what goes from dev to production, so...
developers, sort of citizen developers are allowed to build out in POC or whatever they want in dev. And then my team will peer review it and migrate it up into production. So then, yeah, for automated reports, et cetera. But Pranav Kumar, one of the guys in transport, who's like our main point of contact when it comes to sort of operational type data, work management data, asset data.
He'll be a key person that you guys can work with to really understand how transport is using the data. My team and I can explain how we process it all, how we get it ready for them to then consume it, but by no means are we across what are their key KPIs.
what is the business value out of their report, you know, that whole sort of business type side of things, you'll get that knowledge from the people out in the contract who are actually working with the client and using all these data assets. Did that answer your question?

Donguk Kang   6:12
Yeah, yeah, of course. OK.

Kale Skinner   6:12
Yeah, yeah, and then, like I said, a lot of them are power users, like Pranav, etc. A lot of them, they will like, you know, use Databricks or build out views, etc., and then they might build that semantic model in Power BI or data flows that connect to Databricks, and then get other report builders just to connect to Power, you know, use Power BI to build additional reporting, and then they've obviously got their real...
You know, report users who don't even touch Databricks, probably don't even know Databricks is behind it, and they're just viewing the report.
So...
I guess before I jump into Databricks, what like the way we've set it up is in my team, I think we've got, we'll jump across. So this is then a very simple Databricks dashboard. It's a data dictionary. We're in the process of setting up Alation, but that's still a while off as far as a full sort of data cataloguing and data governance type tool. So we've just got.
something in Databricks at least to help our users. But if we go down here to source systems, so we've got just over 60 source systems now in production and a few now still in dev that we moved across shortly. But as you can see, these external ones, there's a lot of them. And what they are, they're federated queries. So we don't actually pull that data into Databricks, but we do a federated connection down to the actual underlying
Source database, and then queries pass through data bricks down to the source. We do that for scenarios like, say, eRoads, which is all our IVMS (in-vehicle monitoring system) data that's on all the vehicles that tracks where they're going, if people are speeding, if people do hard brakes.
So E-Roads collects that data and provides that data to us, and they provide that data to us as already modeled in a Snowflake instance. So it doesn't make sense. We do have some scenarios, but it doesn't make sense for us to stage all their model data again, and then us model it again through the Medallion architecture. Instead, we just connect down to their reporting layer.
in Snowflake, right, and the queries pass through. Whereas other source systems, you know, we don't have model data and we're more pulling across raw tables, staging it, transforming it, and then modeling it up to gold. Does that make sense? So again, we have many federated queries and then these ones in staged.
These are all our ones that we are actually staging it in our bronze, and then we handle all the processing and modeling up to up to the gold layer.
So...
This is our sort of where we flag data steward SME for the different sources and schemas. So, you know, again, if you're interested in transport, this is the place where you find who the person in transport that sort of is the data steward for the data in that in that catalog.
And then I'll just general search for, you know, search for tables, et cetera, but...
So as far as like how we do all our orchestration and how we do all our processing of data through the different layers, we don't use DBT, we don't use Airflow, we don't use any external sources. Essentially it's all done in Databricks, jobs and pipelines. We've got a pipeline.
Parameters table where is your framework pipeline parameters table, which stores all our metadata. So, basically, what our jobs do is our jobs first hit that table, fetch all the metadata for the use case, and then use that metadata through standard notebooks we've got to.
load and stage the data across. So then it's very easy for us to bring in new source types. So say we've got an API to system X and now we've got API to system Y. It's very easy for us to just use the same patterns, pump in all the pipeline parameter information, and then it can automatically connect through, etc.
For some of our more complex source systems like SAP and another one called Novus, where there's hundreds of tables, what we do is we actually dynamically build out our notebooks and pipelines from the metadata. So we have an initialization job which builds out the ETL jobs from the metadata.
That way, if we need to onboard another 10 tables, 100 tables, we're just populated in the metadata. For SAP, for example, we don't manually do that. We hit the information schema of SAP HANA. It populates the pipeline parameters table. And then our job, when it initializes, sees all that and dynamically builds out all the ETL jobs.
to build all that, to do all the orchestration. Does that make sense?

Donguk Kang   10:49
Yep, that makes sense so far. It's nothing really related to what we're going to do, but just a quick question. No, no, no, no, no, no, no, I'm just, I just wanted to clarify something like if there's, what if there's a bit of like a schema drift happening in the upstream? Like how do you catch that?

Kale Skinner   10:55
Oh, it's not. Okay, so yeah, what are you guys doing? Yeah.
Yep, so with Databricks, you've got scan revolution, which is an out-of-the-box feature. So, if it's a new column, it'll automatically add that. If it's a deleted column or a change, it won't, and then, yeah, then there'll probably be alerts and issues, etc. We've got monitoring on all the different jobs.

Donguk Kang   11:08
Yep.

Kale Skinner   11:24
Um...
But honestly, it's pretty rare that happens. The only time it really does happen is new additions, so new columns, etc.
Some of our form-based source systems, which allows users to customize forms, and then there's different versions of forms and form submissions, they can be a bit of a nightmare, just because again, people just willy-nilly change them and there's not strict governance around it, but stuff like that, we will automatically, if it detects a new form type or template.
it'll push it out to a new table. So it's almost like treats new form versions as different source tables, and then you can union them later in the modeling views.
But, yeah, so with, I guess, do you want me to go more specific to transport or?

Donguk Kang   12:12
Yes, please. Yeah, that would be great.

Kale Skinner   12:13
Yeah, okay, cool, cool. So transport.
Their main, well, they've got a whole heap of source systems, but their main source, do you know what you guys are doing in transport? Like, is it more work management, work order, asset? Is it financials? Do you know what the focus will be?

Yinlun Pan   12:31
I think at this stage is probably everything because I guess how we're planning to start is probably do a gap analysis just across everything for transport and then see where I guess it needs a bit more work.

Kale Skinner   12:40
No.
Yeah.
Mhm.

Yinlun Pan   12:48
So I guess the overview will be great, I guess, and then we can see which one to deep dive into.

Kale Skinner   12:52
Yep.
Yeah, cool. So...
All financial data at Ventia, not all financial, but the vast majority, there's always an N but at Ventia, you'll tend to know this. The vast majority of all financial data is managed in SAP within Ventia. So regardless of what sector or what contract, all their financials will be in SAP.
Whereas the transport, all their work order, asset data, work management data is not in SAP. It's in a system called Asset Vision, which is a source system.
provider that we get the data from. So for example, all the financial transport data, because that SAP that will sit in our enterprise data warehouse, it won't be, you know, you won't.
It won't be called transport, but by no means, but I can get you in touch with Bhupesh, who is the transport reporting sector lead, and he's across all the financial side and all the SAP related data for transport. But this is where, you know, like, I don't know, like accounting line item and more sort of, again, your financial type data.
You would just be using the enterprise data warehouse, and obviously filtering it to the transport-based profit centers, or even the whole, you can even just the profit centers is an eight-tier hierarchy, so I think it's level 3 is sector, so you could just, you know, filter on all transport, yeah, accounting line items, for example.
Um, whereas...
Yeah, so that's again, yeah, so, whereas again, the...
Operational type data, it is a federated query, so we actually have connection.
to a whole heap of Azure SQL. Well, it's an Azure SQL Server that sits in our cloud, and it's got elastic compute, and it's got seven different databases. Now, that sits in our cloud, but it has a synchronization with Asset Vision's cloud. So Asset Vision are responsible for pushing us data.
and it automatically replicates across into Azure SQL Server, and then from there we do the federated query. So you can see here, see how there's these six.
And then there's here, there's these seven. So we're in the process of migrating from Asset Vision, hosting the data, the reporting data, and us hosting the reporting data. So again, Pranav being operational data, he'll be the best person to talk to about the transition. At the moment, all their production reporting is off these ones.
But we're in the process of moving into these ones. So this is where, again, again, remember, this is like literally looking through the Azure SQL Server, right? Because it's just doing pass-through queries. So this is where, again, your asset tables, the seven different databases, they group the different contracts.
within transport.
Well, actually Transport Australia. There's another use case that we're in the middle of now, which is doing all the transport databases for New Zealand. They're not yet in production. And there's a whole mobilization project getting all their data, which we're in the process of as well. So to understand the whole broad remit of transport data and what's New Zealand, what's Australia, what's over here, what's there,
You definitely need to talk to Pranav Kumar so I can put his details in the chat. And then, yeah, he's the person that we work with to make sure that we get in the data in. And then like I said, he'll go down to say transport.
And then these are the schemas he and the broader transport sector own, and they can then come in here and build out all specific views that they need unique to their contract. So this AKLW, BAC, Final District, they're all the names of contracts. Okay.
So...
Yeah, so again, you know, there's also a common transport. So if there's a view that they'll all share, say, for example, purchase order, this is some of the SAP data that Bhupesh is pulling from the EWG, but into his own schema, so they can do additional transformation on top of. Whereas, like I said, unique reporting requirements for the
different contracts will be in their own respective schema. Does that sort of make sense?
Yeah. Again, they'll come in here in dev, they'll literally create views, they may create tables, they may set up simple jobs that upload, you know, that update the tables. But then again, they'll come to my team before we migrate it into Databricks prod, and then they set up all their automated reporting off top of it. So I guess they're sort of free to do what they want, but then my team again does do a peer review.
And yeah, and then handles all the CI/CD, which is pretty limited, but backing up the code and all that to our repo before it goes across to prod. So then if there are any issues, again, it's very easy for us to roll back, yeah, roll back to a previous version.

Donguk Kang   18:01
Yeah, just a quick question on that. Sounds like everything is sort of like modularized, but then there's no like standardized master table that's built for like transport assets.

Kale Skinner   18:16
No, because again, like if you say, yeah, transport, I don't know how many, maybe it's like, I'm just guessing, but like 20 or 30 contracts, they may use all different source systems, they may all use different assets. Some might be around tunnels, some might be around roads, some might be about easements. And no, again, it's probably a Pranav question, but no, there's no

Donguk Kang   18:27
Yeah.
Yeah.

Kale Skinner   18:38
that I'm aware of, there's no like asset data product where they've brang in data from all the different transport related asset type databases into a centralized asset type table that I'm aware of.
And the challenge, again, this is just from my opinion.
Pranav is good because he's across all the different transport contracts. Whereas when you talk to the people in the contract, they're really interested in their contract, right? Like they might not even know what's happening at another contract. They might not even know the source system that the New Zealand guys are using. Like it's not important to them, right? They're doing their job for their contract. So I think the challenge will be is getting the right people involved to make sure that...
Yeah, you, that's the goal to build out like an asset data product that everyone can actually use and benefit from, and if they're all using and defining an asset as a different thing and they've all got different metadata besides the asset, it's about getting that shared, you know, consensus of what is an asset and how we, you know, what do we need to record against an asset?
Yeah, yeah, I mean, is the truck an asset or is every part of the truck the asset? Or is the thing the truck is working on, is that the asset? Do you know what I mean? Like, maybe Pranav again would probably have a better understanding of them definitions and how the transport, yeah, uses and I guess.
contextualizes the 10 assets, say. But I know just giving experience from other sectors and it's always been a bit of a challenge because they all do their own thing.
Um...
Um...
No.

Donguk Kang   20:13
From long-term perspective, would it be better to have like a centralized view? Um, just...
So they are probably like enterprise consumer can use it as a.
Centralized UU.
Instead of like, um, just just specific band all using it.

Kale Skinner   20:33
Um...

Yinlun Pan   20:33
I guess, sorry.

Kale Skinner   20:35
Sarah.

Yinlun Pan   20:37
No, sorry, we probably shouldn't have jumped in, but I guess that's the challenge now the organization is facing, right? It's not about if the data is, if the data is flow through at a standardized level, it's about, I guess the problem is data capturing.

Kale Skinner   20:53
Uh...

Yinlun Pan   20:53
Like, there's not much, not all of the assets have been captured, and not to mention, I guess, being standardized. Is that...

Kale Skinner   21:00
Yeah, that's right. Yeah. Yeah, assets are many different source systems, and even in the same source systems, they're not standardized at all. Yeah, one contract, you may, again, they define an asset different than another contract. And, you know, you might, not that this isn't valuable, but you might do all this work where you bring in all the assets into a common asset data product,

Donguk Kang   21:08
Yep.

Kale Skinner   21:22
And then each contractor is just going to pull out all their own assets anyway. So like for them, it's like, what was the point? Like we were already getting our asset information. Do you know what I mean? So I understand that there's, you know, value add and you know, maybe you can come up with a model that helps one that'll help them all and there's all that cross-sell opportunity. But just be mindful that people in the contracts, they just care about their reporting.
You know what I mean? So again, I think it's great Jade is getting this transport. I think she's already started like a transport working group that's got a lot of the good SMEs out in the business in transport. And they will be keen to get knowledge share and that. But yeah, I guess it's, yeah.
Yeah, it's getting them all on the same page, I guess, and getting some standardization and then pushing that down to, well, maybe not all the transport, ideally, but definitely the subset that they need value from it.
Yeah, but like I said, I'll pop Pranav details in the chat and I'll put Bhupesh who's, and then it's probably definitely worth talking to them, just don't get their opinion, because again, this is just my view of it and I don't sit in the contracts, right? I sit in the centralized team. So if they need data, they'll come to me and I'll talk to the source system owners and then I'll get the data in here so then they can consume it.
But by all means, they're the ones that are then using it. Yep.

Donguk Kang   22:39
Another question is relating to the geospatial data. Do we have that by any chance?

Kale Skinner   22:42
Bhupesh.
Um...
We have, we have ESRI at Ventia and that's managed by a separate team. I don't know if they're also in digital services. I can give you the name of the person who's the like the SME or the guru of the ESRI and GIS type data. I don't know if that also includes GIS data for the transport sector.
Um...
Or whether it's been more funneled into, say, like defence or SI, one of the other sectors.
We do have a connection to the, there's a Postgres database that sits in behind Esri, so we do have a connection to that, so we can pull their data across into Databricks, that's no issue. But we've only done it for various bespoke use cases. So if they do have all the transport type GIS data and we want to get that into Databricks, it's easy for us to do that.
Um, but I guess that had that that requirement hasn't come through yet, um...
Again, though, double check with Pranav and Bhupesh. Maybe they do use GIS data, but not from Venteers. They use it from somewhere else. So they've got maybe a transport provider who does all their GIS for them and then they get the data that way.
Yeah.

Donguk Kang   23:58
Yep, that makes sense. I think we only have two minutes left, but regarding the Databricks access, I raised it with and I attached a screenshot of how was the email saying that I'm approve access. So it'd be good if we all can have access to Databricks and also you said...

Kale Skinner   24:04
Mhm.
Yep.
Perfect.
Yep.
Yep.

Donguk Kang   24:17
To access the databricks environment, we need VPN connected to our laptop. Is that something to do with IT? I just need to let them know that.

Kale Skinner   24:21
Yep.
Yeah, you need to raise a service ticket and request the 40 client, or is it 40 client VPN?
It may, your laptop may have come with it. I don't think it does by default though. I'll send you a screenshot of it so you can see it if you want.
Listen.
I sent you a screenshot of my no one's running at the moment.
And you'll see at the top, yeah, 40 clients. I'm trying to think why we've just got a minute or two, unless you guys have any other questions. I know there are some other transport-specific type data sources we've got as well, but again, profession would be better across how they're using them.

Yinlun Pan   25:03
Ohh yeah.
Sim.

Kale Skinner   25:19
But like black line, I think we have, which is, I think that's more financial data.
Yeah, there's a few other.
But the asset visions, again, the asset and sort of work management one, and then SAP is more the financial.

Donguk Kang   25:40
Yeah, well, it would be good if we can have a list of people who we can reach out to and we'll talk to them. Not sure if they have confluence page like this, just documenting everything, all the table names and also with the description.

Kale Skinner   25:46
Yeah, I can provide that.
We, again, we do have like a get the catalog level, but it'll be dependent on if they would have added that in on their schemers in the transport sector. The other thing we do have in Databrick, so I'll quickly mention, is we do have like all safety data. So obviously transport has safety instance, right? So we do have all that, all compliance data. So if they're, you know, their trading can go out and do a certain job, we've got all that.

Donguk Kang   26:01
Yeah.
Okay.

Kale Skinner   26:18
compliance, so all that sort of enterprise type data, we typically, we've got the vast majority of it in Databricks.
Yeah, it's more the, again, like formatize for SRAP C, that's one of the Sydney ones. That's like form-based data just for that contract. We've got that. So we've got a lot of little bits and pieces that the contracts have requested. But again, I'm sure there's probably a lot that we still don't have, and that's probably, again, the discussions with Pranav to understand if it's needed, maybe it's not needed, and that's why I haven't requested it.
Um...
Cool. Sorry guys, I know it's been a bit of a turbo. But we can have, feel free to set up additional sessions if you want to clarify anything. But we'll get you guys access, make sure you guys can connect in. There's Databricks training as well, which you can jump in and do if you guys are interested. And then we'll just go from there. Hey, if you have any additional questions, reach out and we can go through it.

Yinlun Pan   26:49
Mm.
Okay, that's all.

Donguk Kang   26:53
No, this was really helpful.
Yeah.

Yinlun Pan   27:00
Mm.
Mm.
Lu.
Yeah.
Pounds good.

Kale Skinner   27:08
And I'll send you, I'll pop all the names to the people I referred to in the chat as well, so you can reach out to them.

Yinlun Pan   27:13
Sim.
Amazing. Thank you so much for your time.

Donguk Kang   27:14
Thank you very much.

Tanya Pita de Abreu   27:16
Thank you.

Kale Skinner   27:16
Go.
No worries, guys.

Donguk Kang   27:18
As we hope.

Kale Skinner   27:19
Thanks, guys. Bye.

Donguk Kang   27:21
Yeah, talking soon.

Tanya Pita de Abreu   27:21
Thank you.

Yinlun Pan   27:21
Thank you, bye.

Donguk Kang stopped transcription
