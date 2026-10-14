-- Generado por herramientas/mapas.py
return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 12,
  height = 9,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 10,
  nextobjectid = 9999,
  properties = {
    ["name"] = "Casa de Pablo",
    ["music"] = "casa_pablo",
    ["light"] = true
  },
  tilesets = {
    {
      name = "casa_pablo",
      firstgid = 1,
      filename = "../../tilesets/casa_pablo.tsx",
      exportfilename = "../../tilesets/casa_pablo.lua"
    }
  },
  layers = {
    {
      type = "tilelayer", x = 0, y = 0, width = 12, height = 9, id = 1, name = "tiles",
      class = "", visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {}, encoding = "lua",
      data = {
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
        5, 6, 6, 7, 6, 6, 6, 7, 6, 6, 6, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
      }
    },
    {
      type = "tilelayer", x = 0, y = 0, width = 12, height = 9, id = 2, name = "decoration",
      class = "", visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {}, encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 17, 18, 0, 0, 0, 0, 0, 23, 24, 0, 0,
        0, 25, 26, 0, 0, 0, 0, 0, 31, 32, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 13, 13, 0, 0, 0, 0, 0,
        0, 0, 0, 14, 0, 0, 0, 0, 0, 14, 0, 0,
        0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup", draworder = "topdown", id = 3, name = "collision", class = "",
      visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2, name = "", type = "", shape = "rectangle",
          x = 0, y = 0, width = 480, height = 80, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 3, name = "", type = "", shape = "rectangle",
          x = 0, y = 80, width = 120, height = 80, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 4, name = "", type = "", shape = "rectangle",
          x = 320, y = 80, width = 80, height = 80, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 5, name = "", type = "", shape = "rectangle",
          x = 440, y = 80, width = 40, height = 280, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 6, name = "", type = "", shape = "rectangle",
          x = 0, y = 160, width = 40, height = 200, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 7, name = "", type = "", shape = "rectangle",
          x = 40, y = 320, width = 400, height = 40, rotation = 0, visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup", draworder = "topdown", id = 4, name = "objects", class = "",
      visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 8, name = "pablo", type = "npc", shape = "rectangle",
          x = 320, y = 176, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "pablo_lw",
          ["facing"] = "up",
          ["turn"] = false
        }
        }
      }
    },
    {
      type = "objectgroup", draworder = "topdown", id = 5, name = "markers", class = "",
      visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 9, name = "spawn", type = "", shape = "rectangle",
          x = 220, y = 276, width = 0, height = 0, rotation = 0, visible = true,
          properties = {}
        }
      }
    }
  }
}
