require "External-Lib/Class"
require "External-Lib/Signal"

Entity = class()

function Entity:inherit()
  self.render = Entity.render
  self.draw = Entity.draw
  self.push = Entity.push 
  self.update = Entity.update  
end

function Entity:init(param)
  param = param or {}
  self.onCreated   = Signal()
  self.onDestroyed = Signal()
  self.isDead = false
  self.type = param.type or "None"
  
  self.gamepad = param.gamepad
  self.physic  = param.physic
  self.view    = param.view
  self.body    = param.body

  if self.gamepad then self.gamepad.entity = self end 
  if self.physic  then self.physic.entity  = self end 
  if self.view    then self.view.entity    = self end 
  if self.body    then self.body.entity    = self end 
  
  self.components = {}

end 

function Entity:update(dt)
  if self.gamepad  then self.gamepad:update(dt) end
  if self.physic   then self.physic:update(dt) end
  if self.view     then self.view:update(dt) end
  
  for _,component in pairs(self.components) do if component.update then component:update(dt) end end
  
end 

function Entity:draw()
  if self.view  then self.view:draw() end
end 

function Entity:push(component,name)
  self.components[name or {}] = component
  component.entity = self
end

