require "External-Lib/Class"
require "External-Lib/Plateform"

View = class()

function View:init(param)
  param = param or {}
  self.entity = param.entity 
  self.sprite = param.sprite
  self.width , self.height = self.sprite:getDimensions()
  self.scale = param.scale or 1.0
  self.debugDraw= param.debug or false
  self.axisAligned = param.axisAligned or false
end

function View:update()
end

function View:draw()
  if self.entity.body then 
    Plateform.push()
    Plateform.translate(self.entity.body.x,self.entity.body.y)
    Plateform.scale(self.scale)
    
    if self.axisAligned  == false then 
    Plateform.rotate(self.entity.body.angle)
  end
    
    if self.entity.components.health and self.entity.components.health.invicible then 
      love.graphics.setColor({255,255,255,128}) 
    else
      love.graphics.setColor({255,255,255,255})
    end
    if self.debugDraw then love.graphics.circle("fill",0,0,self.entity.body.radius) end
    love.graphics.draw(self.sprite, -self.width/2,-self.height/2)
    Plateform.pop()
  end
end

