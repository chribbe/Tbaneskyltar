module(..., package.seeall)

function new()
	local menu = display.newGroup();
	menu.selectCallback = nil;
	local back = display.newRect(0,0,610,30)
	back:setFillColor(255,245,71)
	menu:insert(back);

	local info = display.newImageRect("assets/info.png",18,18)
	info.x = screen.right - 15;
	info.y = 15;
	menu:insert(info)


	local lbl1 = display.newText("Midsommarkransen",0,0,"Helvetica-Bold",20);
	lbl1:setTextColor(0)
	local lbl2 = display.newText("Telefonplan",0,0,"Helvetica-Bold",14);
	lbl2:setTextColor(0)
	local lbl3 = display.newText("Örnsberg",0,0,"Helvetica-Bold",14);
	lbl3:setTextColor(0)

	local lbl4 = display.newText("Örnsberg",0,0,"Helvetica-Bold",14);
	lbl4:setTextColor(0)
	menu:insert(lbl1);
	menu:insert(lbl2);
	menu:insert(lbl3);
	menu:insert(lbl4);

	menu.hideTimer = nil;

	menu.hide = function()
		transition.to(menu,{time=200,y=screen.top - 30})
	end

	menu.show = function()
		transition.to(menu,{time=100,y=screen.top })
	--	print("oooo")
		if(menu.hideTimer) then
			timer.cancel(menu.hideTimer);
		end

		menu.hideTimer = timer.performWithDelay(3000,menu.hide)

	end
	menu.update = function(station1,station2,station3,station4,selected)
	
	if(station1) then lbl1.station = station1; end
	if(station2) then lbl2.station = station2; end
	if(station3) then lbl3.station = station3; end
	if(station4) then lbl4.station = station4; end

	lbl1.text = lbl1.station.name;
	lbl2.text = lbl2.station.name;
	lbl3.text = lbl3.station.name;
	lbl4.text = lbl4.station.name;

		lbl2.size = 22;
		lbl1.size = 22;
		lbl3.size = 22;
		lbl4.size = 22;



	if(lbl1.station.selected) then lbl1.size = 38; end
	if(lbl2.station.selected) then lbl2.size = 38; end
	if(lbl3.station.selected) then lbl3.size = 38; end
	if(lbl4.station.selected) then lbl4.size = 38; end


	menu.layout();
	end


	menu.layout = function()

	lbl1:setReferencePoint(display.CenterLeftReferencePoint)
	lbl2:setReferencePoint(display.CenterLeftReferencePoint)
	lbl3:setReferencePoint(display.CenterLeftReferencePoint)
	lbl4:setReferencePoint(display.CenterLeftReferencePoint)

	lbl1.x = 0 +   10;
	lbl2.x = lbl1.x + lbl1.contentWidth + 10;
	lbl3.x = lbl2.x +  lbl2.contentWidth + 10
	lbl4.x = lbl3.x +  lbl3.contentWidth + 10
	lbl1.y = 15 
	lbl2.y = 15
	lbl3.y = 15
	lbl4.y = 15
	end	

	local function select(event)
		--print(event.target.station)
		print(event.x)
		local station = nil;
		if(event.x - screen.left > lbl1.x and event.x -screen.left< lbl2.x) then station = lbl1.station; end
		if(event.x - screen.left > lbl2.x and event.x -screen.left< lbl3.x) then station = lbl2.station; end
		if(event.x - screen.left > lbl3.x and event.x -screen.left < lbl4.x) then station = lbl3.station; end
		if(event.x -screen.left> lbl4.x and event.x - screen.left < lbl4.x + lbl4.contentWidth) then station = lbl4.station; end



		if(menu.selectCallback) then
			menu.selectCallback(station);
			menu.update();
		end
	end

	menu:addEventListener("tap",select);
	

	menu.y = screen.top - 30;
	menu.x = screen.left;
	return menu;
end