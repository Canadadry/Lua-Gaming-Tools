require "Item"
require "Rectangle"
require "Image"
require "Text"
require "TouchArea"
require "Transform"
require "Column"
require "Row"
require "flux"


function example1()

  local item = 
  TouchArea{
    w = 640, h=480 ,
    visible = false,
    children = {
      Item{
        children={
          Rectangle{c={0,255,0,255}},
          Row{
            spacing = 20,
            children = {
              Rectangle{ x=100,y=100,c={255,0,0,255}},
              Rectangle{ x=100,y=100,c={255,0,0,255}},
              Rectangle{ x=100,y=100,c={255,0,0,255}},
              Rectangle{ x=100,y=100,c={255,0,0,255}},
              Rectangle{ x=100,y=100,c={255,0,0,255}},
              Rectangle{ x=100,y=100,c={255,0,0,255}},
              Rectangle{ x=100,y=100,c={255,0,0,255}}
          }
          }
        }
      }
    }
  }

  item.drag.target = item.children[1]
  item.drag.alongYAxis = false
  item.children[1].children[2].children[1].height=150
  item.children[1].children[2]:push(Rectangle{w=100,h=100})
  item.children[1].children[1]:anchorFill(item.children[1].children[2])

  return item
end

function example2()
local item =  Rectangle{ visible = false,x=400,y=100,c={255,0,0,255}}
  item:push(Rectangle{ x=100,y=100,r=45,c={255,0,0,255}})
  :push(Rectangle{ x=100,y=100,r=45,c={255,0,0,255}})
  :push(Rectangle{ x=100,y=100,r=45,c={255,0,0,255}})
  :push(Rectangle{ x=100,y=100,r=45,c={255,0,0,255}})
  :push(Rectangle{ x=100,y=100,r=45,c={255,0,0,255}})
  :push(Rectangle{ x=100,y=100,r=45,c={255,0,0,255}})
  :push(Rectangle{ x=100,y=100,r=45,c={255,0,0,255}})
  return item
end

function example3()
local item =  Rectangle({x=400,y=150,c={255,0,0,255}})
     local ta =  item:push(TouchArea())

      ta.onPressed:add(function (self) self.color={255,0,0,255} end,item)
      ta.onReleased:add(function (self) self.color={128,128,0,255} end,item)
      ta.drag.target =  item
return item
end


function example4()
  
  local item = Rectangle{color={255,0,0,255}}
  item.speedX = 120
  item.speedY = 105
  item.update = function (self,dt)
    self.x = self.x + self.speedX * dt
    self.y = self.y + self.speedX * dt
    if self.x < 0 or self.x > self.parent.width then self.speedX = -self.speedX end
    if self.y < 0 or self.y > self.parent.height then self.speedY = -self.speedY end
  end
  return item 
  end
  

Button = class()

function Button:init(param)
  param = param or {}
  Item.inherit(self)
  Item.init(self,param)
  self.type = "Button"
  self.triggered = signal.new()
  self:push(Rectangle{w=param.w,h=param.h,c={255,255,255,255}})
  self:push(Rectangle{x=5,y=5,w=param.w-10,h=param.h-10,c={255,255,255,255}})
  self:push(Text{w=param.w,h=param.h,text=param.buttonName or param.bN or "Button"})
  ta = self:push(TouchArea(param))
  ta.onPressed:add(function(button) button.children[2].color={255,0,0,255}end, self)
  ta.onReleased:add(function(button) button.children[2].color={255,255,255,255} button.triggered.dispatch() end, self)

end

ExampleSelectorButton =class()
function ExampleSelectorButton:init(num)
  Button.init(self,{w=100,h=50,bN="Example "..num})
  self.triggered:add(selectExample,num) 
end

function selectExample(id)
  print ("example ".. id.. " selected")
  exampleList[1].visible = false
  exampleList[2].visible = false
  exampleList[3].visible = false
  exampleList[4].visible = false
  exampleList[id].visible = true
end


function love.load()
  root = Column{
    spacing=10,
    children = {
      Row{
        spacing=10,
        children={ 
          ExampleSelectorButton(1),
          ExampleSelectorButton(2),
          ExampleSelectorButton(3),
          ExampleSelectorButton(4)
        }
      },
      Rectangle{
        x=5,y=5,
        width = 790,
        height=535,
        children={
          example1(),
          example2(),
          example3(),
          example4()
          }
      }
    }

}
exampleList = root.children[2].children
selectExample(1)

end

function love.update(dt)
  Flux.update(dt)
  root:update(dt)

end

function love.draw()
  Plateform.clear()
  root:render()
end