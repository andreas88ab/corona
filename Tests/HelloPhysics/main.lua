-- Abstract: HelloPhysics project
--
-- Demonstrates creating phyiscs bodies
-- 
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see https://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
--	Supports Graphics 2.0
---------------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 10 )

local sky = display.newImage( "bkg_clouds.png", 160, 195 )

local ground = display.newImage( "ground.png", 160, 445 )

physics.addBody( ground, "static", { friction=1, bounce=0} )

local myGroup = display.newGroup()

--
--rectText:setTextColor( 0, 100, 0, 255 )

local scoreLabel = display.newText("Score: ", 30, 0, "Helvetica", 18 )
local score = display.newText( "0", 60, 0, "Helvetica", 18 )
local gradient = { type="gradient", color1={1,0,0}, color2={0.2,0,0}, direction="down" } 

local rect = display.newRect( myGroup, 160, -100, 70, 70 )
local rectText = display.newText( myGroup, "3", 160, -100, "Helvetica", 18 )
rect.fill = gradient


local function onObjectTouch( event )
    if ( event.phase == "began" ) then
    	local vx, vy = myGroup:getLinearVelocity()
    	if(vy > 0 and myGroup[2].rectText ~= "Crap") then
    		local num = tonumber(rectText.text)
        	text.rectText = num - 1
        	if(text.rectText == "0") then 
        	display.remove(myGroup)
        	local num = tonumber(score.text)
        	score.text = num + 1
        end
		end 
    elseif ( event.phase == "ended" ) then
        
    end
    return true
end
rect:addEventListener( "touch", onObjectTouch )

local function onLocalCollision( self, event )
    self[2].text = "Crap"
    end
myGroup.collision = onLocalCollision
myGroup:addEventListener( "collision", myGroup )

physics.addBody( myGroup, { density=3.0, friction=0.5, bounce=0.2} )
--physics.addBody( rectText, { density=3.0, friction=0.5, bounce=0.2} )
