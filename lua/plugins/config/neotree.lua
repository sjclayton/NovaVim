return function()
  local util = require('core.util')

  local function on_move(data)
    util.on_rename(data.source, data.destination)
  end

  local opts = {
    sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
    open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'Outline' },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      width = 35,
      mappings = {
        ['<space>'] = 'none',
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeIndentMarker',
      },
    },
  }

  local events = require('neo-tree.events')
  opts.event_handlers = opts.event_handlers or {}
  vim.list_extend(opts.event_handlers, {
    { event = events.FILE_MOVED, handler = on_move },
    { event = events.FILE_RENAMED, handler = on_move },
  })

  require('neo-tree').setup(opts)
end
