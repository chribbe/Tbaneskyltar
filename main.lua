
local director = require("director")

system.activate("multitouch")

local mainGroup = display.newGroup()
display.setStatusBar(display.HiddenStatusBar);	
 
needsUpdate = true;
userStation = nil;
currentStation = nil;
-- get the usable coordinates for the device
screen = 
{
	left = display.screenOriginX,
	top = display.screenOriginY,
	right = display.contentWidth - display.screenOriginX*2,
	bottom = display.contentHeight - display.screenOriginY
};

-- TELEFONPLAN KONTORET
-- 59.2984995379
-- 17.99126573538
stations ={}
stations[1] = {name="Alby",id="9282",lat=59.239508,long=17.845573}
stations[2] = {name="Aspudden", id="9293",lat=59.306453,long=18.001528}; 
stations[3] = {name="Axelsberg", id="9291",lat=59.30435,long=17.975392}; 
stations[4] = {name="Bergshamra", id="9202",lat=59.381551,long=18.03659}; 
stations[5] = {name="Bredäng", id="9289",lat=59.294906,long=17.933764}; 
stations[6] = {name="Dandyryds sjukhus", id="9201",lat=59.39191,long=18.04131}; 
stations[7] = {name="Fittja", id="9283",lat=59.247453,long=17.86098}; 
stations[8] = {name="Fruängen", id="9260",lat=59.285811,long=17.964964}; 
stations[9] = {name="Gamla stan", id="9193",lat=59.323294,long=18.067059}; 
stations[10] = {name="Gärdet", id="9221",lat=59.34667,long=17.825618}; 
stations[11] = {name="Hallunda", id="9281",lat=59.243239,long=18.001528}; 
stations[12] = {name="Hornstull", id="9295",lat=59.315871,long=18.033886}; 
stations[13] = {name="Hägerstensåsen", id="9262",lat=59.295607,long=17.979125}; 
stations[14] = {name="Karlaplan", id="9222",lat=59.338836,long=18.090835}; 
stations[15] = {name="Liljeholmen", id="9294",lat=59.310746,long=18.022814}; 
stations[16] = {name="Mariatorget", id="9297",lat=59.316977,long=18.063326}; 
stations[17] = {name="Midsommarkransen", id="9264",lat=59.306453,long=18.001528}; 
stations[18] = {name="Mälarhöjden", id="9290",lat=59.300932,long= 17.957282}; 
stations[19] = {name="Mörby centrum", id="9200",lat=59.398727,long=18.036203}; 
stations[20] = {name="Norsborg", id="9280",lat=59.243832,long=17.814417}; 
stations[21] = {name="Ropsten", id="9220",lat=59.357324,long=18.102121}; 
stations[22] = {name="Skärholmen", id="9287",lat=59.277174,long=18.001528}; 
stations[23] = {name="Slussen", id="9192",lat=59.319528,long=18.072295}; 
stations[24] = {name="Stadion", id="9205",lat=59.342994,long=18.081779}; 
stations[25] = {name="Sätra", id="9288",lat=59.285022,long=17.921362}; 
stations[26] = {name="T-Centralen", id="9001",lat=59.330792,long=18.063088}; 
stations[27] = {name="Tekniska Högskolan", id="9204",lat=59.34585,long=18.071694}; 
stations[28] = {name="Telefonplan", id="9263",lat=59.298324,long=17.997193}; 
stations[29] = {name="Universitetet", id="9203",lat=59.365526,long=18.054872}; 
stations[30] = {name="Vårberg", id="9286",lat=59.275968,long=17.89012}; 
stations[31] = {name="Vårby gård", id="9285",lat=59.306453,long=17.884369}; 
stations[32] = {name="Västertorp", id="9261",lat=59.291444,long=17.966638}; 
stations[33] = {name="Zinkensdamm", id="9296",lat=59.31782,long=18.050065}; 
stations[34] = {name="Örnsberg", id="9292",lat=59.305555,long=17.989168}; 
stations[35] = {name="Östermalmstorg", id="9206",lat=59.334962,long=18.074012}; 


longitude = 0;
latitude = 0;


-- function to listen for system events
local function onSystemEvent( event ) 
    if event.type == "applicationStart" then
      	userStation = nil;
      	if(userStation) then userStation.selected = false; end

      	needsUpdate = true;
        return true
    end
end
Runtime:addEventListener( "system", onSystemEvent )

local function main()
mainGroup:insert(director.directorView)
--director:changeScene(c_pong.new(), "play", "fade" )
director:changeScene("mainview", "fade" )

end


main();