-- Databricks SQL
-- Static manual mapping from Asset Vision dbo.asset.AssetType to:
--   1. standardised_asset_type_name - cleaner canonical label for reporting
--   2. asset_subcategory              - more granular analytical grouping
--   3. asset_category                 - higher-level analytical grouping
--
-- This is intentionally not a CASE expression. Each source AssetType is mapped
-- row by row so the mapping can be reviewed and edited directly.

CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.asset_vision_asset_type_category_map
USING DELTA
AS
WITH manual_mapping AS (
SELECT
    asset_type,
    standardised_asset_type_name,
    asset_subcategory,
    asset_category,
    'manual_asset_type_mapping_v5' AS mapping_method,
    CAST(NULL AS STRING) AS manual_review_notes
FROM VALUES
    ('AED - Linear Assets', 'AED Linear Asset', 'AED Spatial Assets', 'Road Network / Geometry'),
    ('AED - Point Assets', 'AED Point Asset', 'AED Spatial Assets', 'Road Network / Geometry'),
    ('AED - Polygon Assets', 'AED Polygon Asset', 'AED Spatial Assets', 'Road Network / Geometry'),
    ('AP - Access Points', 'Access Point', 'Access Points', 'Footpath / Pedestrian / Access'),
    ('AWS - Advanced Warning Signs', 'Advanced Warning Sign', 'Guide / Warning Signs', 'Signs / Roadside Information'),
    ('Air Monitoring Systems', 'Air Monitoring System', 'Air Monitoring', 'Environment / Monitoring'),
    ('Airside', 'Airside', 'Carriageway / Airside Network', 'Road Network / Geometry'),
    ('Airside Drainage', 'Airside Drainage', 'Drains / Channels', 'Drainage / Stormwater'),
    ('Arrestor Bed', 'Arrestor Bed', 'Safety Ramps / Arrestor Beds', 'Barriers / Safety Devices'),
    ('Art Structure', 'Art Structure', 'Structures / Components', 'Structures / Bridges / Tunnels'),
    ('Barrier End Terminal', 'Barrier End Terminal', 'Crash Cushions / End Treatments', 'Barriers / Safety Devices'),
    ('Berms', 'Berm', 'Shoulders / Berms', 'Kerb / Channel / Road Edge'),
    ('Bid Site', 'Bid Site', 'Sites / Stockpiles', 'Third Party / Temporary / Other'),
    ('Bluetooth Beacon', 'Bluetooth Beacon', 'Bluetooth / Tolling', 'ITS / Traffic Control'),
    ('Boat Ramps', 'Boat Ramp', 'Access Ramps', 'Footpath / Pedestrian / Access'),
    ('Bridge', 'Bridge', 'Bridges', 'Structures / Bridges / Tunnels'),
    ('Bridge Size Culvert', 'Bridge-size Culvert', 'Culverts / Watercourse Crossings', 'Drainage / Stormwater'),
    ('Bridge/Major Culvert', 'Bridge or Major Culvert', 'Culverts / Watercourse Crossings', 'Drainage / Stormwater'),
    ('Bridges', 'Bridge', 'Bridges', 'Structures / Bridges / Tunnels'),
    ('Building', 'Building', 'Buildings / Depots', 'Facilities / Buildings'),
    ('Buildings', 'Building', 'Buildings / Depots', 'Facilities / Buildings'),
    ('CMS - Changeable Message Signs', 'Changeable Message Sign', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('Carparks', 'Carpark', 'Paved Areas / Parking', 'Pavement / Surfacing'),
    ('Channel', 'Channel', 'Kerb and Channel', 'Kerb / Channel / Road Edge'),
    ('Close Circuit Television', 'Closed Circuit Television', 'Cameras / CCTV', 'ITS / Traffic Control'),
    ('Communication Node', 'Communication Node', 'Communications Systems', 'Communications / Monitoring'),
    ('Compound Yard/Outer Grounds', 'Compound Yard/Outer Grounds', 'Yards / Wash Bays', 'Facilities / Buildings'),
    ('Control and Monitorings', 'Control and Monitoring System', 'Monitoring / Control Systems', 'Communications / Monitoring'),
    ('Crash Cushions', 'Crash Cushion', 'Crash Cushions / End Treatments', 'Barriers / Safety Devices'),
    ('Crossings', 'Crossing', 'Crossings', 'Footpath / Pedestrian / Access'),
    ('Culvert', 'Culvert', 'Culverts / Watercourse Crossings', 'Drainage / Stormwater'),
    ('Cycleway', 'Cycleway', 'Cycleways', 'Footpath / Pedestrian / Access'),
    ('Data Communication Systems', 'Data Communication System', 'Communications Systems', 'Communications / Monitoring'),
    ('Depot', 'Depot', 'Buildings / Depots', 'Facilities / Buildings'),
    ('Disaster recovery building', 'Disaster Recovery Building', 'Buildings / Depots', 'Facilities / Buildings'),
    ('Distribution Boards', 'Distribution Board', 'Electrical Distribution', 'Lighting / Electrical / Mechanical'),
    ('Doors and Frames', 'Door and Frame', 'Building Components', 'Facilities / Buildings'),
    ('Drainage', 'Drainage', 'Drains / Channels', 'Drainage / Stormwater'),
    ('Drainage Lines', 'Drainage Line', 'Drains / Channels', 'Drainage / Stormwater'),
    ('Drainage Systems', 'Drainage System', 'Drains / Channels', 'Drainage / Stormwater'),
    ('ESLS(VSS)', 'Electronic Speed Limit Sign', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('Electrical', 'Electrical', 'Electrical Distribution', 'Lighting / Electrical / Mechanical'),
    ('Electronic Signage Systems', 'Electronic Signage System', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('Embankment Monitoring', 'Embankment Monitoring', 'Slopes / Embankments', 'Earthworks / Geotechnical'),
    ('Embankments', 'Embankment', 'Slopes / Embankments', 'Earthworks / Geotechnical'),
    ('Feature', 'Feature', 'Geometric Features', 'Road Network / Geometry'),
    ('Feature - Old Shape Version', 'Feature - Old Shape Version', 'Geometric Features', 'Road Network / Geometry'),
    ('Fence Gates', 'Fence Gate', 'Fencing', 'Barriers / Safety Devices'),
    ('Fences', 'Fence', 'Fencing', 'Barriers / Safety Devices'),
    ('Fencing', 'Fencing', 'Fencing', 'Barriers / Safety Devices'),
    ('Fibre', 'Fibre', 'Fibre / Communications Conduits', 'Communications / Monitoring'),
    ('Field Inlet', 'Field Inlet', 'Pits / Inlets', 'Drainage / Stormwater'),
    ('Fire Detection and Suppression Systems', 'Fire Detection and Suppression System', 'Fire Systems', 'Lighting / Electrical / Mechanical'),
    ('Fire Systems', 'Fire System', 'Fire Systems', 'Lighting / Electrical / Mechanical'),
    ('Flood Route Signs', 'Flood Route Sign', 'Guide / Warning Signs', 'Signs / Roadside Information'),
    ('Footpath', 'Footpath', 'Footpaths / Pathways', 'Footpath / Pedestrian / Access'),
    ('Footpaths', 'Footpath', 'Footpaths / Pathways', 'Footpath / Pedestrian / Access'),
    ('Gantries', 'Gantry', 'Gantries', 'Structures / Bridges / Tunnels'),
    ('Gantries & VMS Signs', 'Variable Message Sign Gantry', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('Grass & Landscaping', 'Grass and Landscaping', 'Landscaping / Grass', 'Vegetation / Landscaping'),
    ('Gross Pollutant Traps', 'Gross Pollutant Trap', 'Pollution / Debris Capture', 'Drainage / Stormwater'),
    ('Guardrail', 'Guardrail', 'Safety Barriers / Guardrail', 'Barriers / Safety Devices'),
    ('Guide Signs', 'Guide Sign', 'Guide / Warning Signs', 'Signs / Roadside Information'),
    ('Guideposts', 'Guidepost', 'Guide / Warning Signs', 'Signs / Roadside Information'),
    ('Gully Pit', 'Gully Pit', 'Pits / Inlets', 'Drainage / Stormwater'),
    ('HVAC', 'HVAC', 'Mechanical / HVAC / Ventilation', 'Lighting / Electrical / Mechanical'),
    ('Help Phone', 'Help Phone', 'Emergency Phones', 'ITS / Traffic Control'),
    ('Hydraulic Treatment and Pumping Systems', 'Hydraulic Treatment and Pumping System', 'Pumps / Hydraulic Controls', 'Drainage / Stormwater'),
    ('ISLUS - Integrated Speed Limit & Lane Usage Sign', 'Integrated Speed Limit and Lane Usage Sign', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('ITS - Bluetooth Device', 'Bluetooth Device', 'Bluetooth / Tolling', 'ITS / Traffic Control'),
    ('ITS - CCTV', 'Closed Circuit Television', 'Cameras / CCTV', 'ITS / Traffic Control'),
    ('ITS - Conduits', 'ITS Conduit', 'Fibre / Communications Conduits', 'Communications / Monitoring'),
    ('ITS - Elec & Coms Pits', 'ITS Electrical and Communications Pit', 'ITS Field Infrastructure', 'ITS / Traffic Control'),
    ('ITS - Field Cabinet', 'ITS Field Cabinet', 'ITS Field Infrastructure', 'ITS / Traffic Control'),
    ('ITS - QPS Camera', 'QPS Camera', 'Cameras / CCTV', 'ITS / Traffic Control'),
    ('ITS - Road Weather Monitoring System', 'Road Weather Monitoring System', 'Traffic Monitoring / Weather', 'ITS / Traffic Control'),
    ('ITS - Switchboard', 'ITS Switchboard', 'Electrical Distribution', 'Lighting / Electrical / Mechanical'),
    ('ITS - Tolling Point', 'Tolling Point', 'Bluetooth / Tolling', 'ITS / Traffic Control'),
    ('ITS - UPS', 'Uninterruptible Power Supply', 'UPS / Generators', 'Lighting / Electrical / Mechanical'),
    ('ITS - Variable Message Sign', 'Variable Message Sign', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('ITS - Vehicle Detector and Classifier', 'Vehicle Detector and Classifier', 'Detection / Classification', 'ITS / Traffic Control'),
    ('ITS - Webcam', 'Webcam', 'Cameras / CCTV', 'ITS / Traffic Control'),
    ('Impact Absorbtion Terminals', 'Impact Absorption Terminal', 'Crash Cushions / End Treatments', 'Barriers / Safety Devices'),
    ('Kerb and Channel', 'Kerb and Channel', 'Kerb and Channel', 'Kerb / Channel / Road Edge'),
    ('Kerbs', 'Kerb', 'Kerb and Channel', 'Kerb / Channel / Road Edge'),
    ('Kurloo Monitoring points', 'Kurloo Monitoring Point', 'Monitoring / Control Systems', 'Communications / Monitoring'),
    ('Landscape Areas', 'Landscape Area', 'Landscaping / Grass', 'Vegetation / Landscaping'),
    ('Landscaping', 'Landscaping', 'Landscaping / Grass', 'Vegetation / Landscaping'),
    ('Landscaping - Design Polygons', 'Landscaping Design Polygon', 'Landscaping / Grass', 'Vegetation / Landscaping'),
    ('Lane Use Management System', 'Lane Use Management System', 'Traffic Control Systems', 'ITS / Traffic Control'),
    ('Lift Bridges', 'Lift Bridge', 'Bridges', 'Structures / Bridges / Tunnels'),
    ('Lighting', 'Lighting', 'Lighting Assets', 'Lighting / Electrical / Mechanical'),
    ('Lighting and Switching Systems', 'Lighting and Switching System', 'Lighting Assets', 'Lighting / Electrical / Mechanical'),
    ('Linemarking', 'Line Marking', 'General Line Marking', 'Line Marking / Delineation'),
    ('Linemarking Condition', 'Linemarking Condition', 'Line Marking Condition', 'Line Marking / Delineation'),
    ('Linemarking RRPMs', 'Raised Reflective Pavement Marker', 'Raised Pavement Markers', 'Line Marking / Delineation'),
    ('Linemarking Symbols', 'Line Marking Symbol', 'Symbols / School Zone Markings', 'Line Marking / Delineation'),
    ('Link Carriageway', 'Link Carriageway', 'Carriageway / Airside Network', 'Road Network / Geometry'),
    ('Litter Baskets', 'Litter Basket', 'Litter Baskets', 'Roadside Furniture / Amenities'),
    ('Low Voltage Systems', 'Low Voltage System', 'Electrical Distribution', 'Lighting / Electrical / Mechanical'),
    ('METS - Emergency Phones', 'Emergency Phone', 'Emergency Phones', 'ITS / Traffic Control'),
    ('Maintenance Tracks', 'Maintenance Track', 'Ramps / Maintenance Tracks', 'Road Network / Geometry'),
    ('Major Culvert', 'Major Culvert', 'Culverts / Watercourse Crossings', 'Drainage / Stormwater'),
    ('Major Culverts', 'Major Culvert', 'Culverts / Watercourse Crossings', 'Drainage / Stormwater'),
    ('Major Sign Structure', 'Major Sign Structure', 'Sign Structures', 'Signs / Roadside Information'),
    ('Major Sign Structures', 'Major Sign Structure', 'Sign Structures', 'Signs / Roadside Information'),
    ('Major Structure Airside', 'Airside Major Structure', 'Structures / Components', 'Structures / Bridges / Tunnels'),
    ('Major Structure Landside', 'Landside Major Structure', 'Structures / Components', 'Structures / Bridges / Tunnels'),
    ('Markings', 'Line Marking', 'General Line Marking', 'Line Marking / Delineation'),
    ('Mechanical', 'Mechanical', 'Mechanical / HVAC / Ventilation', 'Lighting / Electrical / Mechanical'),
    ('Minor Culvert', 'Minor Culvert', 'Culverts / Watercourse Crossings', 'Drainage / Stormwater'),
    ('Minor Culverts', 'Minor Culvert', 'Culverts / Watercourse Crossings', 'Drainage / Stormwater'),
    ('Minor Sign', 'Minor Sign', 'Static Signs', 'Signs / Roadside Information'),
    ('Minor Structures', 'Minor Structure', 'Structures / Components', 'Structures / Bridges / Tunnels'),
    ('Miscellaneous', 'Miscellaneous', 'Miscellaneous / Other', 'Third Party / Temporary / Other'),
    ('Motorway Network Communication System', 'Motorway Network Communication System', 'Communications Systems', 'Communications / Monitoring'),
    ('Noise Wall', 'Noise Wall', 'Walls', 'Structures / Bridges / Tunnels'),
    ('O&M Building Generator', 'Operations and Maintenance Building Generator', 'UPS / Generators', 'Lighting / Electrical / Mechanical'),
    ('O&M Fire Systems', 'Operations and Maintenance Fire System', 'Fire Systems', 'Lighting / Electrical / Mechanical'),
    ('OHDS - Over Height Detection Systems', 'Over-height Detection System', 'Detection / Classification', 'ITS / Traffic Control'),
    ('OSDS - Over Speed Detection Systems', 'Over-speed Detection System', 'Detection / Classification', 'ITS / Traffic Control'),
    ('Offroad Paved Area', 'Off-road Paved Area', 'Paved Areas / Parking', 'Pavement / Surfacing'),
    ('Open Drainage', 'Open Drainage', 'Drains / Channels', 'Drainage / Stormwater'),
    ('Operations Management Control Systems', 'Operations Management Control System', 'Monitoring / Control Systems', 'Communications / Monitoring'),
    ('Other Building Assets', 'Other Building Asset', 'Buildings / Depots', 'Facilities / Buildings'),
    ('Other Items', 'Other Item', 'Miscellaneous / Other', 'Third Party / Temporary / Other'),
    ('PCAS 100m Segments', 'PCAS 100m Segment', 'Network Segments / Sections', 'Road Network / Geometry'),
    ('PSDR Additional Areas', 'PSDR Additional Area', 'Operational Areas', 'Road Network / Geometry'),
    ('Parking', 'Parking', 'Paved Areas / Parking', 'Pavement / Surfacing'),
    ('Parking Areas', 'Parking Area', 'Paved Areas / Parking', 'Pavement / Surfacing'),
    ('Passive Fire Systems', 'Passive Fire System', 'Fire Systems', 'Lighting / Electrical / Mechanical'),
    ('Pathway', 'Pathway', 'Footpaths / Pathways', 'Footpath / Pedestrian / Access'),
    ('Pathways', 'Pathway', 'Footpaths / Pathways', 'Footpath / Pedestrian / Access'),
    ('Paved Areas', 'Paved Area', 'Paved Areas / Parking', 'Pavement / Surfacing'),
    ('Pavement', 'Pavement', 'Pavement Surface', 'Pavement / Surfacing'),
    ('Pavement Inventory', 'Pavement Inventory', 'Pavement Inventory / Condition', 'Pavement / Surfacing'),
    ('Pavement Structures', 'Pavement Structures', 'Pavement Structure / Formation', 'Pavement / Surfacing'),
    ('Pavement Surfacing', 'Pavement Surfacing', 'Pavement Surface', 'Pavement / Surfacing'),
    ('Pavements', 'Pavement', 'Pavement Surface', 'Pavement / Surfacing'),
    ('Penstock', 'Penstock', 'Pipes / Valves', 'Drainage / Stormwater'),
    ('Pipe', 'Pipe', 'Pipes / Valves', 'Drainage / Stormwater'),
    ('Pit', 'Pit', 'Pits / Inlets', 'Drainage / Stormwater'),
    ('Plant Monitoring and Control Systems', 'Plant Monitoring and Control System', 'Monitoring / Control Systems', 'Communications / Monitoring'),
    ('Portable Fire Equipment', 'Portable Fire Equipment', 'Fire Systems', 'Lighting / Electrical / Mechanical'),
    ('Public Art', 'Public Art', 'Public Art', 'Roadside Furniture / Amenities'),
    ('Pump Station', 'Pump Station', 'Pumps / Hydraulic Controls', 'Drainage / Stormwater'),
    ('RC1 - Electronic Signs', 'Electronic Sign', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('RC2 - Flasher Signs', 'Flasher Sign', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('RC3 - Electronic message signs (VMS type A)', 'Variable Message Sign Type A', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('RC4 - Electronic Regulatory Signs', 'Electronic Regulatory Sign', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('RMCS - Ramp Metering Control Signals', 'Ramp Metering Control Signal', 'Traffic Control Systems', 'ITS / Traffic Control'),
    ('RWIS - Road Weather Info Systems', 'Road Weather Information System', 'Traffic Monitoring / Weather', 'ITS / Traffic Control'),
    ('Railings', 'Railing', 'Railings', 'Barriers / Safety Devices'),
    ('Ramp', 'Ramp', 'Ramps / Maintenance Tracks', 'Road Network / Geometry'),
    ('Ramp Signal Controller', 'Ramp Signal Controller', 'Traffic Signals', 'ITS / Traffic Control'),
    ('Rest Area', 'Rest Area', 'Shelters / Rest Areas', 'Roadside Furniture / Amenities'),
    ('Retaining Wall', 'Retaining Wall', 'Walls', 'Structures / Bridges / Tunnels'),
    ('Road', 'Road', 'Road Carriageway', 'Pavement / Surfacing'),
    ('Road Barrier', 'Road Barrier', 'Safety Barriers / Guardrail', 'Barriers / Safety Devices'),
    ('Road Lighting', 'Road Lighting', 'Lighting Assets', 'Lighting / Electrical / Mechanical'),
    ('Road Shoulder', 'Road Shoulder', 'Shoulders / Berms', 'Kerb / Channel / Road Edge'),
    ('Roads', 'Road', 'Road Carriageway', 'Pavement / Surfacing'),
    ('Roads in Good Condition', 'Road in Good Condition', 'Pavement Inventory / Condition', 'Pavement / Surfacing'),
    ('Roadside Furnitures', 'Roadside Furniture', 'Roadside Furniture', 'Roadside Furniture / Amenities'),
    ('Roadside Landscaping', 'Roadside Landscaping', 'Landscaping / Grass', 'Vegetation / Landscaping'),
    ('Roughness', 'Roughness', 'Pavement Inventory / Condition', 'Pavement / Surfacing'),
    ('SW Rain Gardens', 'Stormwater Rain Garden', 'Rain Gardens', 'Drainage / Stormwater'),
    ('SZ 40 Patch', 'School Zone 40 Patch', 'Symbols / School Zone Markings', 'Line Marking / Delineation'),
    ('SZ Dragons Teeth', 'School Zone Dragons Teeth', 'Symbols / School Zone Markings', 'Line Marking / Delineation'),
    ('SZ Raised Zebra Crossing', 'School Zone Raised Zebra Crossing', 'Symbols / School Zone Markings', 'Line Marking / Delineation'),
    ('SZ Static Sign', 'School Zone Static Sign', 'School Zone Signs', 'Signs / Roadside Information'),
    ('SZAS - School Zone Signs', 'School Zone Sign', 'School Zone Signs', 'Signs / Roadside Information'),
    ('Safety Barrier', 'Safety Barrier', 'Safety Barriers / Guardrail', 'Barriers / Safety Devices'),
    ('Safety Ramp', 'Safety Ramp', 'Safety Ramps / Arrestor Beds', 'Barriers / Safety Devices'),
    ('School Zone', 'School Zone', 'School Zone Signs', 'Signs / Roadside Information'),
    ('Sections', 'Section', 'Network Segments / Sections', 'Road Network / Geometry'),
    ('Segment', 'Segment', 'Network Segments / Sections', 'Road Network / Geometry'),
    ('Segments', 'Segment', 'Network Segments / Sections', 'Road Network / Geometry'),
    ('Shelters', 'Shelter', 'Shelters / Rest Areas', 'Roadside Furniture / Amenities'),
    ('Shoulders', 'Shoulder', 'Shoulders / Berms', 'Kerb / Channel / Road Edge'),
    ('Sign', 'Sign', 'Static Signs', 'Signs / Roadside Information'),
    ('Signage', 'Sign', 'Static Signs', 'Signs / Roadside Information'),
    ('Signs', 'Sign', 'Static Signs', 'Signs / Roadside Information'),
    ('Slope', 'Slope', 'Slopes / Embankments', 'Earthworks / Geotechnical'),
    ('Spill Captures', 'Spill Capture', 'Pollution / Debris Capture', 'Drainage / Stormwater'),
    ('Stockpile Sites', 'Stockpile Site', 'Sites / Stockpiles', 'Third Party / Temporary / Other'),
    ('Storm Waters', 'Stormwater', 'Stormwater Systems / Treatment', 'Drainage / Stormwater'),
    ('Stormwater Quality Improvement', 'Stormwater Quality Improvement', 'Stormwater Systems / Treatment', 'Drainage / Stormwater'),
    ('Street & Area Lighting', 'Street and Area Lighting', 'Lighting Assets', 'Lighting / Electrical / Mechanical'),
    ('Streetlight', 'Streetlight', 'Lighting Assets', 'Lighting / Electrical / Mechanical'),
    ('Strip Map - Geometric Features', 'Strip Map Geometric Feature', 'Geometric Features', 'Road Network / Geometry'),
    ('Structural Component', 'Structural Component', 'Structures / Components', 'Structures / Bridges / Tunnels'),
    ('Structure Components', 'Structure Component', 'Structures / Components', 'Structures / Bridges / Tunnels'),
    ('Structures', 'Structure', 'Structures / Components', 'Structures / Bridges / Tunnels'),
    ('Subsoil Drain Outlets', 'Subsoil Drain Outlet', 'Drains / Channels', 'Drainage / Stormwater'),
    ('Subsoil Drains', 'Subsoil Drain', 'Drains / Channels', 'Drainage / Stormwater'),
    ('Support Structure', 'Support Structure', 'Structures / Components', 'Structures / Bridges / Tunnels'),
    ('Surfacing', 'Pavement Surfacing', 'Pavement Surface', 'Pavement / Surfacing'),
    ('Surveillance and Detection Systems', 'Surveillance and Detection System', 'Surveillance Systems', 'Communications / Monitoring'),
    ('Symbolic Pavement Marking', 'Symbolic Pavement Marking', 'Symbols / School Zone Markings', 'Line Marking / Delineation'),
    ('TCC Operation Room', 'TCC Operation Room', 'Control Rooms', 'Facilities / Buildings'),
    ('TCC Server Room', 'TCC Server Room', 'Control Rooms', 'Facilities / Buildings'),
    ('TCS (Lanterns)', 'Traffic Control Signal Lantern', 'Traffic Signals', 'ITS / Traffic Control'),
    ('TCS (Loops)', 'Traffic Control Signal Loop', 'Traffic Signals', 'ITS / Traffic Control'),
    ('TCS (Post)', 'Traffic Control Signal Post', 'Traffic Signals', 'ITS / Traffic Control'),
    ('TCS - Traffic Control Signals', 'Traffic Control Signal', 'Traffic Signals', 'ITS / Traffic Control'),
    ('TIRTL - Infra Red Traffic Logger', 'Infrared Traffic Logger', 'Detection / Classification', 'ITS / Traffic Control'),
    ('TMU - Traffic Monitoring Unit', 'Traffic Monitoring Unit', 'Detection / Classification', 'ITS / Traffic Control'),
    ('Table Drain', 'Table Drain', 'Drains / Channels', 'Drainage / Stormwater'),
    ('Table Drain (TSRC)', 'Table Drain - TSRC', 'Drains / Channels', 'Drainage / Stormwater'),
    ('Table Drain-AGAZ', 'Table Drain - AGAZ', 'Drains / Channels', 'Drainage / Stormwater'),
    ('Table Drain-GAZ', 'Table Drain - GAZ', 'Drains / Channels', 'Drainage / Stormwater'),
    ('Temporary Asset', 'Temporary Asset', 'Temporary Assets', 'Third Party / Temporary / Other'),
    ('Third Party Works (Consents)', 'Third Party Work - Consent', 'Third Party Works', 'Third Party / Temporary / Other'),
    ('Third Party Works (PWAs)', 'Third Party Work - PWA', 'Third Party Works', 'Third Party / Temporary / Other'),
    ('Tools', 'Tools', 'Tools', 'Plant / Vehicles / Equipment'),
    ('Traffic Facilities', 'Traffic Facilities', 'Traffic Control Systems', 'ITS / Traffic Control'),
    ('Traffic Management Device', 'Traffic Management Device', 'Traffic Control Systems', 'ITS / Traffic Control'),
    ('Traffic Management System', 'Traffic Management System', 'Traffic Control Systems', 'ITS / Traffic Control'),
    ('Traffic Measurement System', 'Traffic Measurement System', 'Detection / Classification', 'ITS / Traffic Control'),
    ('Traffic Signals', 'Traffic Signal', 'Traffic Signals', 'ITS / Traffic Control'),
    ('Trash Racks', 'Trash Rack', 'Pollution / Debris Capture', 'Drainage / Stormwater'),
    ('Tree', 'Tree', 'Trees', 'Vegetation / Landscaping'),
    ('Trees', 'Tree', 'Trees', 'Vegetation / Landscaping'),
    ('Trench Drain', 'Trench Drain', 'Drains / Channels', 'Drainage / Stormwater'),
    ('Tunnel Structure', 'Tunnel Structure', 'Tunnels', 'Structures / Bridges / Tunnels'),
    ('Tunnels', 'Tunnel', 'Tunnels', 'Structures / Bridges / Tunnels'),
    ('UPS and Generator Systems', 'UPS and Generator System', 'UPS / Generators', 'Lighting / Electrical / Mechanical'),
    ('Unsealed', 'Unsealed Pavement', 'Unsealed Pavement', 'Pavement / Surfacing'),
    ('VDCS - Vehicle Detection & Classification System', 'Vehicle Detection and Classification System', 'Detection / Classification', 'ITS / Traffic Control'),
    ('VMS - Variable Message Signs', 'Variable Message Sign', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('VSLS - Variable Speed Limit Signs', 'Variable Speed Limit Sign', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('Valves', 'Valve', 'Pipes / Valves', 'Drainage / Stormwater'),
    ('Variable Message Sign', 'Variable Message Sign', 'Electronic / Dynamic Signs', 'Signs / Roadside Information'),
    ('Vehicle Barriers', 'Vehicle Barrier', 'Safety Barriers / Guardrail', 'Barriers / Safety Devices'),
    ('Vehicle Crossings', 'Vehicle Crossing', 'Crossings', 'Footpath / Pedestrian / Access'),
    ('Vehicle Detection Station', 'Vehicle Detection Station', 'Detection / Classification', 'ITS / Traffic Control'),
    ('Vehicles', 'Vehicle', 'Vehicles', 'Plant / Vehicles / Equipment'),
    ('Ventilation Systems', 'Ventilation System', 'Mechanical / HVAC / Ventilation', 'Lighting / Electrical / Mechanical'),
    ('Voice Communication Systems', 'Voice Communication System', 'Communications Systems', 'Communications / Monitoring'),
    ('WIM - Weigh in Motion', 'Weigh in Motion', 'Detection / Classification', 'ITS / Traffic Control'),
    ('Warning Systems', 'Warning System', 'Monitoring / Control Systems', 'Communications / Monitoring'),
    ('Wash Bay', 'Wash Bay', 'Yards / Wash Bays', 'Facilities / Buildings'),
    ('Water Course Crossings', 'Watercourse Crossing', 'Culverts / Watercourse Crossings', 'Drainage / Stormwater'),
    ('Water Quality', 'Water Quality', 'Water Quality', 'Environment / Monitoring')
AS mapping(asset_type, standardised_asset_type_name, asset_subcategory, asset_category)
),
source_asset_types AS (
    SELECT DISTINCT COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified') AS asset_type
    FROM (
        SELECT AssetType
        FROM ext_mssql_asset_vision_ven_gen7.dbo.asset
        WHERE COALESCE(Deleted, false) = false

        UNION ALL
        SELECT AssetType
        FROM ext_mssql_asset_vision_ven_rms.dbo.asset
        WHERE COALESCE(Deleted, false) = false

        UNION ALL
        SELECT AssetType
        FROM ext_mssql_asset_vision_ven_rms_new.dbo.asset
        WHERE COALESCE(Deleted, false) = false

        UNION ALL
        SELECT AssetType
        FROM ext_mssql_asset_vision_ven_vicroads.dbo.asset
        WHERE COALESCE(Deleted, false) = false

        UNION ALL
        SELECT AssetType
        FROM ext_mssql_asset_vision_vns_gen7.dbo.asset
        WHERE COALESCE(Deleted, false) = false

        UNION ALL
        SELECT AssetType
        FROM ext_mssql_asset_vision_vnz_gen7.dbo.asset
        WHERE COALESCE(Deleted, false) = false

        UNION ALL
        SELECT AssetType
        FROM ext_mssql_asset_vision_vsm_gen7.dbo.asset
        WHERE COALESCE(Deleted, false) = false
    ) source_rows
),
all_mappings AS (
    SELECT
        asset_type,
        standardised_asset_type_name,
        asset_subcategory,
        asset_category,
        mapping_method,
        manual_review_notes
    FROM manual_mapping

    UNION ALL

    SELECT
        s.asset_type,
        s.asset_type AS standardised_asset_type_name,
        'Other / Unclassified' AS asset_subcategory,
        'Other / Unclassified' AS asset_category,
        'auto_source_asset_type_other_v1' AS mapping_method,
        'Fallback row for live source AssetType not yet manually classified.' AS manual_review_notes
    FROM source_asset_types s
    LEFT ANTI JOIN manual_mapping m
      ON LOWER(TRIM(s.asset_type)) = LOWER(TRIM(m.asset_type))
)
SELECT
    SHA2(LOWER(TRIM(asset_type)), 256) AS asset_type_category_map_id,
    asset_type,
    standardised_asset_type_name,
    asset_subcategory,
    asset_category,
    mapping_method,
    manual_review_notes,
    current_timestamp() AS created_ts,
    current_timestamp() AS updated_ts
FROM all_mappings;

SELECT
    asset_category,
    asset_subcategory,
    COUNT(*) AS distinct_asset_type_count
FROM transport_dev.integ_transport_assets.asset_vision_asset_type_category_map
GROUP BY
    asset_category,
    asset_subcategory
ORDER BY
    asset_category,
    distinct_asset_type_count DESC,
    asset_subcategory;
