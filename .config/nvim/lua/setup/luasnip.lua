-- LuaSnip Setup
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/LuaSnip/"})
require("luasnip").config.set_config({ -- Setting LuaSnip config

    -- Enable autotriggered snippets
    enable_autosnippets = true,

    -- Use Tab (or some other key if you prefer) to trigger visual selection
    store_selection_keys = "<Tab>",

    -- Repeated Nodes update as you type
    update_events = "TextChanged,TextChangedI"
})
