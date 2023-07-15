# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List
from libqtile import bar, layout, widget, qtile, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
import os
import subprocess

from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration

mod = "mod4"              # Sets mod key to SUPER/WINDOWS
terminal = "alacritty"      # My terminal of choice
browser = "brave" # My browser of choice

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "p", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "q", lazy.spawn("betterlockscreen -l"), desc="Lock Desktop"),
    Key([mod], "r", lazy.spawn("rofi -show run"), desc='Run Launcher'),

    # Brightness and Volume Control
    Key([], 'XF86AudioRaiseVolume', lazy.spawn("amixer set 'Master' 10%+")),
    Key([], 'XF86AudioLowerVolume', lazy.spawn("amixer set 'Master' 10%-")),
    Key([], 'XF86AudioMute', lazy.spawn("amixer set Master toggle")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl -s set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl -s set 10%-")),

    # Toggle Fullscreen
    Key([mod], "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen",
    ),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

colors = [
            "#2E3440",
            "#3B4252",
            "#434C5E",
            "#4C566A",
            "#8FBCBB",
            "#88C0D0",
            "#81A1C1",
            "#5E81AC",
            "#BF616A",
            "#D08770",
            "#EBCB8B",
            "#A3BE8C",
            "#B48EAD",
            "#D8DEE9",
            "#E5E9F0",
            "#ECEFF4",
        ]

layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": colors[4],
                "border_normal": colors[3]
                }

layouts = [
    #layout.Columns(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme),
    layout.TreeTab(**layout_theme),
    layout.Zoomy(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.Tile(),
    # layout.VerticalTile(),
]

widget_defaults = dict(
    font="Fantasque Sans Mono",
    fontsize=24,
    padding=10,
)
extension_defaults = widget_defaults.copy()

def sep():
    return widget.Sep(linewidth=0, padding=4, background=colors[6])

def space():
    return widget.TextBox("  ")


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(foreground=colors[5]),
                widget.CurrentLayoutIcon(
                       custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons/layout-icons")],
                       foreground = colors[5],
                       background = colors[0],
                       padding = 0,
                       scale = 0.7
                       ),
                space(),
                sep(),
                widget.GroupBox(background=colors[2], highlight_method="text", active=colors[11], disable_drag = True, rounded=False, this_current_screen_border=colors[9], inactive=colors[5], urgent_alert_method="text", urgent_text=colors[8]),
                sep(),
                space(),
                widget.WindowName(foreground=colors[5]),
                sep(),
                widget.WidgetBox(widgets=[
                    widget.TextBox("NET:", background=colors[11], foreground=colors[0], mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + " --hold -t 'bar-nmtui' -o 'window.dimensions.lines=20' -o 'window.dimensions.columns=60' -e nmtui")}),
                    widget.NetGraph(background=colors[11], fill_color=colors[4], mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + " --hold -t 'bar-nmtui' -o 'window.dimensions.lines=20' -o 'window.dimensions.columns=60' -e nmtui")}),
                    widget.Net(background=colors[11], foreground=colors[0], mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + " --hold -t 'bar-nmtui' -o 'window.dimensions.lines=20' -o 'window.dimensions.columns=60' -e nmtui")}),
                ], background=colors[11], foreground=colors[0], text_open='  ', text_closed='  ', fontsize="40", close_button_location="right"),
                sep(),
                widget.WidgetBox(widgets=[
                    widget.TextBox("MEM:", background=colors[10], foreground=colors[0], mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + " --hold -t 'bar-htop' -e htop")}),
                    widget.MemoryGraph(background=colors[10], fill_color=colors[4], mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + " --hold -t 'bar-htop' -e htop")}),
                    widget.TextBox("CPU:", background=colors[10], foreground=colors[0], mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + " --hold -t 'bar-htop' -e htop")}),
                    widget.CPUGraph(background=colors[10], fill_color=colors[4], mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + " --hold -t 'bar-htop' -e htop")}),
                ], background=colors[10], foreground=colors[0], text_open=' 󰍛 ', text_closed=' 󰍛 ', fontsize="40", close_button_location="right"),
                sep(),
                widget.TextBox('󱄠', background=colors[9], foreground=colors[0], fontsize="40"),
                widget.Volume(background=colors[9], foreground=colors[0]), 
                sep(),
                widget.Battery(background = colors[12], foreground=colors[0], format="{percent:2.0%}"),
                widget.Battery(background = colors[12], foreground=colors[0], format="{char}", full_char='󰁹', charge_char='󱟠', discharge_char='󱟞', empty_char='󰂎', unknown_char='󱃍', fontsize="30"),
                sep(),
                widget.Clock(format='%m-%d-%Y %I:%M', background=colors[8], foreground=colors[0]),
                sep(),
                widget.TextBox('  ', background=colors[0], foreground=colors[15], fontsize="40")
            ],
            30,
            background=colors[0],
            opacity=1.0        ),
    ),
]



# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(**layout_theme,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="bar-htop"), # Htop for bar
        Match(title="bar-nmtui"), # Wifi for bar
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
