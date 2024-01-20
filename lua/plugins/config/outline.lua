return function()
  local icons = require('core.icons')

  local opts = {
    outline_items = {
      show_symbol_details = false,
    },
    outline_window = {
      auto_jump = true,
      jump_highlight_duration = 150,
      width = 20,
    },
    preview_window = {
      border = 'rounded',
    },
    symbol_folding = {
      autofold_depth = 1,
    },
    symbols = {
      icons = {
        Array = { icon = icons.kinds.Array, hl = '@constant' },
        Boolean = { icon = icons.kinds.Boolean, hl = '@boolean' },
        Class = { icon = icons.kinds.Class, hl = '@type' },
        Constant = { icon = icons.kinds.Constant, hl = '@constant' },
        Constructor = { icons.kinds.Constructor, hl = '@constructor' },
        Enum = { icon = icons.kinds.Enum, hl = '@type' },
        EnumMember = { icon = icons.kinds.EnumMember, hl = '@variable.member' },
        Event = { icon = icons.kinds.Event, hl = '@type' },
        Field = { icon = icons.kinds.Field, hl = '@variable.member' },
        File = { icon = icons.kinds.File, hl = '@text.uri' },
        Function = { icon = icons.kinds.Function, hl = '@function' },
        Interface = { icon = icons.kinds.Interface, hl = '@type' },
        Key = { icon = icons.kinds.Key, hl = '@type' },
        Method = { icon = icons.kinds.Function, hl = '@method' },
        Module = { icon = icons.kinds.Module, hl = '@module' },
        Namespace = { icon = icons.kinds.Namespace, hl = '@module' },
        Number = { icon = icons.kinds.Number, hl = '@number' },
        Null = { icon = icons.kinds.Null, hl = '@type' },
        Object = { icon = icons.kinds.Object, hl = '@type' },
        Operator = { icon = icons.kinds.Operator, hl = '@operator' },
        Property = { icon = icons.kinds.Property, hl = '@method' },
        String = { icon = icons.kinds.String, hl = '@string' },
        Struct = { icon = icons.kinds.Struct, hl = '@type' },
        TypeParameter = { icon = icons.kinds.TypeParameter, hl = '@parameter' },
        Variable = { icon = icons.kinds.Variable, hl = '@constant' },
      },
    },
  }

  require('outline').setup(opts)
end
