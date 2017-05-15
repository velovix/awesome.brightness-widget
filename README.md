# Brightness Widget
Provides a simple brightness widget for the Awesome window manager. It displays the current brightness with an icon and
allows you to adjust the brightness when you press the brightness up and down buttons on your keyboard, if you have
them.

### Dependencies
No extra Awesome libraries are required, but the widget does use the `xbacklight` command, so that or an equivalent
program of a different name must be installed. If it isn't `xbacklight`, you'll have to do some configuration.

### Setup
1. Navigate to your Awesome config directory (usually `~/.config/awesome`) and clone this repository with the following
command:

	```
	git clone https://github.com/velovix/awesome.brightness-widget
	```
2. Create a symlink for the brightness-widget.lua file. This is done so that your rc.lua can find the code, and so you can
update the widget by simply pulling in changes from this repository later. While still in the Awesome config directory,
run the following:

	```
	ln -s awesome.brightness-widget/brightness-widget.lua brightness-widget.lua
	```
3. In your rc.lua, add the following near the beginning of the file. This loads up the library and has you access it
through the new brightness_widget table we're creating.

	```
	local brightness_widget = require("brightness-widget")
	```
4. Add the following line near the beginning of your rc.lua, but after the line in the previous step. Providing an
empty table sets all configurations to their defaults. This should work for most users. See the configuration section
if you think you're special.

	```
	local brightness = brightness_widget:new({})
	```
5. Add the following lines near where other similar key bindings are being made in the rc.lua. This will allow you to
control brightness with your brightness keys on your keyboard.

	```
	awful.key({}, "XF86MonBrightnessDown", function() brightness:down() end),
	awful.key({}, "XF86MonBrightnessUp", function() brightness:up() end),
	```
6. Finally, to add your widget to the bar, you'll have to add the following line somewhere after the `right_layout`
table is created.

	```
	right_layout:add(brightness.widget)
	```
7. Restart Awesome WM and you're finished! You should see a white brightness icon on the top right of the screen!

### Configuration
For most cases, the default configuration will work fine. Unless you know for sure that you're different, you should
try this first and see what kind of results you get. If you do need special configuration options, there are six
provided. Feed them into your `new` function instead of the default empty table.

- **step**: The amount that the brightness should be incremented or decremented. The default is `5`.
- **cmd**: The command that will be run for brightness operations. The default is `xbacklight`.
- **inc**: The flag that should be passed to the program to signal that we're incrementing brightness. The default is
`-inc`.
- **dec**: The flag that should be passed to the program to signal that we're decrementing brightness. The default is
`-dec`.
- **set**: The flag that should be passed to the program to signal that we're setting brightness. The default is
`-set`.
- **get**: The flag that should be passed to the program to signal that we're getting brightness. The default is
`-get`.
