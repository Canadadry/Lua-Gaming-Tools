require "External-Lib/Class"
require "SceneGraph/Item"

Column=class()

function Column:inherit()
  self.geometryUpdated = self.geometryUpdated or Item.geometryUpdated
end

function Column:init(param)
  param = param or {}
  Item.inherit(self)
  Item.init(self,param)
  self.type = "Column"
  self.spacing = param.spacing or 10
  self.finished = true
  self:geometryUpdated()
end 

function Column:geometryUpdated()
  if self.finished == true then
    local currentPosY = 0
    local maxWidth = 0
    local i = 0
    for _,child in ipairs(self.children) do
      child.y = currentPosY
      currentPosY = currentPosY +  child.height + self.spacing
      if (child.width+child.x) > maxWidth then maxWidth = (child.width+child.x) end
    end
    self.height = currentPosY - self.spacing
    self.width = maxWidth
  end

end

function Column:childAdded(child)
  child.onXChanged:add(Column.geometryUpdated, self)
  child.onYChanged:add(Column.geometryUpdated, self)
  child.onWidthChanged:add(Column.geometryUpdated, self)
  child.onHeightChanged:add(Column.geometryUpdated, self)
  self:geometryUpdated()
end 


