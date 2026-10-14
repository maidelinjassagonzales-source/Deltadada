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
    ["name"] = "Aula 2ºB",
    ["music"] = "aula",
    ["light"] = true
  },
  tilesets = {
    {
      name = "instituto",
      firstgid = 1,
      filename = "../../tilesets/instituto.tsx",
      exportfilename = "../../tilesets/instituto.lua"
    }
  },
  layers = {
    {
      type = "tilelayer", x = 0, y = 0, width = 16, height = 14, id = 1, name = "tiles",
      class = "", visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {}, encoding = "lua",
      data = {
        5, 5, 5, 5, 5, 5, 1, 1, 5, 5, 5, 5, 5, 5, 5, 5,
        5, 6, 8, 6, 7, 7, 1, 1, 6, 6, 7, 7, 6, 8, 8, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
      }
    },
    {
      type = "tilelayer", x = 0, y = 0, width = 16, height = 14, id = 2, name = "decoration",
      class = "", visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {}, encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 23, 24, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 31, 32, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 19, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 27, 28, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 25, 26, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 10, 0, 10, 0, 10, 0, 0, 10, 0, 10, 0, 10, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 10, 0, 10, 0, 10, 0, 0, 10, 0, 10, 0, 10, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 10, 0, 10, 0, 10, 0, 0, 10, 0, 10, 0, 10, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0,
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
          x = 0, y = 80, width = 120, height = 80, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 4, name = "", type = "", shape = "rectangle",
          x = 600, y = 80, width = 40, height = 480, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 5, name = "", type = "", shape = "rectangle",
          x = 280, y = 120, width = 80, height = 80, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 6, name = "", type = "", shape = "rectangle",
          x = 0, y = 160, width = 40, height = 240, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 7, name = "", type = "", shape = "rectangle",
          x = 80, y = 240, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 8, name = "", type = "", shape = "rectangle",
          x = 160, y = 240, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 9, name = "", type = "", shape = "rectangle",
          x = 240, y = 240, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 10, name = "", type = "", shape = "rectangle",
          x = 360, y = 240, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 11, name = "", type = "", shape = "rectangle",
          x = 440, y = 240, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 12, name = "", type = "", shape = "rectangle",
          x = 520, y = 240, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 13, name = "", type = "", shape = "rectangle",
          x = 80, y = 320, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 14, name = "", type = "", shape = "rectangle",
          x = 160, y = 320, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 15, name = "", type = "", shape = "rectangle",
          x = 240, y = 320, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 16, name = "", type = "", shape = "rectangle",
          x = 360, y = 320, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 17, name = "", type = "", shape = "rectangle",
          x = 440, y = 320, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 18, name = "", type = "", shape = "rectangle",
          x = 520, y = 320, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 19, name = "", type = "", shape = "rectangle",
          x = 80, y = 400, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 20, name = "", type = "", shape = "rectangle",
          x = 160, y = 400, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 21, name = "", type = "", shape = "rectangle",
          x = 240, y = 400, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 22, name = "", type = "", shape = "rectangle",
          x = 360, y = 400, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 23, name = "", type = "", shape = "rectangle",
          x = 440, y = 400, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 24, name = "", type = "", shape = "rectangle",
          x = 520, y = 400, width = 40, height = 40, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 25, name = "", type = "", shape = "rectangle",
          x = 0, y = 480, width = 40, height = 80, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 26, name = "", type = "", shape = "rectangle",
          x = 560, y = 480, width = 40, height = 80, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 27, name = "", type = "", shape = "rectangle",
          x = 40, y = 520, width = 520, height = 40, rotation = 0, visible = true,
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
          id = 28, name = "armario", type = "armario", shape = "rectangle",
          x = 520, y = 80, width = 80, height = 160, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 29, name = "yerover", type = "npc", shape = "rectangle",
          x = 80, y = 296, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "yerover_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.yerover",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 30, name = "gabriel", type = "npc", shape = "rectangle",
          x = 240, y = 296, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "gabriel_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.gabriel",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 31, name = "angel", type = "npc", shape = "rectangle",
          x = 360, y = 296, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "angel_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.angel",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 32, name = "alejandro", type = "npc", shape = "rectangle",
          x = 440, y = 296, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "alejandro_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.alejandro",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 33, name = "julio", type = "npc", shape = "rectangle",
          x = 520, y = 296, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "julio_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.julio",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 34, name = "isra", type = "npc", shape = "rectangle",
          x = 80, y = 376, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "isra_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.isra",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 35, name = "carmen", type = "npc", shape = "rectangle",
          x = 160, y = 376, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "carmen_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.carmen",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 36, name = "david", type = "npc", shape = "rectangle",
          x = 240, y = 376, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "david_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.david",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 37, name = "xibin", type = "npc", shape = "rectangle",
          x = 360, y = 376, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "xibin_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.xibin",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 38, name = "fernanda", type = "npc", shape = "rectangle",
          x = 440, y = 376, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "fernanda_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.fernanda",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 39, name = "brayan", type = "npc", shape = "rectangle",
          x = 520, y = 376, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "brayan_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.brayan",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 40, name = "pablo", type = "npc", shape = "rectangle",
          x = 80, y = 456, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "pablo_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.pablo",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 41, name = "dayron", type = "npc", shape = "rectangle",
          x = 160, y = 456, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "dayron_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.dayron",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 42, name = "angelpedro", type = "npc", shape = "rectangle",
          x = 240, y = 456, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "angelpedro_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.angelpedro",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 43, name = "andres", type = "npc", shape = "rectangle",
          x = 360, y = 456, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "andres_lw",
          ["facing"] = "up",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.andres",
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 44, name = "profe", type = "npc", shape = "rectangle",
          x = 200, y = 176, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["actor"] = "profe_lw",
          ["facing"] = "down",
          ["turn"] = true,
          ["cutscene"] = "lw_aula.profe",
          ["cond"] = "not pcdm_dia2 and not pcdm_final and not pcdm_profe_fuera"
        }
        },
        {
          id = 45, name = "interactable", type = "interactable", shape = "rectangle",
          x = 440, y = 400, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_aula.pupitre_vacio"
        }
        },
        {
          id = 46, name = "interactable", type = "interactable", shape = "rectangle",
          x = 520, y = 400, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_aula.pupitre_aridai"
        }
        },
        {
          id = 47, name = "interactable", type = "interactable", shape = "rectangle",
          x = 240, y = 0, width = 80, height = 80, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_aula.pizarra"
        }
        },
        {
          id = 48, name = "interactable", type = "interactable", shape = "rectangle",
          x = 280, y = 120, width = 80, height = 80, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_aula.mesa_profe"
        }
        },
        {
          id = 49, name = "script", type = "script", shape = "rectangle",
          x = 160, y = 280, width = 40, height = 40, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_aula.pablo",
          ["once"] = true,
          ["cond"] = "not pcdm_dia2 and not pcdm_final"
        }
        },
        {
          id = 50, name = "transition", type = "transition", shape = "rectangle",
          x = 0, y = 400, width = 40, height = 80, rotation = 0, visible = true,
          properties = {
          ["map"] = "lw/pasillo",
          ["marker"] = "aula",
          ["facing"] = "down",
          ["cond"] = "pcdm_puede_salir_aula"
        }
        },
        {
          id = 51, name = "script", type = "script", shape = "rectangle",
          x = 0, y = 400, width = 40, height = 80, rotation = 0, visible = true,
          properties = {
          ["cutscene"] = "lw_aula.no_salir",
          ["once"] = false,
          ["cond"] = "not pcdm_puede_salir_aula"
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
          id = 52, name = "spawn", type = "", shape = "rectangle",
          x = 180, y = 516, width = 0, height = 0, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 53, name = "puerta", type = "", shape = "rectangle",
          x = 60, y = 476, width = 0, height = 0, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 54, name = "asiento", type = "", shape = "rectangle",
          x = 180, y = 316, width = 0, height = 0, rotation = 0, visible = true,
          properties = {}
        },
        {
          id = 55, name = "armario", type = "", shape = "rectangle",
          x = 500, y = 276, width = 0, height = 0, rotation = 0, visible = true,
          properties = {}
        }
      }
    }
  }
}
