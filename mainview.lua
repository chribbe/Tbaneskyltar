module(..., package.seeall)


-- Main function - MUST return a display.newGroup()
function new()
    
local mime = require("mime")
local json = require("json")
local sign = require("sign")
local menu = require("menu")

local localGroup = display.newGroup()
local signs = {};
local loadTimer = nil;

-- API-key:4ecb1b6cbef818285e382fdf363177f1
 
  local back = display.newImageRect("assets/back.jpg",610,420);
  localGroup:insert(back);
  back.x = display.contentCenterX;
  back.y = display.contentCenterY;
  back.alpha = .5;
 local lblStation = display.newText("T - centralen",0,0,"Helvetica-Bold",20)
  lblStation:setTextColor(255,245,71)

 lblStation.y = screen.top + 12 ;
 lblStation:setReferencePoint(display.CenterLeftReferencePoint)
  lblStation.x = screen.left + 5;
  lblStation.isVisible=false
 lblStation.alpha = 1;
-- lblStation.blendMode = "add"
 --lblStation.y = screen.bottom - 20
 localGroup:insert(lblStation)


  local loader = display.newImageRect("assets/loader.png",20,20);
  loader.x = screen.right - 15;
  loader.y = screen.bottom - 15;
  loader:setFillColor(255,241,71)


   local topMenu = menu.new();
  localGroup:insert(topMenu)



local function flagForReload()
    needsUpdate = true;
  end

  local function loginCallback(event)
    loader.isVisible = false;

    loadTimer = timer.performWithDelay(10000,flagForReload)


    local count = 0;
        if ( event.isError ) then
            print( "Network error!")
            needsUpdate = true;

            count = 0;
        else
              lblStation.text = currentStation.name;
              lblStation.isVisible = true;

            local data = json.decode(event.response)
            -- do with data what you want...
            if(data == nil) then lblStation.text = event.response;  lblStation:setReferencePoint(display.CenterLeftReferencePoint)
  lblStation.x = screen.left + 5; return
  end
            if(#data.Departure.Metros.Metro == 0) then
            for key,value in pairs(data.Departure.Metros) do
                print(value);

                if(signs[1] == nil and count < 2 ) then
                  signs[1] = sign.new();
                  signs[1].update(value.DisplayRow1,value.DisplayRow2)
                  localGroup:insert(signs[1])
                elseif(signs[1] ~= nil and count < 2) then
                  signs[1].update(value.DisplayRow1,value.DisplayRow2)

                end

                 --signs[key].isVisible = false;
                count = count +1;
            end
          end


          if(#data.Departure.Metros.Metro > 1) then
            for key,value in pairs(data.Departure.Metros.Metro) do
                print(value);

                if(signs[key] == nil and count < 2 ) then
                  signs[key] = sign.new();
                  signs[key].update(value.DisplayRow1,value.DisplayRow2)
                  localGroup:insert(signs[key])
                elseif(signs[key] ~= nil and count < 3) then
                  signs[key].update(value.DisplayRow1,value.DisplayRow2)

                end

                 --signs[key].isVisible = false;
                count = count +1;
            end
          end
                --count = 2

        end

          print("COUNT: " .. count)
   
          if(count == 1) then
              signs[1].x = screen.left + 20;
              signs[1].y = display.contentCenterY;

              signs[1].isVisible = true;
              if(signs[2]) then
              signs[2].isVisible = false;
              end
            end 

        if(count > 1) then
              signs[1].x = screen.left + 20;
              signs[1].y = display.contentCenterY - 60 ; 

              signs[2].x = screen.left + 20;
              signs[2].y = display.contentCenterY + 60 ;

              signs[1].isVisible = true;
              signs[2].isVisible = true;

       
        end 



        return true
    end
local lastLoadedStation = nil;
  local function loadData(station)
    if(loadTimer) then
    timer.cancel(loadTimer)
  end
    if(lastLoadedStation ~= station) then
       if(signs[1]) then signs[1].isVisible = false; end;
    if(signs[2]) then signs[2].isVisible = false; end;

    end

    lastLoadedStation = station;
    loader.isVisible = true;
      local URL = "https://api.trafiklab.se/sl/realtid/GetDepartures.json?siteId=".. station.id .. "&key=4ecb1b6cbef818285e382fdf363177f1" 
      network.request( URL, "GET", loginCallback );
      print("loading")
  end

  local function getDist(p1,p2)
    local dx = p1.x-p2.x;
    local dy = p1.y-p2.y;
     
    return math.sqrt(dx * dx + dy * dy);
  end

  local function findClosestStation(pos)

    if(needsUpdate == false) then return end;
      needsUpdate = false;
     -- local pos = {x=59.2,y=17.2};
      local minDist = 10000;
      local station = nil;
         for key,value in pairs(stations) do
            local dist = getDist(pos,{x=value["lat"],y=value["long"]});
            value.dist = dist;
            value.selected = false;
            if(dist < minDist) then
              minDist = dist;
              station = value;
            end
         end

         local function comp(a,b)
            if(a.dist < b.dist) then
              return a.dist
           end
        end
        table.sort(stations , comp)

      
      print(station.name)
      if(currentStation ~= station) then topMenu.show(); end      
      currentStation = station;

      loadData(station)
      station.selected = true;
      topMenu.update(stations[1],stations[2],stations[3],stations[4],1)
      print(stations[1].name)
      print(stations[2].name)
      print(stations[3].name)
      print(stations[4].name)
      print(stations[5].name)
  end
  
local locationHandler = function( event )
  -- Check for error (user may have turned off Location Services)
  if event.errorCode then
    native.showAlert( "GPS Location Error", event.errorMessage, {"OK"} )
    print( "Location error: " .. tostring( event.errorMessage ) )
  else
    if(needsUpdate == true) then
  --   native.showAlert("GPS","LAT:" .. event.latitude .. " LONG:" .. event.longitude ,{"OK"} )
end

findClosestStation({x=59.2984995379,y=17.99126573538});
 -- findClosestStation({x=event.latitude,y=event.longitude});

  end
end

local function menuSelectStation(station)
 if(station) then
  userStation = station;
end
  if(userStation and userStation ~= currentStation) then
    currentStation.selected = false;
    currentStation = userStation;
    userStation.selected = true;
   
    loadData(userStation);
  end
end

 -- loadData();

  unloadMe = function()
  end

  local function update()
      for key,value in pairs(signs) do
        value.animate()
      end

      loader.rotation = loader.rotation +5;
  end

  topMenu.selectCallback = menuSelectStation;
  Runtime:addEventListener("touch",topMenu.show)
  Runtime:addEventListener("enterFrame",update)
  Runtime:addEventListener( "location", locationHandler )
  -- MUST return a display.newGroup()
  return localGroup
end

