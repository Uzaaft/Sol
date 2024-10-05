const vaxis = @import("vaxis");
const colors = @import("../styles/colors.zig");
const Padding = @import("../types/padding.zig").Padding;

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

    var content = window.child(.{
        .x_off = opts.padding.x,
        .y_off = opts.padding.y,
    });

    _ = try content.printSegment(.{ .text = dummyEvents }, .{});

    const label = parent.child(.{});
    _ = try label.printSegment(.{ .text = opts.label, .style = .{ .fg = borderColor } }, .{ .col_offset = 2 });

    return window;
}
