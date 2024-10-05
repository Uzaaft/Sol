const vaxis = @import("vaxis");
const colors = @import("../styles/colors.zig");

const dummyEvents = @embedFile("../assets/dummy-events.txt");

pub const EventsPanelDrawOpts = struct {
    isActivePanel: bool = true,
};

pub fn draw(parent: *vaxis.Window, opts: EventsPanelDrawOpts) !vaxis.Window {
    const eventsPanelBorderColor = if (opts.isActivePanel)
        colors.activeBorderColor
    else
        colors.borderColor;

    var window = parent.child(.{
        .x_off = 0,
        .y_off = 0,
        .border = .{
            .where = .all,
            .style = .{ .fg = eventsPanelBorderColor },
        },
    });

    _ = try window.printSegment(.{ .text = dummyEvents }, .{});

    return window;
}
