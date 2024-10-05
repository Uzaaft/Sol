const vaxis = @import("vaxis");
const colors = @import("../styles/colors.zig");

const dummyEvents = @embedFile("../assets/dummy-events.txt");

pub const EventsPanelDrawOpts = struct {
    isActivePanel: bool = true,
};

pub fn draw(win: *vaxis.Window, opts: EventsPanelDrawOpts) void {
    const eventsPanelBorderColor = if (opts.isActivePanel)
        colors.activeBorderColor
    else
        colors.borderColor;

    const window = win.child(.{
        .x_off = 0,
        .y_off = 0,
        .width = .{ .limit = win.width / 2 },
        .border = .{
            .where = .all,
            .style = .{ .fg = eventsPanelBorderColor },
        },
    });

    _ = try window.printSegment(.{ .text = dummyEvents }, .{});
}
