return function()
  local get_hex = require('core.util').get_hex
  local icons = require('core.icons')
  local theme_hl = require('core.helpers').theme_hl

  local harpoon = require('harpoon.mark')
  local mappings = require('cokeline.mappings')

  local separators = {
    left = icons.blocks.left[4],
    right = icons.blocks.left[4],
  }

  local Space = {
    text = ' ',
    truncation = { priority = 1 },
  }

  local Separator = {
    left = {
      text = separators.left,
      fg = function(buffer)
        if buffer.is_focused then
          return 'Function'
        else
          return 'LineNr'
        end
      end,
      bg = function(buffer)
        if buffer.is_focused then
          return 'ColorColumn'
        else
          return 'TabLine'
        end
      end,
    },
    right = {
      text = separators.right,
      fg = function(buffer)
        if buffer.is_focused then
          return get_hex('ColorColumn', 'bg')
        else
          return get_hex('TabLineFill', 'bg')
        end
      end,
      bg = function(buffer)
        if not buffer.is_focused then
          return get_hex('TabLineFill', 'bg')
        end
      end,
    },
  }

  local Devicon = {
    text = function(buffer)
      if mappings.is_picking_focus() or mappings.is_picking_close() then
        return buffer.pick_letter .. ' '
      end
      return buffer.devicon.icon
    end,
    fg = function(buffer)
      return (mappings.is_picking_focus() and 'DiagnosticWarn')
        or (mappings.is_picking_close() and 'DiagnosticError')
        or buffer.devicon.color
    end,
    italic = function(_)
      return mappings.is_picking_focus() or mappings.is_picking_close()
    end,
    bold = function(_)
      return mappings.is_picking_focus() or mappings.is_picking_close()
    end,
    truncation = { priority = 1 },
  }

  local Diagnostics
  Diagnostics = {
    text = function(buffer)
      return (buffer.diagnostics.errors ~= 0 and icons.diagnostics.Error .. buffer.diagnostics.errors .. ' ')
        or (buffer.diagnostics.warnings ~= 0 and icons.diagnostics.Warn .. buffer.diagnostics.warnings .. ' ')
        or ''
    end,
    fg = function(buffer)
      if buffer.is_focused then
        return (buffer.diagnostics.errors ~= 0 and 'DiagnosticError')
          or (buffer.diagnostics.warnings ~= 0 and 'DiagnosticWarn')
          or nil
      else
        return 'ModeMsg'
      end
    end,
    bg = function(buffer)
      if buffer.is_focused then
        return 'ColorColumn'
      else
        return 'TabLine'
      end
    end,
    truncation = { priority = 1 },
  }

  local UniquePrefix = {
    text = function(buffer)
      return buffer.unique_prefix
    end,
    fg = function(buffer)
      if buffer.is_focused then
        return 'ModeMsg'
      else
        return 'TabLine'
      end
    end,
    truncation = {
      priority = 3,
      direction = 'left',
    },
  }

  local Filename = {
    text = function(buffer)
      return buffer.filename
    end,
    bold = function(buffer)
      return buffer.is_focused
    end,
    italic = function(buffer)
      return not buffer.is_focused
    end,
    underline = function(buffer)
      return buffer.is_hovered and not buffer.is_focused
    end,
    sp = function(buffer)
      if buffer.diagnostics.errors ~= 0 then
        return 'DiagnosticError'
      elseif buffer.diagnostics.warnings ~= 0 then
        return 'DiagnosticWarn'
      elseif buffer.diagnostics.infos ~= 0 then
        return 'DiagnosticInfo'
      end
    end,
    fg = function(buffer)
      if buffer.is_focused then
        if buffer.diagnostics.errors ~= 0 then
          return 'DiagnosticError'
        elseif buffer.diagnostics.warnings ~= 0 then
          return 'DiagnosticWarn'
        elseif buffer.diagnostics.infos ~= 0 then
          return 'DiagnosticInfo'
        else
          return theme_hl('@field', 'Keyword')
        end
      else
        return 'ModeMsg'
      end
    end,
    truncation = {
      priority = 2,
      direction = 'right',
    },
  }

  local HarpoonIdx = {
    text = function(buffer)
      local marked = harpoon.status()
      local idx = harpoon.get_index_of(buffer.path)

      if marked and idx ~= nil then
        return ' ' .. icons.ui.Harpoon .. idx .. ' '
      end
      return ' '
    end,
    fg = 'ModeMsg',
  }

  local CloseOrUnsaved = {
    text = function(buffer)
      if buffer.is_hovered and buffer.is_modified then
        return icons.ui.Close .. ' '
      elseif not buffer.is_hovered and buffer.is_modified then
        return buffer.is_modified and (icons.ui.Modified .. ' ')
      else
        return icons.ui.Close .. ' '
      end
    end,
    fg = function(buffer)
      if buffer.is_modified and not buffer.is_hovered then
        return 'String'
      else
        return 'ModeMsg'
      end
    end,
    bold = true,
    truncation = { priority = 1 },
    on_click = function(_, _, _, _, buffer)
      local bd = require('mini.bufremove').delete
      if vim.bo.modified then
        local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
        if choice == 1 then -- Yes
          vim.cmd.write()
          bd(0)
        elseif choice == 2 then -- No
          bd(0, true)
        end
      else
        bd(0)
      end
    end,
  }

  local function harpoon_sorter()
    local cache = {}
    local setup = false

    local function marknum(buf, force)
      local b = cache[buf.number]
      if b == nil or force then
        b = harpoon.get_index_of(buf.path)
        cache[buf.number] = b
      end
      return b
    end

    ---@param a Buffer
    ---@param b Buffer
    -- Use this in `config.buffers.new_buffers_position`
    return function(a, b)
      -- Only run this if harpoon is loaded, otherwise just use the default sorting.
      -- This could be used to only run if a user has harpoon installed, but
      -- I'm mainly using it to avoid loading harpoon on UiEnter.
      local has_harpoon = package.loaded['harpoon'] ~= nil
      if not has_harpoon then
        return a._valid_index < b._valid_index
      elseif not setup then
        harpoon.on('changed', function()
          for _, buf in ipairs(require('cokeline.buffers').get_visible()) do
            cache[buf.number] = marknum(buf, true)
          end
        end)
        setup = true
      end
      -- switch the a and b._valid_index to place non-harpoon buffers on the left
      -- side of the tabline - this puts them on the right.
      local ma = marknum(a)
      local mb = marknum(b)
      if ma and not mb then
        return true
      elseif mb and not ma then
        return false
      elseif ma == nil and mb == nil then
        ma = a._valid_index
        mb = b._valid_index
      end
      return ma < mb
    end
  end

  local opts = {
    show_if_buffers_are_at_least = 2,
    buffers = {
      focus_on_delete = 'next',
      new_buffers_position = harpoon_sorter(),
      -- new_buffers_position = "next",
      delete_on_right_click = false,
    },
    fill_hl = 'TabLineFill',
    pick = {
      use_filename = true,
    },
    default_hl = {
      fg = function(buffer)
        return buffer.is_focused and 'Comment' or 'TabLine'
      end,
      bg = function(buffer)
        return buffer.is_focused and 'ColorColumn' or 'TabLineFill'
      end,
    },
    components = {
      Separator.left,
      HarpoonIdx,
      Devicon,
      UniquePrefix,
      Filename,
      Space,
      Diagnostics,
      CloseOrUnsaved,
      Separator.right,
    },
    sidebar = {
      filetype = { 'neo-tree', 'undotree' },
      components = {
        Separator.left,
        Space,
        {
          text = function(buffer)
            if buffer.filetype == 'undotree' then
              return 'UndoTree'
            elseif buffer.filetype == 'neo-tree' then
              return 'Neo-Tree'
            else
              return 'Sidebar'
            end
          end,
          bold = function(buffer)
            return buffer.is_focused
          end,
          fg = function(buffer)
            if buffer.is_focused then
              return theme_hl('@field', 'Keyword')
            else
              return 'TabLine'
            end
          end,
        },
        Separator.right,
      },
    },
  }

  require('cokeline').setup(opts)
end
