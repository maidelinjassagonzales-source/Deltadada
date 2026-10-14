-- Generado por herramientas/mapas.py
return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 12,
  height = 10,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 10,
  nextobjectid = 9999,
  properties = {
    ["name"] = "Habitación de Andrés",
    ["music"] = "casa_andres",
    ["light"] = true
  },
  tilesets = {
    {
      name = "casa_andres",
      firstgid = 1,
      filename = "../../tilesets/casa_andres.tsx",
      exportfilename = "../../tilesets/casa_andres.lua"
    }
  },
  layers = {
    {
      type = "tilelayer", x = 0, y = 0, width = 12, height = 10, id = 1, name = "tiles",
      class = "", visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {}, encoding = "lua",
      data = {
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
        5, 6, 6, 8, 6, 6, 6, 6, 6, 6, 6, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
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
      type = "tilelayer", x = 0, y = 0, width = 12, height = 10, id = 2, name = "decoration",
      class = "", visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {}, encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 21, 22, 0, 10, 11, 0, 0, 23, 24, 0, 0,
        0, 29, 30, 0, 0, 0, 0, 0, 31, 32, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 26, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
          x = 160, y = 80, width = 80, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 5, name = "", type = "", shape = "rectangle",
          x = 320, y = 80, width = 80, height = 80, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 6, name = "", type = "", shape = "rectangle",
          x = 440, y = 80, width = 40, height = 320, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 7, name = "", type = "", shape = "rectangle",
          x = 0, y = 160, width = 40, height = 240, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 8, name = "", type = "", shape = "rectangle",
          x = 360, y = 240, width = 80, height = 80, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 9, name = "", type = "", shape = "rectangle",
          x = 40, y = 360, width = 400, height = 40, rotation = 0, visible = true,
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
          id = 10, name = "deco", type = "deco", shape = "rectangle",
          x = 240, y = 0, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["texture"] = "objects/espejo",
          ["oy"] = 10,
          ["ox"] = -4
        }
        },
        {
          id = 11, name = "interactable", type = "interactable", shape = "rectangle",
          x = 240, y = 40, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_andres.espejo"
        }
        },
        {
          id = 12, name = "interactable", type = "interactable", shape = "rectangle",
          x = 120, y = 40, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_andres.poster"
        }
        },
        {
          id = 13, name = "interactable", type = "interactable", shape = "rectangle",
          x = 40, y = 80, width = 80, height = 80, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_andres.cosplay"
        }
        },
        {
          id = 14, name = "interactable", type = "interactable", shape = "rectangle",
          x = 160, y = 80, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_andres.tijeras"
        }
        },
        {
          id = 15, name = "interactable", type = "interactable", shape = "rectangle",
          x = 200, y = 80, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_andres.cajon"
        }
        },
        {
          id = 16, name = "interactable", type = "interactable", shape = "rectangle",
          x = 320, y = 80, width = 80, height = 80, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_andres.pc"
        }
        },
        {
          id = 17, name = "interactable", type = "interactable", shape = "rectangle",
          x = 360, y = 240, width = 80, height = 80, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_andres.movil"
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
          id = 18, name = "spawn", type = "", shape = "rectangle",
          x = 260, y = 236, width = 0, height = 0, rotation = 0, visible = true,
          properties = {}
        }
      }
    }
  }
}
