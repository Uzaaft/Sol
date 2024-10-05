const vaxis = @import("vaxis");
const colors = @import("../styles/colors.zig");

const dummyCalendar = @embedFile("../assets/dummy-calendar.txt");

pub const CalendarPanelDrawOpts = struct {
    isActivePanel: bool = false,
};

pub fn draw(win: *vaxis.Window, opts: CalendarPanelDrawOpts) !void {
    const calendarPanelBorderColor = if (opts.isActivePanel)
        colors.activeBorderColor
    else
        colors.borderColor;

    const window = win.child(.{
        .x_off = (win.width / 2) + 1,
        .y_off = 0,
        .width = .{ .limit = win.width / 2 },
        .border = .{
            .where = .all,
            .style = .{ .fg = calendarPanelBorderColor },
        },
    });
    _ = try window.printSegment(.{ .text = dummyCalendar }, .{});
}
