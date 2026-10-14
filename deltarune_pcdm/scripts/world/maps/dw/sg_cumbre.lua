-- Generado por herramientas/mapas.py
return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 14,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 10,
  nextobjectid = 9999,
  properties = {
    ["name"] = "La Cumbre",
    ["music"] = "ruta_furrygrave"
  },
  tilesets = {
    {
      name = "noche",
      firstgid = 1,
      filename = "../../tilesets/noche.tsx",
      exportfilename = "../../tilesets/noche.lua"
    }
  },
  layers = {
    {
      type = "tilelayer", x = 0, y = 0, width = 16, height = 14, id = 1, name = "tiles",
      class = "", visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {}, encoding = "lua",
      data = {
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
        5, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
      }
    },
    {
      type = "tilelayer", x = 0, y = 0, width = 16, height = 14, id = 2, name = "decoration",
      class = "", visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {}, encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup", draworder = "topdown", id = 3, name = "collision", class = "",
      visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2, name = "", type = "", shape = "rectangle",
          x = 0, y = 0, width = 640, height = 80, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 3, name = "", type = "", shape = "rectangle",
          x = 0, y = 80, width = 40, height = 480, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 4, name = "", type = "", shape = "rectangle",
          x = 600, y = 80, width = 40, height = 480, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 5, name = "", type = "", shape = "rectangle",
          x = 40, y = 520, width = 560, height = 40, rotation = 0, visible = true,
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
          id = 6, name = "gabriel", type = "npc", shape = "rectangle",
          x = 320, y = 176, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "gabriel",
          ["facing"] = "down",
          ["turn"] = true
        }
        },
        {
          id = 7, name = "script", type = "script", shape = "rectangle",
          x = 120, y = 320, width = 400, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "furrygrave.gabriel",
          ["once"] = true
        }
        },
        {
          id = 8, name = "savepoint", type = "savepoint", shape = "rectangle",
          x = 200, y = 440, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
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
          x = 340, y = 476, width = 0, height = 0, rotation = 0, visible = true,
          properties = {}
        }
      }
    }
  }
}
