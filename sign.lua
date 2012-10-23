module(..., package.seeall)

function new()
	local sign = display.newGroup();

	local displayRow1 = display.newText("displayRow1",0,0,"Dot Matrix",35)
	local displayRow2 = display.newText("displayRow2",0,0,"Dot Matrix",22)
	displayRow1:setReferencePoint(display.TopLeftReferencePoint);
	displayRow2:setReferencePoint(display.TopLeftReferencePoint);
	displayRow1:setTextColor(255,245,71)
	displayRow2:setTextColor(255,245,71)


	sign:insert(displayRow1);
	sign:insert(displayRow2);
	displayRow2.y = 50;

	sign.update = function(row1,row2)
		displayRow1.text = row1;
		displayRow2.text = row2;

		displayRow1:setReferencePoint(display.TopLeftReferencePoint);
		displayRow2:setReferencePoint(display.TopLeftReferencePoint);
		displayRow1.x = 0;
		displayRow2.x = 0;

	end

	sign.animate = function()
	if(displayRow2.contentWidth > screen.right - screen.left) then
		displayRow2.x = displayRow2.x - 1.5;
	end

		if(displayRow2.x < -displayRow2.contentWidth) then
			displayRow2.x = screen.right;

		end
	end
	
	sign:setReferencePoint(display.CenterLeftReferencePoint);
	return sign;
end