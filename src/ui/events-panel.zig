const vaxis = @import("vaxis");
const colors = @import("../styles/colors.zig");
const Padding = @import("../types/padding.zig").Padding;
const Label = @import("./components/label.zig");

const dummyEvents = @embedFile("../assets/dummy-events.txt");

pub const EventsPanelDrawOpts = struct {
    isActivePanel: bool = true,
    label: []const u8 = "Events",
    padding: Padding = .{ .x = 1, .y = 1 },
};

pub fn draw(parent: *vaxis.Window, opts: EventsPanelDrawOpts) !vaxis.Window {
    const borderColor = if (opts.isActivePanel)
        colors.activeBorderColor
    else
        colors.borderColor;

    var window = parent.child(.{
        .x_off = 0,
        .y_off = 0,
        .border = .{
            .where = .all,
            .style = .{ .fg = borderColor },
        },
    });
    _ = try Label.draw(parent, .{ .text = opts.label, .color = borderColor });

    var content = window.child(.{
        .x_off = opts.padding.x,
        .y_off = opts.padding.y,
    });

    _ = try content.printSegment(.{ .text = dummyEvents }, .{});

    return window;
}
