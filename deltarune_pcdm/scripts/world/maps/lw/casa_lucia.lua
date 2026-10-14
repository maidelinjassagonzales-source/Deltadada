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
    ["name"] = "Habitación de Lucía",
    ["music"] = "casa_lucia",
    ["light"] = true
  },
  tilesets = {
    {
      name = "casa",
      firstgid = 1,
      filename = "../../tilesets/casa.tsx",
      exportfilename = "../../tilesets/casa.lua"
    }
  },
  layers = {
    {
      type = "tilelayer", x = 0, y = 0, width = 12, height = 10, id = 1, name = "tiles",
      class = "", visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {}, encoding = "lua",
      data = {
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
        5, 6, 7, 6, 7, 6, 6, 6, 6, 7, 6, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 5, 5, 5, 5, 4, 4, 5, 5, 5, 5, 5
      }
    },
    {
      type = "tilelayer", x = 0, y = 0, width = 12, height = 10, id = 2, name = "decoration",
      class = "", visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {}, encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 17, 18, 0, 0, 0, 0, 0, 0, 19, 20, 0,
        0, 25, 26, 0, 0, 0, 0, 0, 0, 27, 28, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 12, 0, 0, 0, 13, 13, 0, 0, 0, 10, 0,
        0, 0, 0, 0, 0, 13, 13, 0, 0, 0, 0, 0,
        0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
          x = 360, y = 80, width = 120, height = 80, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 5, name = "", type = "", shape = "rectangle",
          x = 0, y = 160, width = 40, height = 240, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 6, name = "", type = "", shape = "rectangle",
          x = 440, y = 160, width = 40, height = 240, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 7, name = "", type = "", shape = "rectangle",
          x = 40, y = 200, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 8, name = "", type = "", shape = "rectangle",
          x = 400, y = 200, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 9, name = "", type = "", shape = "rectangle",
          x = 40, y = 280, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 10, name = "", type = "", shape = "rectangle",
          x = 40, y = 360, width = 160, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 11, name = "", type = "", shape = "rectangle",
          x = 280, y = 360, width = 160, height = 40, rotation = 0, visible = true,
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
          id = 12, name = "deco", type = "deco", shape = "rectangle",
          x = 240, y = 0, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["texture"] = "objects/espejo",
          ["oy"] = 10,
          ["ox"] = -4,
          ["cutscene"] = "lw_lucia.espejo"
        }
        },
        {
          id = 13, name = "interactable", type = "interactable", shape = "rectangle",
          x = 240, y = 40, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_lucia.espejo"
        }
        },
        {
          id = 14, name = "interactable", type = "interactable", shape = "rectangle",
          x = 40, y = 80, width = 80, height = 80, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_lucia.cama"
        }
        },
        {
          id = 15, name = "interactable", type = "interactable", shape = "rectangle",
          x = 360, y = 80, width = 80, height = 80, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_lucia.armario"
        }
        },
        {
          id = 16, name = "interactable", type = "interactable", shape = "rectangle",
          x = 40, y = 200, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_lucia.mandarina"
        }
        },
        {
          id = 17, name = "interactable", type = "interactable", shape = "rectangle",
          x = 400, y = 200, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_lucia.pc"
        }
        },
        {
          id = 18, name = "interactable", type = "interactable", shape = "rectangle",
          x = 80, y = 40, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_lucia.poster"
        }
        },
        {
          id = 19, name = "interactable", type = "interactable", shape = "rectangle",
          x = 160, y = 40, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_lucia.poster"
        }
        },
        {
          id = 20, name = "interactable", type = "interactable", shape = "rectangle",
          x = 360, y = 40, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_lucia.poster"
        }
        },
        {
          id = 21, name = "interactable", type = "interactable", shape = "rectangle",
          x = 40, y = 280, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_lucia.estanteria"
        }
        },
        {
          id = 22, name = "transition", type = "transition", shape = "rectangle",
          x = 200, y = 360, width = 80, height = 40, rotation = 0, visible = true,
          properties = {
          ["map"] = "lw/calle",
          ["marker"] = "casa_lucia",
          ["facing"] = "down",
          ["cond"] = "pcdm_lucia_despierta"
        }
        },
        {
          id = 23, name = "script", type = "script", shape = "rectangle",
          x = 200, y = 320, width = 80, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_lucia.no_salir",
          ["once"] = false,
          ["cond"] = "not pcdm_lucia_despierta"
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
          id = 24, name = "spawn", type = "", shape = "rectangle",
          x = 140, y = 196, width = 0, height = 0, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 25, name = "puerta", type = "", shape = "rectangle",
          x = 220, y = 356, width = 0, height = 0, rotation = 0, visible = true,
          properties = {}
        }
      }
    }
  }
}
